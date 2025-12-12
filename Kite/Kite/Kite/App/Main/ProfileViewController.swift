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
    //Profile Image
    private let userProfileImageView = UIView()
    private let profileImageView = UIImageView()
    private let dividerLine = UIView()
    
    //Username
    private let userNameView = UIView()
    private let userNameLabel = UILabel()
    private let fullNameView = UIView()
    private let fullNameLabel = UILabel()
    
    //User Groups, Friends and Posts
    private let userInfoView = UIView()
    private let userInfoBottomDivider = UIView()
    private let userInfoLeftView = UIView()
    private let userInfoLeftDivider = UIView()
    private let userMiddleLeftView = UIView()
    private let userInfoRightDivider = UIView()
    private let userRightLeftView = UIView()
    
    // User Info Labels
    private let userPostCountLabel = UILabel()
    private let userPostsLabel = UILabel()
    private let userGroupCountLabel = UILabel()
    private let userGroupLabel = UILabel()
    private let userFriendsCountLabel = UILabel()
    private let userFriendsLabel = UILabel()
    
    //User Biography 
    private let userSelectInfoView = UIView()
    private let userBiographyView = UIView()
    private let userBiographyLabel = UILabel()
    private let userBiographyTextArea = UITextView()
    private let userClothingLabel = UILabel()
    private let userClothingTextArea = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            await fetchUserCounts()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Refresh friends and counts when view appears
        Task {
            await getUserFriends()
            await fetchUserCounts()
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
            dividerLine.heightAnchor.constraint(equalToConstant: 0.0)
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
        view.addSubview(userInfoBottomDivider)
        
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoBottomDivider.backgroundColor = .systemGray4
        userInfoBottomDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 80),
            
            userInfoBottomDivider.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            userInfoBottomDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoBottomDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoBottomDivider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        setupUserInfoSubviews()
    }
    
    private func setupUserInfoSubviews() {
        userInfoView.addSubview(userInfoLeftView)
        userInfoView.addSubview(userInfoLeftDivider)
        userInfoView.addSubview(userMiddleLeftView)
        userInfoView.addSubview(userInfoRightDivider)
        userInfoView.addSubview(userRightLeftView)
        
        userInfoLeftView.translatesAutoresizingMaskIntoConstraints = false
        userInfoLeftDivider.translatesAutoresizingMaskIntoConstraints = false
        userMiddleLeftView.translatesAutoresizingMaskIntoConstraints = false
        userInfoRightDivider.translatesAutoresizingMaskIntoConstraints = false
        userRightLeftView.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoLeftDivider.backgroundColor = .systemGray4
        userInfoRightDivider.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            userInfoLeftView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userInfoLeftView.trailingAnchor.constraint(equalTo: userInfoLeftDivider.leadingAnchor),
            userInfoLeftView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            userInfoLeftView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            userInfoLeftView.widthAnchor.constraint(equalTo: userRightLeftView.widthAnchor),
            
            userInfoLeftDivider.leadingAnchor.constraint(equalTo: userInfoLeftView.trailingAnchor),
            userInfoLeftDivider.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 12),
            userInfoLeftDivider.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -8),
            userInfoLeftDivider.widthAnchor.constraint(equalToConstant: 2.0),
            
            userMiddleLeftView.leadingAnchor.constraint(equalTo: userInfoLeftDivider.trailingAnchor),
            userMiddleLeftView.trailingAnchor.constraint(equalTo: userInfoRightDivider.leadingAnchor),
            userMiddleLeftView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            userMiddleLeftView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            userMiddleLeftView.widthAnchor.constraint(equalToConstant: 100),
            
            userInfoRightDivider.leadingAnchor.constraint(equalTo: userMiddleLeftView.trailingAnchor),
            userInfoRightDivider.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 12),
            userInfoRightDivider.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -8),
            userInfoRightDivider.widthAnchor.constraint(equalToConstant: 2.0),
            
            userRightLeftView.leadingAnchor.constraint(equalTo: userInfoRightDivider.trailingAnchor),
            userRightLeftView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor),
            userRightLeftView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            userRightLeftView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor)
        ])
        
        setupUserInfoLabels()
    }
    
    private func setupUserInfoLabels() {
        // Configure count labels (top, bold, dark)
        [userPostCountLabel, userGroupCountLabel, userFriendsCountLabel].forEach { label in
            label.font = Style.mainDarkFont
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Configure text labels (bottom, regular, gray)
        [userPostsLabel, userGroupLabel, userFriendsLabel].forEach { label in
            label.font = Style.mainGrayFont
            label.textColor = .gray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Set initial text
        userPostCountLabel.text = "0"
        userPostsLabel.text = "Posts"
        userGroupCountLabel.text = "0"
        userGroupLabel.text = "Groups"
        userFriendsCountLabel.text = "0"
        userFriendsLabel.text = "Friends"
        
        // Add labels to their respective views
        userInfoLeftView.addSubview(userPostCountLabel)
        userInfoLeftView.addSubview(userPostsLabel)
        userMiddleLeftView.addSubview(userGroupCountLabel)
        userMiddleLeftView.addSubview(userGroupLabel)
        userRightLeftView.addSubview(userFriendsCountLabel)
        userRightLeftView.addSubview(userFriendsLabel)
        
        // Left view constraints (Posts)
        NSLayoutConstraint.activate([
            userPostCountLabel.centerXAnchor.constraint(equalTo: userInfoLeftView.centerXAnchor),
            userPostCountLabel.topAnchor.constraint(equalTo: userInfoLeftView.topAnchor, constant: 24),
            
            userPostsLabel.centerXAnchor.constraint(equalTo: userInfoLeftView.centerXAnchor),
            userPostsLabel.topAnchor.constraint(equalTo: userPostCountLabel.bottomAnchor, constant: 4),
            userPostsLabel.bottomAnchor.constraint(lessThanOrEqualTo: userInfoLeftView.bottomAnchor, constant: -12)
        ])
        
        // Middle view constraints (Groups)
        NSLayoutConstraint.activate([
            userGroupCountLabel.centerXAnchor.constraint(equalTo: userMiddleLeftView.centerXAnchor),
            userGroupCountLabel.topAnchor.constraint(equalTo: userMiddleLeftView.topAnchor, constant: 24),
            
            userGroupLabel.centerXAnchor.constraint(equalTo: userMiddleLeftView.centerXAnchor),
            userGroupLabel.topAnchor.constraint(equalTo: userGroupCountLabel.bottomAnchor, constant: 4),
            userGroupLabel.bottomAnchor.constraint(lessThanOrEqualTo: userMiddleLeftView.bottomAnchor, constant: -12)
        ])
        
        // Right view constraints (Friends)
        NSLayoutConstraint.activate([
            userFriendsCountLabel.centerXAnchor.constraint(equalTo: userRightLeftView.centerXAnchor),
            userFriendsCountLabel.topAnchor.constraint(equalTo: userRightLeftView.topAnchor, constant: 24),
            
            userFriendsLabel.centerXAnchor.constraint(equalTo: userRightLeftView.centerXAnchor),
            userFriendsLabel.topAnchor.constraint(equalTo: userFriendsCountLabel.bottomAnchor, constant: 4),
            userFriendsLabel.bottomAnchor.constraint(lessThanOrEqualTo: userRightLeftView.bottomAnchor, constant: -12)
        ])
    }
 
    func setupUserSelectInfoView() {
        view.addSubview(userSelectInfoView)
        userSelectInfoView.backgroundColor = .systemPurple
        userSelectInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userSelectInfoView.topAnchor.constraint(equalTo: userInfoBottomDivider.bottomAnchor),
            userSelectInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userSelectInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userSelectInfoView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
 
    func setupUserBiographyView() {
        view.addSubview(userBiographyView)
        userBiographyView.backgroundColor = .clear
        userBiographyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userBiographyView.topAnchor.constraint(equalTo: userSelectInfoView.bottomAnchor),
            userBiographyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userBiographyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userBiographyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Add labels and text areas
        userBiographyView.addSubview(userBiographyLabel)
        userBiographyView.addSubview(userBiographyTextArea)
        userBiographyView.addSubview(userClothingLabel)
        userBiographyView.addSubview(userClothingTextArea)
        
        // Configure Biography Label
        userBiographyLabel.text = "About Me"
        userBiographyLabel.textAlignment = .center
        userBiographyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Biography Text Area
        userBiographyTextArea.text = "biography"
        userBiographyTextArea.font = UIFont.systemFont(ofSize: 16)
        userBiographyTextArea.isScrollEnabled = false
        userBiographyTextArea.backgroundColor = .systemGray6
        userBiographyTextArea.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Clothing Label
        userClothingLabel.text = "Clothing Preferences"
        userClothingLabel.textAlignment = .center
        userClothingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Clothing Text Area
        userClothingTextArea.text = "clothing"
        userClothingTextArea.font = UIFont.systemFont(ofSize: 16)
        userClothingTextArea.isScrollEnabled = false
        userClothingTextArea.backgroundColor = .systemGray6
        userClothingTextArea.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints with 8px padding all around
        NSLayoutConstraint.activate([
            // Biography Label
            userBiographyLabel.topAnchor.constraint(equalTo: userBiographyView.topAnchor, constant: 8),
            userBiographyLabel.leadingAnchor.constraint(equalTo: userBiographyView.leadingAnchor, constant: 8),
            userBiographyLabel.trailingAnchor.constraint(equalTo: userBiographyView.trailingAnchor, constant: -8),
            
            // Biography Text Area
            userBiographyTextArea.topAnchor.constraint(equalTo: userBiographyLabel.bottomAnchor, constant: 8),
            userBiographyTextArea.leadingAnchor.constraint(equalTo: userBiographyView.leadingAnchor, constant: 8),
            userBiographyTextArea.trailingAnchor.constraint(equalTo: userBiographyView.trailingAnchor, constant: -8),
            userBiographyTextArea.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            // Clothing Label
            userClothingLabel.topAnchor.constraint(equalTo: userBiographyTextArea.bottomAnchor, constant: 8),
            userClothingLabel.leadingAnchor.constraint(equalTo: userBiographyView.leadingAnchor, constant: 8),
            userClothingLabel.trailingAnchor.constraint(equalTo: userBiographyView.trailingAnchor, constant: -8),
            
            // Clothing Text Area
            userClothingTextArea.topAnchor.constraint(equalTo: userClothingLabel.bottomAnchor, constant: 8),
            userClothingTextArea.leadingAnchor.constraint(equalTo: userBiographyView.leadingAnchor, constant: 8),
            userClothingTextArea.trailingAnchor.constraint(equalTo: userBiographyView.trailingAnchor, constant: -8),
            userClothingTextArea.bottomAnchor.constraint(lessThanOrEqualTo: userBiographyView.bottomAnchor, constant: -8),
            userClothingTextArea.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
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
    
    private func fetchUserCounts() async {
        let currentUsername = userDefaultManager.getLoggedInUser()
        let success = await UsersDataController.shared.fetchAndUpdateUserCounts(username: currentUsername)
        
        if success {
            // Update the currentUser reference to get the updated counts
            if let updatedUser = UsersDataController.shared.getUser(username: currentUsername) {
                self.currentUser = updatedUser
                
                DispatchQueue.main.async {
                    self.updateCountLabels()
                }
            }
        } else {
            print("Error: Failed to fetch user counts")
        }
    }
    
    private func updateCountLabels() {
        guard let user = currentUser else { return }
        
        // Display 0 in UI if count is -1 (not fetched), otherwise show actual count
        // Keep -1 in the User object, just display 0 in the UI
        userPostCountLabel.text = user.totalPosts >= 0 ? "\(user.totalPosts)" : "0"
        userGroupCountLabel.text = user.totalGroups >= 0 ? "\(user.totalGroups)" : "0"
        userFriendsCountLabel.text = user.totalFriends >= 0 ? "\(user.totalFriends)" : "0"
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
        
        // Update biography text area
        userBiographyTextArea.text = user.biography.isEmpty ? "biography" : user.biography
        
        // Update count labels if counts are available
        updateCountLabels()
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
