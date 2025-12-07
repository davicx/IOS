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
    private let logoutButton = UIButton(type: .system)
  
    var userResponseModel: UserProfileResponseModel?
    var currentUser: User?
    var friends: [User] = []
    
    //UI ELEMENTS
    private let userProfileImageView = UIView()
    private let profileImageView = UIImageView()
    private let dividerLine = UIView()
    private let userNameView = UIView()
    private let userNameLabel = UILabel()
    private let fullNameView = UIView()
    private let fullNameLabel = UILabel()
    private let userInfoView = UIView()
    private let userSelectInfoView = UIView()
    private let userBiographyView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HIYA!")
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        print("USER: \(currentUser) \(deviceId)")
        
        setupNavigationBar()
        setupUserProfileImageView()
        setupUserNameView()
        setupFullNameView()
        setupUserInfoView()
        setupUserSelectInfoView()
        setupUserBiographyView()
        
        Task {
            await getUserInfo()
            await getUserFriends()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Refresh friends when view appears
        Task {
            await getUserFriends()
        }
    }
    

    //LAYOUT
    private func setupNavigationBar() {
        navigationItem.title = "Profile"

        let editProfileButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(editProfileButton)
        )
        navigationItem.rightBarButtonItem = editProfileButton

        if let image = UIImage(named: "user") {
            let circularImage = imageFunctions.makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
                .withRenderingMode(.alwaysOriginal)

            let profileButton = UIBarButtonItem(
                image: circularImage,
                style: .plain,
                target: self,
                action: #selector(openProfile)
            )
            navigationItem.leftBarButtonItem = profileButton
        }
    }
    
    func setupUserProfileImageView() {
        view.addSubview(userProfileImageView)
        userProfileImageView.backgroundColor = .clear
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.addSubview(profileImageView)
        
        dividerLine.backgroundColor = .systemGray4
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.addSubview(dividerLine)
        
        NSLayoutConstraint.activate([
            userProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileImageView.centerXAnchor.constraint(equalTo: userProfileImageView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            dividerLine.leadingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor),
            dividerLine.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func setupUserNameView() {
        view.addSubview(userNameView)
        userNameView.backgroundColor = .clear
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.font = Style.blackFont
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            userNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 24),
            
            userNameLabel.centerXAnchor.constraint(equalTo: userNameView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userNameView.topAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    func setupFullNameView() {
        view.addSubview(fullNameView)
        fullNameView.backgroundColor = .clear
        fullNameView.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameLabel.font = Style.grayFont
        fullNameLabel.textAlignment = .center
        fullNameLabel.textColor = Style.textDarkGray
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameView.addSubview(fullNameLabel)
        
        NSLayoutConstraint.activate([
            fullNameView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            fullNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullNameView.heightAnchor.constraint(equalToConstant: 20),
            
            fullNameLabel.centerXAnchor.constraint(equalTo: fullNameView.centerXAnchor),
            fullNameLabel.topAnchor.constraint(equalTo: fullNameView.topAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: fullNameView.bottomAnchor),
            fullNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
 
    func setupUserInfoView() {
        view.addSubview(userInfoView)
        userInfoView.backgroundColor = .systemOrange
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
 
    func setupUserSelectInfoView() {
        view.addSubview(userSelectInfoView)
        userSelectInfoView.backgroundColor = .systemPurple
        userSelectInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userSelectInfoView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            userSelectInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userSelectInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userSelectInfoView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
 
    func setupUserBiographyView() {
        view.addSubview(userBiographyView)
        userBiographyView.backgroundColor = .systemYellow
        userBiographyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userBiographyView.topAnchor.constraint(equalTo: userSelectInfoView.bottomAnchor),
            userBiographyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userBiographyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userBiographyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //ACTIONS
    @objc private func openProfile() {
        print("Profile tapped")
    }
    
    @objc private func editProfileButton() {
        print("Edit Profile")
    }
    
    
    //DATA FUNCTIONS
    private func getUserInfo() async {
        let currentUsername = userDefaultManager.getLoggedInUser()
        
        if let user = await UsersDataController.shared.getOrFetchUser(username: currentUsername) {
            self.currentUser = user
            
            DispatchQueue.main.async {
                self.updateUIWithUserInfo()
            }
        } else {
            print("Error: Failed to get user info")
        }
    }
    
    private func refreshUserInfo() async {
        let currentUsername = userDefaultManager.getLoggedInUser()
        
        // Force refresh by fetching from API (bypasses cache)
        if let user = await UsersDataController.shared.fetchUser(username: currentUsername) {
            self.currentUser = user
            
            DispatchQueue.main.async {
                self.updateUIWithUserInfo()
            }
        } else {
            print("Error: Failed to refresh user info")
        }
    }
    
    private func getUserFriends() async {
        do {
            _ = try await UsersDataController.shared.fetchFriends()
            self.friends = UsersDataController.shared.getFriends()
            
            print("Loaded \(self.friends.count) friends")
        } catch {
            print("Error fetching friends: \(error)")
        }
    }
    
    private func updateUIWithUserInfo() {
        guard let user = currentUser else { return }
        
        // Update profile image
        if let profileImage = user.profileImage {
            let circularImage = imageFunctions.makeCircularImage(
                image: profileImage,
                size: CGSize(width: 80, height: 80)
            )
            profileImageView.image = circularImage
        } else {
            // If image not loaded yet, fetch it
            Task {
                await user.fetchProfileImage()
                DispatchQueue.main.async {
                    if let profileImage = user.profileImage {
                        let circularImage = self.imageFunctions.makeCircularImage(
                            image: profileImage,
                            size: CGSize(width: 80, height: 80)
                        )
                        self.profileImageView.image = circularImage
                    } else {
                        // Fallback to placeholder
                        if let placeholderImage = UIImage(named: "user") {
                            let circularImage = self.imageFunctions.makeCircularImage(
                                image: placeholderImage,
                                size: CGSize(width: 80, height: 80)
                            )
                            self.profileImageView.image = circularImage
                        }
                    }
                }
            }
        }
        
        // Update username label
        userNameLabel.text = "@\(user.userName)"
        
        // Update full name label
        fullNameLabel.text = "\(user.firstName) \(user.lastName)".trimmingCharacters(in: .whitespaces)
    }

 


}


// MARK: - EditProfileViewControllerDelegate
extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Force refresh user info from API after profile update to ensure cache is updated
        Task {
            await refreshUserInfo()
        }
        
        DispatchQueue.main.async {
            // Update UI immediately with new data if available
            if let newImage = updatedImage {
                let circularImage = self.imageFunctions.makeCircularImage(
                    image: newImage,
                    size: CGSize(width: 80, height: 80)
                )
                self.profileImageView.image = circularImage
            }
            
            print("Profile updated: \(firstName), \(lastName)")
        }
    }
    
}


/*
 
 
 class ProfileViewController: UIViewController {
     let postsAPI = PostsAPI()
     let profileAPI = ProfileAPI()
     let friendAPI = FriendAPI()
     let loginAPI = LoginAPI()
     let imageFunctions = ImageFunctions()
     let userDefaultManager = UserDefaultManager()
     
     private let userProfileLayout = UserProfileLayout()
     private let logoutButton = UIButton(type: .system)
     
     var userResponseModel: UserProfileResponseModel?
     
     override func viewDidLoad() {
         super.viewDidLoad()

         let currentUser = userDefaultManager.getLoggedInUser()
         let deviceId = getDeviceId()
         
         view.addSubview(userProfileLayout)
         userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
         
         // Setup logout button
         logoutButton.setTitle("Logout", for: .normal)
         logoutButton.backgroundColor = .systemBlue
         logoutButton.setTitleColor(.white, for: .normal)
         logoutButton.layer.cornerRadius = 8
         logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
         
         view.addSubview(logoutButton)
         logoutButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             
             logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             logoutButton.heightAnchor.constraint(equalToConstant: 50),
             logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
                     LoginManager.shared.logoutCurrentUser()
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
                 _ = try await UsersDataController.shared.fetchFriends()

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
                 _ = try await UsersDataController.shared.fetchFriends()
             } catch {
                 print("Error updating friend list: \(error)")
             }
         }
     }

     @objc private func logoutButtonTapped() {
         Task {
             do {
                 let currentUser = userDefaultManager.getLoggedInUser()
                 let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? "UnknownDevice"

                 let logoutResponse = try await loginAPI.logoutUser(username: currentUser, deviceID: deviceID)
                 
                 if logoutResponse.success {
                     print("Logout successful!")
                     // Optional: Perform additional cleanup or navigate to the login screen
                     self.navigationController?.popToRootViewController(animated: true)
                     PresenterManager.shared.showOnboarding()
                     
                 } else {
                     print("Logout failed. Reason: \(logoutResponse.message ?? "Unknown error")")
                 }

             } catch {
                 print("Failed to logout: \(error.localizedDescription)")
             }
         }
     }

     @objc private func friendsButtonTapped() {
         let storyboard = UIStoryboard(name: "Profile", bundle: nil)
         let friendVC = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as! FriendsViewController
         //friendVC.delegate = self
         //friendVC.users = FriendDataController.shared.friends
         self.navigationController?.pushViewController(friendVC, animated: true)
     }
     
     

     func loadFriendImages(for friends: [User], using imageHelper: ImageFunctions) async {
         await withTaskGroup(of: Void.self) { group in
             for friend in friends {
                 group.addTask {
                     if let image = await imageHelper.fetchImage(from: friend.userImage) {
                         friend.profileImage = image
                     }
                 }
             }
         }
     }

     @objc private func editButtonTapped() {
         guard let userResponse = userResponseModel else { return }
         
         let storyboard = UIStoryboard(name: "Profile", bundle: nil)
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

 */
