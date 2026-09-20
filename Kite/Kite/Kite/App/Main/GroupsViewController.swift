//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


// Wishlist need Toggle
// GROUPS: Kite
class GroupsViewController: UIViewController {

    // SETUP
    private enum DisplayState {
        case loading
        case content
        case emptyMyLists
        case emptySharedLists
        case error
    }

    let groupsAPI = GroupsAPI()
    private var groups: [GroupModel] = []

    private let tableView = UITableView()
    private var listsHeaderView: ListsHeaderView?
    private var selectedListSegment: Int = 0
    private var displayState: DisplayState = .loading
    private var memberProfilesByUsername: [String: User] = [:]
    private var memberProfilesTask: Task<Void, Never>?
    private var hasCompletedInitialFetch = false

    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let emptyStateView = ListEmptyStateView()
    private let errorStateView = ListEmptyStateView()
    private let profileImageView = UIImageView()

    let userDefaultManager = UserDefaultManager()
    let imageFunctions = ImageFunctions()

    private let listCellReuseID = "GroupTableViewCell"
    private let createCellReuseID = "CreateListCell"

    // DATA
    private var allGroups: [GroupModel] {
        return GroupDataController.shared.groups
    }

    /// Mode filter first — then My / Shared. Flip with //KITE / //WISHLIST.
    private var modeGroups: [GroupModel] {
        // KITE
        // return allGroups.filter { $0.groupType.lowercased() == "kite" }

        // WISHLIST
        return allGroups.filter { $0.groupType.lowercased() == "wishlist" }
    }

    private var myGroups: [GroupModel] {
        let me = GroupDataController.shared.currentUser
        return modeGroups.filter {
            ($0.createdBy ?? "").caseInsensitiveCompare(me) == .orderedSame
        }
    }

    private var sharedGroups: [GroupModel] {
        let me = GroupDataController.shared.currentUser
        return modeGroups.filter {
            ($0.createdBy ?? "").caseInsensitiveCompare(me) != .orderedSame
        }
    }

    private var displayedGroups: [GroupModel] {
        return selectedListSegment == 0 ? myGroups : sharedGroups
    }

    private var showsCreateCard: Bool {
        selectedListSegment == 0 && displayState == .content && !displayedGroups.isEmpty
    }

