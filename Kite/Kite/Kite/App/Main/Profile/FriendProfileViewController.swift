//
//  FriendProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/20/25.
//

import UIKit


class FriendProfileViewController: UIViewController {
    var friend: Friend?
    let friendAPI = FriendAPI()
    let profileAPI = ProfileAPI()
    let imageFunctions = ImageFunctions()
    let userDefaultManager = UserDefaultManager()
    
    var friendListArray: [Friend] = []

    private let userProfileLayout = UserProfileLayout()
    private let currentUser: String

    init() {
        self.currentUser = userDefaultManager.getLoggedInUser()
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder: NSCoder) {
        self.currentUser = userDefaultManager.getLoggedInUser()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("FriendProfileViewController")

        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        userProfileLayout.userProfileSocialsView.viewFriendsButton.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)

        
        // Hide or disable buttons not relevant in friend profile
        userProfileLayout.userProfileEditView.editButton.isHidden = true

        if let friend = friend {
            //print("Friend profile for: \(friend.friendName)")
            Task {
                await fetchFriendDetails(friendName: friend.friendName)
            }
        }
    }
    
    
    //NAVIGATION: To their friends list
    @objc private func friendsButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendListVC = storyboard.instantiateViewController(withIdentifier: "FriendListViewController") as! FriendListViewController
        
        if let friendName = friend?.friendName {
            friendListVC.friendUserName = friendName
        }
        
        // Optionally: pass the list directly
        friendListVC.friendListArray = self.friendListArray
        
        self.navigationController?.pushViewController(friendListVC, animated: true)
    }

    
    //FRIEND DATA
    private func fetchFriendDetails(friendName: String) async {
        do {
            // Load friend's full profile
            let userProfileResponse = try await profileAPI.getUserProfileAPI(currentUser: friendName)
            let userData = userProfileResponse.data

            let profileImage = await imageFunctions.fetchImage(from: userData.userImage)

            DispatchQueue.main.async {
                self.userProfileLayout.userNameView.nameLabel.text = "@\(userData.userName)"
                self.userProfileLayout.userProfileBiography.configure(
                    firstName: userData.firstName,
                    lastName: userData.lastName
                )
                if let profileImage = profileImage {
                    if let cropped = profileImage.croppedToSquare() {
                        self.userProfileLayout.profileImageView.imageView.image = cropped
                    } else {
                        self.userProfileLayout.profileImageView.imageView.image = profileImage
                    }
                } else {
                    self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
                }
                self.userProfileLayout.profileImageView.imageView.makeRounded()
            }

            // Fetch the friend's friend list
            let friendsResponse = try await friendAPI.getSpecificFriendData(
                otherUser: friendName,
                currentUser: self.currentUser
            )
            let friends = friendAPI.convertToFriendObjects(from: friendsResponse.data)

            // Preload images
            await loadFriendImages(for: friends, using: imageFunctions)

            // Store it
            self.friendListArray = friends

        } catch {
            print("Failed to fetch friend's profile details: \(error)")
        }
    }
    
    func loadFriendImages(for friends: [Friend], using imageHelper: ImageFunctions) async {
        await withTaskGroup(of: Void.self) { group in
            for friend in friends {
                group.addTask {
                    if let image = await imageHelper.fetchImage(from: friend.friendImage) {
                        friend.profileImage = image
                    }
                }
            }
        }
    }


}


