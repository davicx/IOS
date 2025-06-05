//
//  FriendViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/26/25.
//

import UIKit



protocol YourFriendsViewControllerDelegate: AnyObject {
    func didDeclineFriend(_ friend: Friend)
    func didAddFriend(_ friend: Friend)
}

//ACTIVE FRIEND
//Current Friend: Remove
//Current Invite Sent: Cancel it

//FRIEND REQUESTS
//Accept Request
//Decline Request

class YourFriendsViewController: UIViewController {
    
    //API Data
    var users: [Friend] = []
    private var friends: [Friend] = []
    private var friendRequests: [Friend] = []
    private var currentData: [Friend] = []

    weak var delegate: YourFriendsViewControllerDelegate?

    
    //Table View
    private let tableView = UITableView()
    private let segmentedControl = UISegmentedControl(items: ["Friends", "Friend Requests"])
    private var underlineView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white

        friends = users.filter {
            let status = FriendshipStatus(key: $0.friendshipKey)
            return status == .friends || status == .requestPending
        }

        friendRequests = users.filter {
            FriendshipStatus(key: $0.friendshipKey) == .invitePending
        }

        setupSegmentedControl()
        setupTableView()

        segmentedControl.selectedSegmentIndex = 0
        currentData = friends
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("YourFriendsViewController")
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addUnderlineForSelectedSegment()
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider()

        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]

        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        segmentedControl.frame = CGRect(x: 16, y: 4, width: view.frame.width - 32, height: 36)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
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

        tableView.register(YourFriendsTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell)
    }

    @objc private func segmentChanged() {
        currentData = segmentedControl.selectedSegmentIndex == 0 ? friends : friendRequests
        addUnderlineForSelectedSegment()
        tableView.reloadData()
    }

    private func addUnderlineForSelectedSegment() {
        let underlineWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineY = segmentedControl.frame.height - underlineHeight
        let underlineX = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth

        if let underline = underlineView {
            UIView.animate(withDuration: 0.25) {
                underline.frame.origin.x = underlineX
            }
        } else {
            let underline = UIView(frame: CGRect(x: underlineX, y: underlineY, width: underlineWidth, height: underlineHeight))
            underline.backgroundColor = .label
            underline.tag = 999
            segmentedControl.addSubview(underline)
            underlineView = underline
        }
    }

    private func configureCellActions(for user: Friend, cell: YourFriendsTableViewCell) {
        cell.cancelFriendInviteTapped = { [weak self] in
            self?.presentConfirmationAlert(
                title: "Cancel Friend Request",
                message: "Are you sure you want to cancel the friend invite to @\(user.friendName)?",
                confirmTitle: "Remove Request",
                destructive: true
            ) {
                Task { await self?.cancelFriendAPI(for: user) }
            }
        }

        cell.removeFriendTapped = { [weak self] in
            self?.presentConfirmationAlert(
                title: "Remove Friend",
                message: "Are you sure you want to remove @\(user.friendName) from your friends?",
                confirmTitle: "Remove",
                destructive: true
            ) {
                Task { await self?.removeFriendAPI(for: user) }
            }
        }

        cell.acceptFriendInviteTapped = { [weak self] in
            Task { await self?.acceptInviteAPI(for: user) }
        }

        cell.declineFriendInviteTapped = { [weak self] in
            Task { await self?.declineInviteAPI(for: user) }
        }
    }

    //FUNCTIONS: Handle Friend Requests
    private func cancelFriendAPI(for user: Friend) async {
        do {
            let currentUser = UserDefaultManager().getLoggedInUser()
            let response = try await FriendAPI().cancelFriendRequest(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                DispatchQueue.main.async {
                    print("Successfully cancelled request to \(user.friendName)")
                    self.removeUserFromLocalData(user)
                    self.tableView.reloadData()
                    self.delegate?.didDeclineFriend(user)
                }
            } else {
                print("Cancel friend request failed: \(response.message)")
            }
        } catch {
            print("Error cancelling friend request: \(error)")
        }
    }

    private func removeFriendAPI(for user: Friend) async {
        do {
            let currentUser = UserDefaultManager().getLoggedInUser()
            let response = try await FriendAPI().removeFriend(
                masterSite: "kite",
                currentUser: currentUser,
                removeFriendName: user.friendName
            )
            if response.success {
                DispatchQueue.main.async {
                    print("Successfully removed friend: \(user.friendName)")
                    self.removeUserFromLocalData(user)
                    self.tableView.reloadData()
                    self.delegate?.didDeclineFriend(user)
                }
            } else {
                print("Remove friend failed: \(response.message)")
            }
        } catch {
            print("Error removing friend: \(error)")
        }
    }

    private func acceptInviteAPI(for user: Friend) async {
        do {
            let currentUser = UserDefaultManager().getLoggedInUser()
            let response = try await FriendAPI().acceptFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                DispatchQueue.main.async {
                    print("Accepted invite from \(user.friendName)")
                    self.friendRequests.removeAll { $0.friendID == user.friendID }
                    self.currentData.removeAll { $0.friendID == user.friendID }

                    user.friendshipKey = FriendshipStatus.friends.rawValue
                    self.friends.append(user)

                    if self.segmentedControl.selectedSegmentIndex == 1 {
                        self.tableView.reloadData()
                    }

                    self.delegate?.didAddFriend(user)
                }
            } else {
                print("Accept invite failed: \(response.message)")
            }
        } catch {
            print("Error accepting invite: \(error)")
        }
    }

    //FUNCTIONS: Handle Friend Requests
    private func declineInviteAPI(for user: Friend) async {
        do {
            let currentUser = UserDefaultManager().getLoggedInUser()
            let response = try await FriendAPI().declineFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                DispatchQueue.main.async {
                    print("Declined invite from \(user.friendName)")
                    if let index = self.currentData.firstIndex(where: { $0.friendID == user.friendID }) {
                        self.removeUserFromLocalData(user)
                        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                        self.delegate?.didDeclineFriend(user)
                    }
                }
            } else {
                print("Decline invite failed: \(response.message)")
            }
        } catch {
            print("Error declining invite: \(error)")
        }
    }

    
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension YourFriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentData[indexPath.row]
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
        let selectedFriend = currentData[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(
            withIdentifier: "FriendProfileViewControllerID"
        ) as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func removeUserFromLocalData(_ user: Friend) {
        friends.removeAll { $0.friendID == user.friendID }
        friendRequests.removeAll { $0.friendID == user.friendID }
        currentData.removeAll { $0.friendID == user.friendID }
        users.removeAll { $0.friendID == user.friendID }
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



// MARK: - Helper
extension UISegmentedControl {
    func removeBackgroundAndDivider() {
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal,
                        rightSegmentState: .normal, barMetrics: .default)
    }
}


/*
private func configureCellActions(for user: Friend, cell: YourFriendsTableViewCell) {
    let status = FriendshipStatus(key: user.friendshipKey)

    // TYPE 1: Cancel a Friend Request you sent
    cell.cancelFriendInviteTapped = { [weak self] in
        guard let self = self else { return }
        let alert = UIAlertController(
            title: "Cancel Friend Request",
            message: "Are you sure you want to cancel the friend invite to @\(user.friendName)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove Request", style: .destructive) { _ in
            Task {
                do {
                    let currentUser = UserDefaultManager().getLoggedInUser()
                    let response = try await FriendAPI().cancelFriendRequest(
                        masterSite: "kite", // Replace with actual value
                        currentUser: currentUser,
                        friendName: user.friendName
                    )

                    if response.success {
                        DispatchQueue.main.async {
                            print("Successfully cancelled request to \(user.friendName)")

                            // Remove from local arrays
                            self.friends.removeAll { $0.friendID == user.friendID }
                            self.currentData.removeAll { $0.friendID == user.friendID }

                            self.tableView.reloadData()

                            // Inform delegate
                            self.delegate?.didDeclineFriend(user)
                        }
                    } else {
                        print("Failed to cancel friend request: \(response.message)")
                    }
                } catch {
                    print("Error cancelling friend request: \(error)")
                }
            }
        })
        self.present(alert, animated: true)
    }


    
    // TYPE 2: Remove an existing friend
    cell.removeFriendTapped = { [weak self] in
        guard let self = self else { return }

        let alert = UIAlertController(
            title: "Remove Friend",
            message: "Are you sure you want to remove @\(user.friendName) from your friends?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
            Task {
                do {
                    let currentUser = UserDefaultManager().getLoggedInUser()
                    let response = try await FriendAPI().removeFriend(
                        masterSite: "yourMasterSiteName", // Replace with actual
                        currentUser: currentUser,
                        removeFriendName: user.friendName
                    )

                    if response.success {
                        DispatchQueue.main.async {
                            print("Successfully removed friend: \(user.friendName)")

                            // Remove from local arrays
                            self.friends.removeAll { $0.friendID == user.friendID }
                            self.currentData.removeAll { $0.friendID == user.friendID }

                            self.tableView.reloadData()

                            // Inform delegate (same as decline)
                            self.delegate?.didDeclineFriend(user)
                        }
                    } else {
                        print("Failed to remove friend: \(response.message)")
                    }
                } catch {
                    print("Error removing friend: \(error)")
                }
            }
        })
        self.present(alert, animated: true)
    }

    
    // TYPE 3: Accept a Friend request
    // Accept a Friend Request
    cell.acceptFriendInviteTapped = { [weak self] in
        guard let self = self else { return }

        Task {
            do {
                let currentUser = UserDefaultManager().getLoggedInUser()
                let response = try await FriendAPI().acceptFriendInvite(masterSite: "kite", currentUser: currentUser, friendName: user.friendName)

                if response.success {
                    DispatchQueue.main.async {
                        print("Successfully accepted friend invite from \(user.friendName)")

                        self.friendRequests.removeAll { $0.friendID == user.friendID }
                        self.currentData.removeAll { $0.friendID == user.friendID }

                        user.friendshipKey = FriendshipStatus.friends.rawValue
                        self.friends.append(user)

                        if self.segmentedControl.selectedSegmentIndex == 1 {
                            self.tableView.reloadData()
                        }

                        //Notify the delegate
                        self.delegate?.didAddFriend(user)
                    }
                } else {
                    print("Failed to accept friend invite: \(response.message)")
                }
            } catch {
                print("Error accepting friend invite: \(error)")
            }
        }
    }


    // TYPE 4: Decline a Friend Request
    cell.declineFriendInviteTapped = { [weak self] in
        guard let self = self else { return }

        print("Decline invite from \(user.friendName)")

        Task {
            do {
                let currentUser = UserDefaultManager().getLoggedInUser()
                let response = try await FriendAPI().declineFriendInvite(masterSite: "kite", currentUser: currentUser, friendName: user.friendName)

                if response.success {
                    DispatchQueue.main.async {
                        
                        // 1. Remove from data source
                        if let index = self.currentData.firstIndex(where: { $0.friendID == user.friendID }) {
                            self.currentData.remove(at: index)
                            self.friendRequests.removeAll(where: { $0.friendID == user.friendID })
                            self.users.removeAll(where: { $0.friendID == user.friendID })

                            // 2. Remove from table view
                            let indexPath = IndexPath(row: index, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)

                            // 3. Notify delegate
                            self.delegate?.didDeclineFriend(user)
                        }
                    }
                    
                } else {
                    print("Failed to accept friend invite: \(response.message)")
                }
            } catch {
                print("Error accepting friend invite: \(error)")
            }
        }

    }
}
 
 */


/*
// Simulate success response (pretend API call)
DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    // 1. Remove from data source
    if let index = self.currentData.firstIndex(where: { $0.friendID == user.friendID }) {
        self.currentData.remove(at: index)
        self.friendRequests.removeAll(where: { $0.friendID == user.friendID })
        self.users.removeAll(where: { $0.friendID == user.friendID })

        // 2. Remove from table view
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)

        // 3. Notify delegate
        self.delegate?.didDeclineFriend(user)
    }
}
*/
