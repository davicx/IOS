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
        
        // Add action to Edit Button
        userProfileLayout.userProfileEditView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        userProfileLayout.userProfileSocialsView.followingButton.addTarget(self, action: #selector(followingButtonTapped), for: .touchUpInside)

        Task {
            do {
                userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if let statusCode = userResponseModel?.statusCode, statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                if let currentUser = userResponseModel?.data {
                    //STEP 1: Fetch image asynchronously before updating UI
                    let profileImage = await fetchImage(from: currentUser.userImage)

                    DispatchQueue.main.async {
                        //STEP 2: Set UI Elements
                        
                        //Step 2A: Set Username
                        self.userProfileLayout.userNameView.nameLabel.text = "@\(currentUser.userName)"
                        
                        //Step 2B: Set Image with fetched image
                        if let profileImage = profileImage {
                            if let croppedImage = profileImage.croppedToSquare() {
                                self.userProfileLayout.profileImageView.imageView.image = croppedImage
                            } else {
                                self.userProfileLayout.profileImageView.imageView.image = profileImage
                            }
                        } else {
                            self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
                        }

                        self.userProfileLayout.profileImageView.imageView.makeRounded()
                        
                        //Step 2C: Set first and last name
                        self.userProfileLayout.userProfileBiography.configure(
                            firstName: currentUser.firstName,
                            lastName: currentUser.lastName
                        )
                        
                    }
                }
            } catch {
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
                print(error)
            }
        }
    }

    @objc private func followingButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendVC = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! YourFriendsViewController

        Task {
            do {
                let currentUser = userDefaultManager.getLoggedInUser()
                let friendsResponse = try await friendAPI.getAllCurrentUserFriends(currentUser: currentUser)
                let friendObjects = friendAPI.convertToFriendObjects(from: friendsResponse.data)
        
                for friend in friendObjects {
                    print(friend.friendName)
                }
                
                DispatchQueue.main.async {
                    friendVC.users = friendObjects
                    self.navigationController?.pushViewController(friendVC, animated: true)
                }
            } catch {
                print("Error fetching friends: \(error)")
            }
        }
    }


    // EDIT: User Profile
    @objc private func editButtonTapped() {
        guard let userResponse = userResponseModel else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController

        // Send the existing data
        editProfileVC.inputFirstName = userResponse.data.firstName
        editProfileVC.inputLastName = userResponse.data.lastName
        editProfileVC.inputBiography = userResponse.data.biography

        if let profileImage = userProfileLayout.profileImageView.imageView.image {
            editProfileVC.inputProfileImage = profileImage
        }

        // **Set the delegate**
        editProfileVC.delegate = self

        navigationController?.pushViewController(editProfileVC, animated: true)
    }


}


extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        DispatchQueue.main.async {
            self.userProfileLayout.userProfileBiography.configure(
                firstName: firstName,
                lastName: lastName
            )
            
            //self.userProfileLayout.userProfileEditView.biographyLabel.text = biography
            
            // Update profile image if changed
            if let newImage = updatedImage {
                self.userProfileLayout.profileImageView.imageView.image = newImage
            }

            print("Profile updated: \(firstName), \(lastName)")
        }
    }
}

