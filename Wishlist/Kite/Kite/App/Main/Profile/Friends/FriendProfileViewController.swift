//
//  FriendProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/20/25.
//

import UIKit


class FriendProfileViewController: UIViewController {
    var friend: User?

    private let groupsAPI = GroupsAPI()
    private let friendAPI = FriendAPI()
    private let imageFunctions = ImageFunctions()
    private let userDefaultManager = UserDefaultManager()
    private let currentUser: String

    private var profileUser: User?
    private var friendListArray: [User] = []

    private let userProfileImageView = UIView()
    private let profileImageView = UIImageView()
    private let dividerLine = UIView()

    private let userNameView = UIView()
    private let userNameLabel = UILabel()
    private let fullNameView = UIView()
    private let fullNameLabel = UILabel()

    private let userInfoView = UIView()
    private let userInfoBottomDivider = UIView()
    private let userInfoLeftView = UIView()
    private let userInfoLeftDivider = UIView()
    private let userMiddleLeftView = UIView()
    private let userInfoRightDivider = UIView()
    private let userRightLeftView = UIView()

    private let postsCard = ProfileInfoPostsCard()
    private let groupsCard = ProfileInfoGroupsCard()
    private let friendsCard = ProfileInfoFriendsCard()

    private let contentTabs = ProfileContentTabs()
    private let moduleContainerView = UIView()
    private let aboutMeModule = AboutMeModule()
    private let itemList = ItemList()
    private let listModule = ListModule()

    private enum ProfileTab {
        case aboutMe
        case content
    }

    private enum ProfileContent {
        case items
        case lists
    }

    private var selectedTab: ProfileTab = .aboutMe
    private var contentKind: ProfileContent = .items
    private var listsLoadID = 0
    private var memberProfilesTask: Task<Void, Never>?
    private var didLoadItems = false

    private var profileUserName: String {
        profileUser?.userName ?? friend?.userName ?? ""
    }

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
        view.backgroundColor = .systemBackground

        setupUserProfileImageView()
        setupFullNameView()
        setupUserNameView()
        setupUserInfoView()
        setupModuleContainer()

        aboutMeModule.setLogoutHidden(true)
        aboutMeModule.setEditHidden(true)