    // GROUPS
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.screenBackground
        setupNavigationBar()
        setupTableView()
        setupStateViews()
        installGroupsUpdatedHandler()
        fetchGroups(showLoading: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "GroupsViewController")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        installGroupsUpdatedHandler()
        fetchGroups(showLoading: !hasCompletedInitialFetch)
    }

    deinit {
        memberProfilesTask?.cancel()
        if GroupDataController.shared.onGroupsUpdated != nil {
            GroupDataController.shared.onGroupsUpdated = nil
        }
    }

    // ACTIONS
    @objc private func openProfile() {
        let currentUserName = UsersDataController.shared.currentUser
        print("Profile tapped - Current user: \(currentUserName)")
    }

    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }

    // LAYOUT
    private func setupNavigationBar() {
        navigationItem.title = "My Lists"
        navigationController?.navigationBar.prefersLargeTitles = false

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.semibold20,
            .foregroundColor: Colors.primaryGrayText
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes

        let profileButton = UIButton(type: .custom)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.frame = CGRect(x: 0, y: 0, width: Layout.touchTargetSize, height: Layout.touchTargetSize)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        profileButton.accessibilityLabel = "Open profile"

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_14")
        ImageStyle.userProfileImage(imageView: profileImageView, diameter: 40)
        profileButton.addSubview(profileImageView)

        NSLayoutConstraint.activate([
            profileButton.widthAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            profileButton.heightAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            profileImageView.centerXAnchor.constraint(equalTo: profileButton.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)

        let addButton = UIButton(type: .system)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = Colors.primaryPink
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 13
        let plusConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: plusConfig), for: .normal)
        addButton.addTarget(self, action: #selector(openCreateGroup), for: .touchUpInside)
        addButton.accessibilityLabel = "Create a new list"

        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            addButton.heightAnchor.constraint(equalToConstant: Layout.touchTargetSize)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)

        loadCurrentUserAvatar()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Colors.screenBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 144
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Layout.spacingXL, right: 0)
        tableView.tableFooterView = UIView()
        tableView.register(GroupCell.self, forCellReuseIdentifier: listCellReuseID)
        tableView.register(CreateListCell.self, forCellReuseIdentifier: createCellReuseID)

        let listsHeaderView = ListsHeaderView()
        listsHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 116)
        listsHeaderView.onListTypeChanged = { [weak self] index in
            self?.selectedListSegment = index
            self?.recomputeDisplayState(reload: true)
        }
        tableView.tableHeaderView = listsHeaderView
        self.listsHeaderView = listsHeaderView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStateViews() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = Colors.subtleGrayText
        view.addSubview(loadingIndicator)

        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)

        errorStateView.translatesAutoresizingMaskIntoConstraints = false
        errorStateView.isHidden = true
        view.addSubview(errorStateView)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),

            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            errorStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            errorStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resizeTableHeaderIfNeeded()
    }

    // FUNCTIONS
    private func installGroupsUpdatedHandler() {
        GroupDataController.shared.onGroupsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.hasCompletedInitialFetch = true
                self?.recomputeDisplayState(reload: true)
                self?.loadMemberProfilesForDisplayedLists()
            }
        }
    }

    private func resizeTableHeaderIfNeeded() {
        guard let header = tableView.tableHeaderView else { return }
        let targetWidth = tableView.bounds.width
        guard targetWidth > 0 else { return }

        let height: CGFloat = 116
        if abs(header.frame.width - targetWidth) > 0.5 || abs(header.frame.height - height) > 0.5 {
            header.frame = CGRect(x: 0, y: 0, width: targetWidth, height: height)
            tableView.tableHeaderView = header
        }
    }

    private func loadCurrentUserAvatar() {
        let currentUser = UsersDataController.shared.currentUser
        guard !currentUser.isEmpty else { return }

        Task {
            guard let user = await UsersDataController.shared.getOrFetchUserWithImage(username: currentUser),
                  let profileImage = user.profileImage else {
                return
            }

            await MainActor.run {
                self.profileImageView.image = profileImage
            }
        }
    }

    private func fetchGroups(showLoading: Bool) {
        if showLoading {
            displayState = .loading
            applyDisplayState()
        }

        GroupDataController.shared.getGroups { [weak self] success in
            guard let self = self else { return }
            self.hasCompletedInitialFetch = true

            if success {
                self.recomputeDisplayState(reload: true)
                self.loadMemberProfilesForDisplayedLists()
            } else if self.modeGroups.isEmpty {
                self.displayState = .error
                self.applyDisplayState()
                self.tableView.reloadData()
            } else {
                // Keep previously loaded lists visible when a refresh fails.
                self.recomputeDisplayState(reload: true)
            }
        }
    }

    private func recomputeDisplayState(reload: Bool) {
        if displayState == .loading && !hasCompletedInitialFetch {
            applyDisplayState()
            if reload { tableView.reloadData() }
            return
        }

        if displayedGroups.isEmpty {
            displayState = selectedListSegment == 0 ? .emptyMyLists : .emptySharedLists
        } else {
            displayState = .content
        }

        applyDisplayState()
        if reload {
            tableView.reloadData()
        }
    }

    private func applyDisplayState() {
        switch displayState {
        case .loading:
            loadingIndicator.startAnimating()
            emptyStateView.isHidden = true
            errorStateView.isHidden = true
            tableView.isScrollEnabled = false

        case .content:
            loadingIndicator.stopAnimating()
            emptyStateView.isHidden = true
            errorStateView.isHidden = true
            tableView.isScrollEnabled = true

        case .emptyMyLists:
            loadingIndicator.stopAnimating()
            errorStateView.isHidden = true
            emptyStateView.isHidden = false
            emptyStateView.configure(
                symbolName: "gift",
                title: "No lists yet",
                message: "Create a list to keep gift ideas, favorites, and things you want in one place.",
                actionTitle: "Create a List",
                action: { [weak self] in
                    self?.openCreateGroup()
                }
            )
            tableView.isScrollEnabled = true

        case .emptySharedLists:
            loadingIndicator.stopAnimating()
            errorStateView.isHidden = true
            emptyStateView.isHidden = false
            emptyStateView.configure(
                symbolName: "person.2",
                title: "Nothing shared yet",
                message: "Lists shared with you by friends will appear here."
            )
            tableView.isScrollEnabled = true

        case .error:
            loadingIndicator.stopAnimating()
            emptyStateView.isHidden = true
            errorStateView.isHidden = false
            errorStateView.configure(
                symbolName: "exclamationmark.triangle",
                title: "Couldn't load lists",
                message: "Check your connection and try again.",
                actionTitle: "Try Again",
                action: { [weak self] in
                    self?.fetchGroups(showLoading: true)
                }
            )
            tableView.isScrollEnabled = false
        }
    }

    private func loadMemberProfilesForDisplayedLists() {
        let usernames = Array(
            Set(
                displayedGroups
                    .flatMap { $0.activeGroupMembers }
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty }
            )
        )

        guard !usernames.isEmpty else {
            memberProfilesByUsername = [:]
            return
        }

        memberProfilesTask?.cancel()
        memberProfilesTask = Task {
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
                self.memberProfilesByUsername = map
                self.reloadVisibleListCells()
            }
        }
    }

    private func reloadVisibleListCells() {
        guard displayState == .content else { return }

        let indexPaths = tableView.indexPathsForVisibleRows ?? []
        for indexPath in indexPaths {
            guard indexPath.row < displayedGroups.count,
                  let cell = tableView.cellForRow(at: indexPath) as? GroupCell else {
                continue
            }
            let group = displayedGroups[indexPath.row]
            cell.setupGroupListCell(
                with: group,
                currentUser: GroupDataController.shared.currentUser,
                memberProfiles: memberProfilesByUsername
            )
        }
    }
}


// TABLE VIEW
extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayState {
        case .loading, .error, .emptyMyLists, .emptySharedLists:
            return 0
        case .content:
            return displayedGroups.count + (showsCreateCard ? 1 : 0)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showsCreateCard && indexPath.row == displayedGroups.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: createCellReuseID, for: indexPath) as! CreateListCell
            cell.onCreateListTapped = { [weak self] in
                self?.openCreateGroup()
            }
            return cell
        }

        let group = displayedGroups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellReuseID, for: indexPath) as! GroupCell
        cell.setupGroupListCell(
            with: group,
            currentUser: GroupDataController.shared.currentUser,
            memberProfiles: memberProfilesByUsername
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if showsCreateCard && indexPath.row == displayedGroups.count {
            openCreateGroup()
            return
        }

        guard indexPath.row < displayedGroups.count else { return }

        let group = displayedGroups[indexPath.row]
        let currentUserOwnsGroup = (group.createdBy ?? "")
            .caseInsensitiveCompare(GroupDataController.shared.currentUser) == .orderedSame

        let storyboard = UIStoryboard(name: Constants.StoryboardNames.groupsStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: Constants.StoryboardID.individualGroupViewControllerID
        ) as? IndividualGroupViewController else { return }

        vc.groupID = group.groupID
        vc.currentUserOwnsGroup = currentUserOwnsGroup
        navigationController?.pushViewController(vc, animated: true)
    }
}
