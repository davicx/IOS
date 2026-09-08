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
    //HEADER: User Image Full Name, Username and User Info (posts, groups and friends)
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
    
    // User Information Cards for Post Count, Group Count and Friend Count
    private let postsCard = ProfileInfoPostsCard()
    private let groupsCard = ProfileInfoGroupsCard()
    private let friendsCard = ProfileInfoFriendsCard()
    
    //BODY — module slider + modules
    private let moduleSlider = ProfileModuleSlider()
    private let moduleContainerView = UIView()
    private let aboutMeModule = AboutMeModule()
    private let postListModule = PostList()
    private var moduleContainerHeightConstraint: NSLayoutConstraint!

    // Old bio/clothing UI (kept declared for later restore)
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
        setupFullNameView()
        setupUserNameView()
        setupUserInfoView()
        setupModuleSlider()
        setupModuleContainer()
        setupTempLogoutButton()
        
        // Observe user updates to refresh profile image when it loads
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUsersUpdated),
            name: .usersUpdated,
            object: nil
        )
        
        Task {
            await getUserInfo()
            await getUserFriends()
            await fetchUserCounts()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "ProfileViewController")
        
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
    
    func setupFullNameView() {
        view.addSubview(fullNameView)
        fullNameView.backgroundColor = .clear
        fullNameView.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameLabel.font = Fonts.profileFullNameFont
        fullNameLabel.textAlignment = .center
        fullNameLabel.textColor = Colors.profileFullNameTextColor
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameView.addSubview(fullNameLabel)
        
        NSLayoutConstraint.activate([
            fullNameView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            fullNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullNameView.heightAnchor.constraint(equalToConstant: 24),
            
            fullNameLabel.centerXAnchor.constraint(equalTo: fullNameView.centerXAnchor),
            fullNameLabel.topAnchor.constraint(equalTo: fullNameView.topAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: fullNameView.bottomAnchor),
            fullNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    func setupUserNameView() {
        view.addSubview(userNameView)
        userNameView.backgroundColor = .clear
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.font = Fonts.profileUserNameFont
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = Colors.profileUserNameTextColor
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: -4),
            userNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 20),
            
            userNameLabel.centerXAnchor.constraint(equalTo: userNameView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userNameView.topAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
 
    func setupUserInfoView() {
        view.addSubview(userInfoView)
        view.addSubview(userInfoBottomDivider)
        
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoBottomDivider.backgroundColor = .systemGray4
        userInfoBottomDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 60),
            
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
        
        setupUserInfoCards()
    }
    
    private func setupUserInfoCards() {
        [postsCard, groupsCard, friendsCard].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        userInfoLeftView.addSubview(postsCard)
        userMiddleLeftView.addSubview(groupsCard)
        userRightLeftView.addSubview(friendsCard)

        NSLayoutConstraint.activate([
            postsCard.topAnchor.constraint(equalTo: userInfoLeftView.topAnchor),
            postsCard.leadingAnchor.constraint(equalTo: userInfoLeftView.leadingAnchor),
            postsCard.trailingAnchor.constraint(equalTo: userInfoLeftView.trailingAnchor),
            postsCard.bottomAnchor.constraint(equalTo: userInfoLeftView.bottomAnchor),

            groupsCard.topAnchor.constraint(equalTo: userMiddleLeftView.topAnchor),
            groupsCard.leadingAnchor.constraint(equalTo: userMiddleLeftView.leadingAnchor),
            groupsCard.trailingAnchor.constraint(equalTo: userMiddleLeftView.trailingAnchor),
            groupsCard.bottomAnchor.constraint(equalTo: userMiddleLeftView.bottomAnchor),

            friendsCard.topAnchor.constraint(equalTo: userRightLeftView.topAnchor),
            friendsCard.leadingAnchor.constraint(equalTo: userRightLeftView.leadingAnchor),
            friendsCard.trailingAnchor.constraint(equalTo: userRightLeftView.trailingAnchor),
            friendsCard.bottomAnchor.constraint(equalTo: userRightLeftView.bottomAnchor)
        ])

        let friendsTap = UITapGestureRecognizer(target: self, action: #selector(friendsCountTapped))
        friendsCard.addGestureRecognizer(friendsTap)
    }
 
    func setupModuleSlider() {
        view.addSubview(moduleSlider)
        moduleSlider.onSelectionChanged = { [weak self] index in
            self?.showModule(at: index)
        }

        NSLayoutConstraint.activate([
            moduleSlider.topAnchor.constraint(equalTo: userInfoBottomDivider.bottomAnchor),
            moduleSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moduleSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupModuleContainer() {
        view.addSubview(moduleContainerView)
        moduleContainerView.translatesAutoresizingMaskIntoConstraints = false
        moduleContainerView.backgroundColor = Colors.feedBackground

        moduleContainerView.addSubview(aboutMeModule)
        moduleContainerView.addSubview(postListModule)

        moduleContainerHeightConstraint = moduleContainerView.heightAnchor.constraint(equalToConstant: 140)

        NSLayoutConstraint.activate([
            aboutMeModule.topAnchor.constraint(equalTo: moduleContainerView.topAnchor),
            aboutMeModule.leadingAnchor.constraint(equalTo: moduleContainerView.leadingAnchor),
            aboutMeModule.trailingAnchor.constraint(equalTo: moduleContainerView.trailingAnchor),

            postListModule.topAnchor.constraint(equalTo: moduleContainerView.topAnchor),
            postListModule.leadingAnchor.constraint(equalTo: moduleContainerView.leadingAnchor),
            postListModule.trailingAnchor.constraint(equalTo: moduleContainerView.trailingAnchor),
            postListModule.heightAnchor.constraint(equalToConstant: 140),

            moduleContainerView.topAnchor.constraint(equalTo: moduleSlider.bottomAnchor),
            moduleContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moduleContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moduleContainerHeightConstraint
        ])

        showModule(at: 0)
    }

    private func showModule(at index: Int) {
        aboutMeModule.isHidden = index != 0
        postListModule.isHidden = index != 1
        updateModuleContainerHeight(for: index)
    }

    private func updateModuleContainerHeight(for index: Int) {
        if index == 0 {
            let width = moduleContainerView.bounds.width > 0
                ? moduleContainerView.bounds.width
                : view.bounds.width
            let size = aboutMeModule.systemLayoutSizeFitting(
                CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            moduleContainerHeightConstraint.constant = max(size.height, 1)
        } else {
            moduleContainerHeightConstraint.constant = 140
        }
    }

    //TEMP: Logout button at bottom
    private func setupTempLogoutButton() {
        logoutButton.setTitle("Temp Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(tempLogoutTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            moduleContainerView.bottomAnchor.constraint(lessThanOrEqualTo: logoutButton.topAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    //ACTIONS
    @objc private func openProfile() {
        print("Profile tapped")
    }
    
    @objc private func friendsCountTapped() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let friendsVC = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as? FriendsViewController else { return }
        navigationController?.pushViewController(friendsVC, animated: true)
    }
    
    @objc private func editProfileButton() {
        print("Edit Profile")
    }

    @objc private func tempLogoutTapped() {
        LoginManager.shared.logoutCurrentUser()
    }
    
    @objc private func handleUsersUpdated() {
        // Refresh current user from cache to get updated profile image
        let currentUsername = userDefaultManager.getLoggedInUser()
        if let updatedUser = UsersDataController.shared.getUser(username: currentUsername) {
            // Update local reference
            self.currentUser = updatedUser
            
            // Update profile image if it's now available
            if let profileImage = updatedUser.profileImage {
                let circularImage = imageFunctions.makeCircularImage(
                    image: profileImage,
                    size: CGSize(width: 80, height: 80)
                )
                profileImageView.image = circularImage
            }
        }
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
        postsCard.configure(count: user.totalPosts)
        groupsCard.configure(count: user.totalGroups)
        friendsCard.configure(count: user.totalFriends)
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
            // If image not loaded yet, try fetching it
            // Note: UsersDataController may also be fetching it in background,
            // so we'll get notified via .usersUpdated when it's ready
            Task {
                await user.fetchProfileImage()
                DispatchQueue.main.async {
                    // Refresh from cache to get the latest user data
                    let currentUsername = self.userDefaultManager.getLoggedInUser()
                    if let updatedUser = UsersDataController.shared.getUser(username: currentUsername),
                       let profileImage = updatedUser.profileImage {
                        let circularImage = self.imageFunctions.makeCircularImage(
                            image: profileImage,
                            size: CGSize(width: 80, height: 80)
                        )
                        self.profileImageView.image = circularImage
                        // Update local reference
                        self.currentUser = updatedUser
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
        aboutMeModule.configure(biography: user.biography)
        updateModuleContainerHeight(for: moduleSlider.selectedIndex)
        
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
    var currentUser: User?
    var friends: [User] = []
    
    //UI ELEMENTS
    //HEADER: User Image Full Name, Username and User Info (posts, groups and friends)
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
    
    // User Information Cards for Post Count, Group Count and Friend Count
    private let postsCard = ProfileInfoPostsCard()
    private let groupsCard = ProfileInfoGroupsCard()
    private let friendsCard = ProfileInfoFriendsCard()
    
    //BODY
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
        setupFullNameView()
        setupUserNameView()
        setupUserInfoView()
        setupUserSelectInfoView()
        setupUserBiographyView()
        setupTempLogoutButton()
        
        // Observe user updates to refresh profile image when it loads
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUsersUpdated),
            name: .usersUpdated,
            object: nil
        )
        
        Task {
            await getUserInfo()
            await getUserFriends()
            await fetchUserCounts()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "ProfileViewController")
        
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
    
    func setupFullNameView() {
        view.addSubview(fullNameView)
        fullNameView.backgroundColor = .clear
        fullNameView.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameLabel.font = Fonts.profileFullNameFont
        fullNameLabel.textAlignment = .center
        fullNameLabel.textColor = Colors.profileFullNameTextColor
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameView.addSubview(fullNameLabel)
        
        NSLayoutConstraint.activate([
            fullNameView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            fullNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullNameView.heightAnchor.constraint(equalToConstant: 24),
            
            fullNameLabel.centerXAnchor.constraint(equalTo: fullNameView.centerXAnchor),
            fullNameLabel.topAnchor.constraint(equalTo: fullNameView.topAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: fullNameView.bottomAnchor),
            fullNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    func setupUserNameView() {
        view.addSubview(userNameView)
        userNameView.backgroundColor = .clear
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.font = Fonts.profileUserNameFont
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = Colors.profileUserNameTextColor
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: -4),
            userNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 20),
            
            userNameLabel.centerXAnchor.constraint(equalTo: userNameView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userNameView.topAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
 
    func setupUserInfoView() {
        view.addSubview(userInfoView)
        view.addSubview(userInfoBottomDivider)
        
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoBottomDivider.backgroundColor = .systemGray4
        userInfoBottomDivider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 60),
            
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
        
        setupUserInfoCards()
    }
    
    private func setupUserInfoCards() {
        [postsCard, groupsCard, friendsCard].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        userInfoLeftView.addSubview(postsCard)
        userMiddleLeftView.addSubview(groupsCard)
        userRightLeftView.addSubview(friendsCard)

        NSLayoutConstraint.activate([
            postsCard.topAnchor.constraint(equalTo: userInfoLeftView.topAnchor),
            postsCard.leadingAnchor.constraint(equalTo: userInfoLeftView.leadingAnchor),
            postsCard.trailingAnchor.constraint(equalTo: userInfoLeftView.trailingAnchor),
            postsCard.bottomAnchor.constraint(equalTo: userInfoLeftView.bottomAnchor),

            groupsCard.topAnchor.constraint(equalTo: userMiddleLeftView.topAnchor),
            groupsCard.leadingAnchor.constraint(equalTo: userMiddleLeftView.leadingAnchor),
            groupsCard.trailingAnchor.constraint(equalTo: userMiddleLeftView.trailingAnchor),
            groupsCard.bottomAnchor.constraint(equalTo: userMiddleLeftView.bottomAnchor),

            friendsCard.topAnchor.constraint(equalTo: userRightLeftView.topAnchor),
            friendsCard.leadingAnchor.constraint(equalTo: userRightLeftView.leadingAnchor),
            friendsCard.trailingAnchor.constraint(equalTo: userRightLeftView.trailingAnchor),
            friendsCard.bottomAnchor.constraint(equalTo: userRightLeftView.bottomAnchor)
        ])

        let friendsTap = UITapGestureRecognizer(target: self, action: #selector(friendsCountTapped))
        friendsCard.addGestureRecognizer(friendsTap)
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
            userBiographyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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

    //TEMP: Logout button at bottom
    private func setupTempLogoutButton() {
        logoutButton.setTitle("Temp Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(tempLogoutTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            userBiographyView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    //ACTIONS
    @objc private func openProfile() {
        print("Profile tapped")
    }
    
    @objc private func friendsCountTapped() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let friendsVC = storyboard.instantiateViewController(withIdentifier: "FriendViewController") as? FriendsViewController else { return }
        navigationController?.pushViewController(friendsVC, animated: true)
    }
    
    @objc private func editProfileButton() {
        print("Edit Profile")
    }

    @objc private func tempLogoutTapped() {
        LoginManager.shared.logoutCurrentUser()
    }
    
    @objc private func handleUsersUpdated() {
        // Refresh current user from cache to get updated profile image
        let currentUsername = userDefaultManager.getLoggedInUser()
        if let updatedUser = UsersDataController.shared.getUser(username: currentUsername) {
            // Update local reference
            self.currentUser = updatedUser
            
            // Update profile image if it's now available
            if let profileImage = updatedUser.profileImage {
                let circularImage = imageFunctions.makeCircularImage(
                    image: profileImage,
                    size: CGSize(width: 80, height: 80)
                )
                profileImageView.image = circularImage
            }
        }
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
        postsCard.configure(count: user.totalPosts)
        groupsCard.configure(count: user.totalGroups)
        friendsCard.configure(count: user.totalFriends)
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
            // If image not loaded yet, try fetching it
            // Note: UsersDataController may also be fetching it in background,
            // so we'll get notified via .usersUpdated when it's ready
            Task {
                await user.fetchProfileImage()
                DispatchQueue.main.async {
                    // Refresh from cache to get the latest user data
                    let currentUsername = self.userDefaultManager.getLoggedInUser()
                    if let updatedUser = UsersDataController.shared.getUser(username: currentUsername),
                       let profileImage = updatedUser.profileImage {
                        let circularImage = self.imageFunctions.makeCircularImage(
                            image: profileImage,
                            size: CGSize(width: 80, height: 80)
                        )
                        self.profileImageView.image = circularImage
                        // Update local reference
                        self.currentUser = updatedUser
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
*/
