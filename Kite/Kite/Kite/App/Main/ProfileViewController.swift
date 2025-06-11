//
//  ProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let friendAPI = FriendAPI()
    let loginAPI = LoginAPI()
    let imageFunctions = ImageFunctions()
    let userDefaultManager = UserDefaultManager()
    
    private let userProfileLayout = UserProfileLayout()
    
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add action to Buttons
        userProfileLayout.userProfileEditView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        userProfileLayout.userProfileSocialsView.viewFriendsButton.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)

        Task {
            do {
                let currentUser = userDefaultManager.getLoggedInUser()
                
                // Get profile
                userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                guard let statusCode = userResponseModel?.statusCode, statusCode != 401 else {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }

                if let currentUserData = userResponseModel?.data {
                    let profileImage = await imageFunctions.fetchImage(from: currentUserData.userImage)

                    DispatchQueue.main.async {
                        self.userProfileLayout.userNameView.nameLabel.text = "@\(currentUserData.userName)"
                        self.userProfileLayout.userProfileBiography.configure(
                            firstName: currentUserData.firstName,
                            lastName: currentUserData.lastName
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
                }

                // Fetch friends
                try await FriendDataController.shared.fetchFriends()

            } catch {
                print("Error in viewDidLoad: \(error)")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController")

        Task {
            do {
                try await FriendDataController.shared.fetchFriends()
            } catch {
                print("Error updating friend list: \(error)")
            }
        }
    }

    @objc private func friendsButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendVC = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! YourFriendsViewController
        //friendVC.delegate = self
        //friendVC.users = FriendDataController.shared.friends
        self.navigationController?.pushViewController(friendVC, animated: true)
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

    @objc private func editButtonTapped() {
        guard let userResponse = userResponseModel else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController

        editProfileVC.inputFirstName = userResponse.data.firstName
        editProfileVC.inputLastName = userResponse.data.lastName
        editProfileVC.inputBiography = userResponse.data.biography

        if let profileImage = userProfileLayout.profileImageView.imageView.image {
            editProfileVC.inputProfileImage = profileImage
        }

        editProfileVC.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}


// MARK: - EditProfileViewControllerDelegate

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        DispatchQueue.main.async {
            self.userProfileLayout.userProfileBiography.configure(
                firstName: firstName,
                lastName: lastName
            )

            if let newImage = updatedImage {
                self.userProfileLayout.profileImageView.imageView.image = newImage
            }

            print("Profile updated: \(firstName), \(lastName)")
        }
    }
}