        itemList.onItemSelected = { [weak self] post in
            self?.openItem(post)
        }
        listModule.onListSelected = { [weak self] list in
            self?.openList(list)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUsersUpdated),
            name: .usersUpdated,
            object: nil
        )

        guard !profileUserName.isEmpty else { return }

        navigationItem.title = friend?.displayName ?? profileUserName

        Task {
            await getUserInfo()
            await fetchUserCounts()
            await fetchUserPreferences()
            await fetchFriendList()
            loadProfileLists()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "FriendProfileViewController")

        guard !profileUserName.isEmpty else { return }
        Task {
            await fetchUserCounts()
            await fetchFriendList()
        }
    }

    func setupUserProfileImageView() {
        view.addSubview(userProfileImageView)
        userProfileImageView.backgroundColor = .clear
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageStyle.userProfileImage(imageView: profileImageView, diameter: 80)
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

        postsCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemsCountTapped)))
        groupsCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(listsCountTapped)))
        friendsCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(friendsCountTapped)))
    }

    func setupModuleContainer() {
        view.addSubview(contentTabs)
        contentTabs.onSelectionChanged = { [weak self] index in
            self?.contentTabSelected(index)
        }

        view.addSubview(moduleContainerView)
        moduleContainerView.translatesAutoresizingMaskIntoConstraints = false
        moduleContainerView.backgroundColor = Colors.feedBackground
        moduleContainerView.clipsToBounds = true

        moduleContainerView.addSubview(aboutMeModule)
        moduleContainerView.addSubview(itemList)
        moduleContainerView.addSubview(listModule)

        NSLayoutConstraint.activate([
            contentTabs.topAnchor.constraint(equalTo: userInfoBottomDivider.bottomAnchor, constant: 4),
            contentTabs.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTabs.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            moduleContainerView.topAnchor.constraint(equalTo: contentTabs.bottomAnchor),
            moduleContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moduleContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moduleContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            aboutMeModule.topAnchor.constraint(equalTo: moduleContainerView.topAnchor),
            aboutMeModule.leadingAnchor.constraint(equalTo: moduleContainerView.leadingAnchor),
            aboutMeModule.trailingAnchor.constraint(equalTo: moduleContainerView.trailingAnchor),
            aboutMeModule.bottomAnchor.constraint(equalTo: moduleContainerView.bottomAnchor),

            itemList.topAnchor.constraint(equalTo: moduleContainerView.topAnchor),
            itemList.leadingAnchor.constraint(equalTo: moduleContainerView.leadingAnchor),
            itemList.trailingAnchor.constraint(equalTo: moduleContainerView.trailingAnchor),
            itemList.bottomAnchor.constraint(equalTo: moduleContainerView.bottomAnchor),

            listModule.topAnchor.constraint(equalTo: moduleContainerView.topAnchor),
            listModule.leadingAnchor.constraint(equalTo: moduleContainerView.leadingAnchor),
            listModule.trailingAnchor.constraint(equalTo: moduleContainerView.trailingAnchor),
            listModule.bottomAnchor.constraint(equalTo: moduleContainerView.bottomAnchor)
        ])

        itemList.configure(posts: [])
        showModule(at: 0)
    }

    private func showModule(at index: Int) {
        selectedTab = index == 0 ? .aboutMe : .content
        contentTabs.setSelectedIndex(index == 0 ? 0 : 1, animated: false)
        updateModuleVisibility()
    }

    private func contentTabSelected(_ index: Int) {
        selectedTab = index == 0 ? .aboutMe : .content
        updateModuleVisibility()
        if selectedTab == .content {
            loadVisibleContent()
        }
    }

    private func updateModuleVisibility() {
        let showingItems = selectedTab == .content && contentKind == .items
        let showingLists = selectedTab == .content && contentKind == .lists
        aboutMeModule.isHidden = selectedTab != .aboutMe
        itemList.isHidden = !showingItems
        listModule.isHidden = !showingLists
    }

    private func showContent(_ kind: ProfileContent) {
        let animateUnderline = selectedTab != .content
        contentKind = kind
        selectedTab = .content
        contentTabs.setSelectedIndex(1, animated: animateUnderline)
        updateModuleVisibility()
        loadVisibleContent()
    }

    @objc private func itemsCountTapped() {
        showContent(.items)
    }

    @objc private func listsCountTapped() {
        showContent(.lists)
    }

    @objc private func friendsCountTapped() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        guard let friendListVC = storyboard.instantiateViewController(withIdentifier: "FriendListViewController") as? FriendListViewController else { return }
        friendListVC.friendUserName = profileUserName
        friendListVC.friendListArray = friendListArray
        navigationController?.pushViewController(friendListVC, animated: true)
    }

    private func openItem(_ post: Post) {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        guard let postViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualPostViewControllerID) as? IndividualPostViewController else { return }

        postViewController.postID = post.postID
        if let groupID = post.groupID,
           let group = GroupDataController.shared.getGroup(by: String(groupID)) {
            postViewController.currentUserOwnsGroup = (group.createdBy ?? "")
                .caseInsensitiveCompare(currentUser) == .orderedSame
        }
        navigationController?.pushViewController(postViewController, animated: true)
    }

    private func openList(_ group: GroupModel) {
        let storyboard = UIStoryboard(name: Constants.StoryboardNames.groupsStoryboard, bundle: nil)
        guard let groupViewController = storyboard.instantiateViewController(
            withIdentifier: Constants.StoryboardID.individualGroupViewControllerID
        ) as? IndividualGroupViewController else { return }

        groupViewController.groupID = group.groupID
        groupViewController.currentUserOwnsGroup = (group.createdBy ?? "")
            .caseInsensitiveCompare(currentUser) == .orderedSame
        navigationController?.pushViewController(groupViewController, animated: true)
    }

    @objc private func handleUsersUpdated() {
        let name = profileUserName
        guard !name.isEmpty,
              let updatedUser = UsersDataController.shared.getUser(username: name),
              let profileImage = updatedUser.profileImage else { return }

        profileImageView.image = profileImage
    }

    private func getUserInfo() async {
        let name = profileUserName
        guard !name.isEmpty else { return }

        if let user = await UsersDataController.shared.fetchUser(username: name) {
            await user.fetchProfileImage()
            profileUser = user
            await MainActor.run {
                self.updateUIWithUserInfo()
            }
        }
    }

    private func fetchUserCounts() async {
        let name = profileUserName
        guard !name.isEmpty else { return }

        let success = await UsersDataController.shared.fetchAndUpdateUserCounts(username: name)
        guard success, let updatedUser = UsersDataController.shared.getUser(username: name) else { return }

        if profileUser == nil {
            profileUser = updatedUser
        } else {
            profileUser?.totalFriends = updatedUser.totalFriends
            profileUser?.totalGroups = updatedUser.totalGroups
            profileUser?.totalPosts = updatedUser.totalPosts
        }

        await MainActor.run {
            self.updateCountLabels()
        }
    }

    private func fetchUserPreferences() async {
        let name = profileUserName
        guard !name.isEmpty else { return }
        await ProfilePreferenceDataController.shared.fetchPreferences(userName: name)
        await MainActor.run {
            self.refreshPreferencesUI()
        }
    }

    private func refreshPreferencesUI() {
        let preferences = ProfilePreferenceDataController.shared.preferences(for: profileUserName)
        aboutMeModule.configurePreferences(preferences: preferences, isOwner: false)
    }

    private func fetchFriendList() async {
        let name = profileUserName
        guard !name.isEmpty else { return }

        do {
            let response = try await friendAPI.getSpecificFriendData(otherUser: name, currentUser: currentUser)
            let friends = friendAPI.convertToUserObjects(from: response.data)
            await loadFriendImages(for: friends)
            friendListArray = friends
        } catch {
            print("Failed to fetch friend's friend list: \(error)")
        }
    }

    private func loadFriendImages(for friends: [User]) async {
        await withTaskGroup(of: Void.self) { group in
            for friend in friends {
                group.addTask {
                    if let image = await self.imageFunctions.fetchImage(from: friend.userImage) {
                        friend.profileImage = image
                    }
                }
            }
        }
    }

    private func updateCountLabels() {
        guard let user = profileUser else { return }
        postsCard.configure(count: user.totalPosts)
        groupsCard.configure(count: user.totalGroups)
        friendsCard.configure(count: user.totalFriends)
    }

    private func updateUIWithUserInfo() {
        guard let user = profileUser else { return }

        navigationItem.title = user.displayName

        if let profileImage = user.profileImage {
            profileImageView.image = profileImage
        } else if let placeholderImage = UIImage(named: "user") {
            profileImageView.image = placeholderImage
        }

        userNameLabel.text = "@\(user.userName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)".trimmingCharacters(in: .whitespaces)
        aboutMeModule.configure(biography: user.biography)
        refreshPreferencesUI()
        updateCountLabels()
    }

    private func loadVisibleContent() {
        switch contentKind {
        case .items:
            loadProfileItems()
        case .lists:
            loadProfileLists()
        }
    }

    private func loadProfileItems() {
        guard !didLoadItems else { return }
        let name = profileUserName
        guard !name.isEmpty else { return }
        didLoadItems = true

        Task {
            let posts = await PostDataController.shared.fetchItems(for: name)
            await MainActor.run {
                self.itemList.configure(posts: posts)
            }
        }
    }

    private func loadProfileLists() {
        let name = profileUserName
        guard !name.isEmpty else { return }
        listsLoadID += 1
        let loadID = listsLoadID

        Task { [weak self] in
            guard let self else { return }
            do {
                let response = try await groupsAPI.getGroupsAPI(for: name)
                let lists = response.data.filter {
                    $0.groupType.lowercased() == "wishlist"
                        && ($0.createdBy ?? "").caseInsensitiveCompare(name) == .orderedSame
                }
                await MainActor.run {
                    guard loadID == self.listsLoadID else { return }
                    self.listModule.configure(
                        lists: lists,
                        currentUser: self.currentUser,
                        memberProfiles: [:]
                    )
                    self.loadMemberProfiles(for: lists, loadID: loadID)
                }
            } catch {
                await MainActor.run {
                    guard loadID == self.listsLoadID else { return }
                    self.listModule.showLoadFailed()
                }
            }
        }
    }

    private func loadMemberProfiles(for lists: [GroupModel], loadID: Int) {
        let usernames = Array(
            Set(
                lists
                    .flatMap { $0.activeGroupMembers }
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty }
            )
        )

        guard !usernames.isEmpty else { return }

        memberProfilesTask?.cancel()
        memberProfilesTask = Task { [weak self] in
            let users = await UsersDataController.shared.fetchUsersWithImages(
                usernames: usernames,
                refreshFriendshipStatus: false
            )
            guard !Task.isCancelled else { return }

            var map: [String: User] = [:]
            for user in users {
                map[user.userName.lowercased()] = user
            }

            await MainActor.run {
                guard let self, loadID == self.listsLoadID else { return }
                let currentLists = lists
                self.listModule.configure(
                    lists: currentLists,
                    currentUser: self.currentUser,
                    memberProfiles: map
                )
            }
        }
    }
}
