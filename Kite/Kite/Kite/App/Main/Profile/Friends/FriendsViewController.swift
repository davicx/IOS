//
//  FriendViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/26/25.
//

import UIKit


class FriendsViewController: UIViewController {

    // Filtered data
    private var friends: [User] = []
    private var friendRequests: [User] = []
    private var currentlyDisplayedFriends: [User] = []

    // Table View
    internal let tableView = UITableView()
    internal let segmentedControl = UISegmentedControl(items: ["Friends", "Friend Requests"])
    internal var underlineView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white

        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendsUpdated), name: .friendsUpdated, object: nil)

        splitUsersByStatus()
        setupSegmentedControl()
        setupTableView()
        

        segmentedControl.selectedSegmentIndex = 0
        currentlyDisplayedFriends = friends
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "FriendsViewController")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addUnderlineForSelectedSegment()
    }
    
    @objc func segmentChanged() {
        currentlyDisplayedFriends = segmentedControl.selectedSegmentIndex == 0 ? friends : friendRequests
        addUnderlineForSelectedSegment()
        tableView.reloadData()
    }

    
    //FUNCTIONS
    private func splitUsersByStatus() {
        let allFriends = UsersDataController.shared.getFriends()

        self.friends = allFriends.filter {
            $0.friendshipStatus == .friends
        }

        self.friendRequests = allFriends.filter {
            let status = $0.friendshipStatus
            return status == .invitePendingSentByYou || status == .requestPendingSentByThem
        }
    }


    @objc private func handleFriendsUpdated() {
        Task {
            do {
                _ = try await UsersDataController.shared.fetchFriends()
                self.splitUsersByStatus()

                DispatchQueue.main.async {
                    self.segmentChanged()
                }
            } catch {
                print("Failed to refresh friend list: \(error)")
            }
        }
    }
    
    private func configureCellActions(for user: User, cell: YourFriendsTableViewCell) {
        // Clear all callbacks first
        cell.cancelFriendInviteTapped = nil
        cell.removeFriendTapped = nil
        cell.acceptFriendInviteTapped = nil
        cell.declineFriendInviteTapped = nil
        
        // Configure based on current tab and user status
        if segmentedControl.selectedSegmentIndex == 0 {
            // Friends tab - only show remove friend
            configureRemoveFriend(for: user, in: cell)
        } else {
            // Friend Requests tab - show appropriate buttons based on request type
            switch user.friendshipStatus {
            case .requestPendingSentByThem:
                // Request sent TO you - show Accept/Decline
                configureAcceptInvite(for: user, in: cell)
                configureDeclineInvite(for: user, in: cell)
            case .invitePendingSentByYou:
                // Request sent BY you - show Cancel
                configureCancelInvite(for: user, in: cell)
            default:
                break
            }
        }
    }

    private func configureCancelInvite(for user: User, in cell: YourFriendsTableViewCell) {
        cell.cancelFriendInviteTapped = { [weak self] in
            self?.presentConfirmationAlert(
                title: "Cancel Friend Request",
                message: "Are you sure you want to cancel the friend invite to @\(user.userName)?",
                confirmTitle: "Remove Request",
                destructive: true
            ) {
                Task { await self?.cancelFriendAPI(for: user) }
            }
        }
    }

    private func configureRemoveFriend(for user: User, in cell: YourFriendsTableViewCell) {
        cell.removeFriendTapped = { [weak self] in
            self?.presentConfirmationAlert(
                title: "Remove Friend",
                message: "Are you sure you want to remove @\(user.userName) from your friends?",
                confirmTitle: "Remove",
                destructive: true
            ) {
                Task { await self?.removeFriendAPI(for: user) }
            }
        }
    }

    private func configureAcceptInvite(for user: User, in cell: YourFriendsTableViewCell) {
        cell.acceptFriendInviteTapped = { [weak self] in
            Task { await self?.acceptInviteAPI(for: user) }
        }
    }

    private func configureDeclineInvite(for user: User, in cell: YourFriendsTableViewCell) {
        cell.declineFriendInviteTapped = { [weak self] in
            Task { await self?.declineInviteAPI(for: user) }
        }
    }

    private func cancelFriendAPI(for user: User) async {
        do {
            try await UserLogic.shared.cancelRequest(to: user)
            DispatchQueue.main.async {
                print("Successfully cancelled request to \(user.userName)")
                self.removeUserFromLocalData(user)
                self.splitUsersByStatus()
                self.tableView.reloadData()
            }
        } catch {
            print("Error cancelling friend request: \(error)")
        }
    }

    private func removeFriendAPI(for user: User) async {
        do {
            try await UserLogic.shared.remove(friend: user)
            DispatchQueue.main.async {
                print("Successfully removed friend: \(user.userName)")
                self.removeUserFromLocalData(user)
                self.splitUsersByStatus()
                self.tableView.reloadData()
            }
        } catch {
            print("Error removing friend: \(error)")
        }
    }

    private func acceptInviteAPI(for user: User) async {
        do {
            let updatedUser = try await UserLogic.shared.accept(inviteFrom: user)
            DispatchQueue.main.async {
                print("Accepted invite from \(user.userName)")
                self.removeUserFromLocalData(user)
                self.splitUsersByStatus()

                if self.segmentedControl.selectedSegmentIndex == 1 {
                    self.tableView.reloadData()
                }
            }
        } catch {
            print("Error accepting invite: \(error)")
        }
    }

    private func declineInviteAPI(for user: User) async {
        do {
            try await UserLogic.shared.decline(inviteFrom: user)
            DispatchQueue.main.async {
                print("Declined invite from \(user.userName)")
                self.removeUserFromLocalData(user)
                self.splitUsersByStatus()
                self.tableView.reloadData()
            }
        } catch {
            print("Error declining invite: \(error)")
        }
    }

    private func removeUserFromLocalData(_ user: User) {
        friends.removeAll { $0.userID == user.userID }
        friendRequests.removeAll { $0.userID == user.userID }
        currentlyDisplayedFriends.removeAll { $0.userID == user.userID }
    }

    private func presentConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String,
        destructive: Bool = false,
        onConfirm: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let style: UIAlertAction.Style = destructive ? .destructive : .default
        alert.addAction(UIAlertAction(title: confirmTitle, style: style) { _ in onConfirm() })
        present(alert, animated: true)
    }
}

// MARK: - TableView
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentlyDisplayedFriends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentlyDisplayedFriends[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.TableViewCellIdentifier.friendCell,
            for: indexPath
        ) as! YourFriendsTableViewCell

        cell.configure(with: user)
        cell.selectionStyle = .none
        configureCellActions(for: user, cell: cell)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = currentlyDisplayedFriends[indexPath.row]

        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension UISegmentedControl {
    func removeBackgroundAndDivider() {
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal,
                        rightSegmentState: .normal, barMetrics: .default)
    }
}


