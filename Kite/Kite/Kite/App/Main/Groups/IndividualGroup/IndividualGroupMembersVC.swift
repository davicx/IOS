//
//  IndividualGroupMembersVC.swift
//  Kite
//
//  Created by David Vasquez on 9/15/25.
//

import UIKit


class IndividualGroupMembersVC: UIViewController {
    
    // Group members data
    var groupMembers: [User] = []
    
    // Table view for displaying members
    private let tableView = UITableView()
    
    private let usersDataController = UsersDataController.shared
    
    // Track loading state per username to prevent multiple simultaneous requests
    private var loadingUsernames: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh member data to ensure we have latest friendship status
        Task {
            await refreshMembersData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "IndividualGroupMembersVC")
    }
    
    // Refresh member data from cache and refresh friendship status if needed
    private func refreshMembersData() async {
        // First, refresh friendship status to ensure cache is up-to-date
        // This returns the set of usernames that are actually in the API response
        var friendUsernamesFromAPI: Set<String> = []
        do {
            friendUsernamesFromAPI = try await usersDataController.fetchFriends()
        } catch {
            print("IndividualGroupMembersVC: Error refreshing friendship status: \(error)")
        }
        
        // Then get fresh data from cache for each member
        // If a member is NOT in the friends API response, clear their friendship properties
        var refreshedMembers: [User] = []
        for member in groupMembers {
            if let freshUser = usersDataController.getUser(username: member.userName) {
                // If this user is NOT in the friends API response, clear their friendship properties
                // This handles cases where they were previously friends/pending but are no longer
                if !friendUsernamesFromAPI.contains(member.userName) {
                    freshUser.friendshipKey = "not_friends"
                    freshUser.requestPending = 0
                    freshUser.requestSentBy = ""
                    freshUser.alsoYourFriend = 0
                    // Update the cache with cleared friendship data
                    usersDataController.addOrUpdateUser(freshUser)
                }
                refreshedMembers.append(freshUser)
            } else {
                // If not in cache, check if they should have friendship data cleared
                var memberCopy = member
                if !friendUsernamesFromAPI.contains(member.userName) {
                    memberCopy.friendshipKey = "not_friends"
                    memberCopy.requestPending = 0
                    memberCopy.requestSentBy = ""
                    memberCopy.alsoYourFriend = 0
                }
                refreshedMembers.append(memberCopy)
            }
        }
        
        DispatchQueue.main.async {
            self.groupMembers = refreshedMembers
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendCell")
    }
}

// MARK: - Table View Delegate & Data Source
extension IndividualGroupMembersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = groupMembers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        cell.configure(with: member)
        
        // Set loading state if this user is currently loading
        if loadingUsernames.contains(member.userName) {
            cell.setLoading(true)
        }
        
        // Set up button action based on friendship status
        cell.friendActionTapped = { [weak self] in
            guard let self = self else { return }
            self.handleFriendAction(for: member, at: indexPath)
        }
        
        return cell
    }
    
    private func handleFriendAction(for user: User, at indexPath: IndexPath) {
        // Prevent multiple simultaneous requests for the same user
        guard !loadingUsernames.contains(user.userName) else { return }
        
        // Get the cell and set loading state
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell else { return }
        loadingUsernames.insert(user.userName)
        cell.setLoading(true)
        
        switch user.friendshipStatus {
        case .notFriends, .unknown:
            // Add Friend
            Task {
                do {
                    // Use withTimeout to handle timeout
                    let updatedUser = try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                        await UsersDataController.shared.sendFriendRequest(to: user)
                    }
                    
                        DispatchQueue.main.async {
                        self.loadingUsernames.remove(user.userName)
                        if let updatedUser = updatedUser {
                            self.groupMembers[indexPath.row] = updatedUser
                            cell.configure(with: updatedUser)
                        } else {
                            cell.setLoading(false)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.loadingUsernames.remove(user.userName)
                        cell.setLoading(false)
                        self.showErrorAlert(message: "Failed to send friend request. Please try again.")
                    }
                }
            }
            
        case .invitePendingSentByYou:
            // Cancel Request
            presentConfirmationAlert(
                title: "Cancel Friend Request",
                message: "Are you sure you want to cancel the friend invite to @\(user.userName)?",
                confirmTitle: "Cancel Request",
                destructive: true,
                completion: {
                Task {
                    do {
                            try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                        try await UsersDataController.shared.cancelRequest(to: user)
                            }
                            
                            DispatchQueue.main.async {
                                self.loadingUsernames.remove(user.userName)
                        if let updatedUser = UsersDataController.shared.getUser(username: user.userName) {
                            self.groupMembers[indexPath.row] = updatedUser
                                    cell.configure(with: updatedUser)
                                } else {
                                    cell.setLoading(false)
                                }
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.loadingUsernames.remove(user.userName)
                                cell.setLoading(false)
                                self.showErrorAlert(message: "Failed to cancel friend request. Please try again.")
                            }
                        }
                    }
                },
                onCancel: {
                    // Reset loading state if user cancels the alert
                    self.loadingUsernames.remove(user.userName)
                    cell.configure(with: user)
                }
            )
            
        case .requestPendingSentByThem:
            // Accept Request
            Task {
                do {
                    let updatedUser = try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                        try await UsersDataController.shared.accept(inviteFrom: user)
                    }
                    
                    DispatchQueue.main.async {
                        self.loadingUsernames.remove(user.userName)
                        self.groupMembers[indexPath.row] = updatedUser
                        cell.configure(with: updatedUser)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.loadingUsernames.remove(user.userName)
                        cell.setLoading(false)
                        self.showErrorAlert(message: "Failed to accept friend request. Please try again.")
                    }
                }
            }
            
        case .friends:
            // Remove Friend
            presentConfirmationAlert(
                title: "Remove Friend",
                message: "Are you sure you want to remove @\(user.userName) from your friends?",
                confirmTitle: "Remove",
                destructive: true,
                completion: {
                Task {
                    do {
                            try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                        try await UsersDataController.shared.remove(friend: user)
                            }
                            
                            DispatchQueue.main.async {
                                self.loadingUsernames.remove(user.userName)
                        if let updatedUser = UsersDataController.shared.getUser(username: user.userName) {
                            self.groupMembers[indexPath.row] = updatedUser
                                    cell.configure(with: updatedUser)
                                } else {
                                    cell.setLoading(false)
                                }
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.loadingUsernames.remove(user.userName)
                                cell.setLoading(false)
                                self.showErrorAlert(message: "Failed to remove friend. Please try again.")
                            }
                        }
                    }
                },
                onCancel: {
                    // Reset loading state if user cancels the alert
                    self.loadingUsernames.remove(user.userName)
                    cell.configure(with: user)
                }
            )
            
        case .you:
            // No action for current user
            loadingUsernames.remove(user.userName)
            cell.setLoading(false)
            break
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func presentConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String,
        destructive: Bool,
        completion: @escaping () -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: destructive ? .destructive : .default) { _ in
            completion()
        }
        alert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            onCancel?()
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMember = groupMembers[indexPath.row]
        
        // Navigate to member's profile
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedMember
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


