//
//  FriendListViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/6/25.
//

import UIKit


class FriendListViewController: UIViewController {
    var friendUserName: String?
    var friendListArray: [User] = []

    private let tableView = UITableView()
    private let friendAPI = FriendAPI()
    private let imageFunctions = ImageFunctions()
    private let userDefaultManager = UserDefaultManager()

    // Track loading state per username to prevent multiple simultaneous requests
    private var loadingUsernames: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = friendUserName, !name.isEmpty {
            title = "\(name)'s Friends"
            print("Viewing friend list of: \(name)")
        } else {
            title = "Friends"
        }
        view.backgroundColor = .white

        setupTableView()
        Task { await loadFriends() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "FriendListViewController")
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

    private func loadFriends() async {
        guard let name = friendUserName, !name.isEmpty else {
            await loadFriendImages()
            await MainActor.run { tableView.reloadData() }
            return
        }

        do {
            let response = try await friendAPI.getSpecificFriendData(
                otherUser: name,
                currentUser: userDefaultManager.getLoggedInUser()
            )
            let friends = friendAPI.convertToUserObjects(from: response.data)
            friendListArray = friends
            await loadFriendImages()
            await MainActor.run { tableView.reloadData() }
        } catch {
            print("Failed to load \(name)'s friends: \(error)")
            await loadFriendImages()
            await MainActor.run { tableView.reloadData() }
        }
    }

    private func loadFriendImages() async {
        await withTaskGroup(of: Void.self) { group in
            for friend in friendListArray {
                group.addTask {
                    if let image = await self.imageFunctions.fetchImage(from: friend.userImage) {
                        friend.profileImage = image
                    }
                }
            }
        }
    }
}


// MARK: - Table View Delegate & Data Source
extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friendListArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        cell.configure(with: friend, parentViewController: "FriendListViewController")

        if loadingUsernames.contains(friend.userName) {
            cell.setLoading(true)
        }

        cell.addFriendTapped = { [weak self] in
            self?.sendFriendRequest(to: friend)
        }
        cell.cancelFriendInviteTapped = { [weak self] in
            self?.confirmCancelRequest(for: friend)
        }
        cell.removeFriendTapped = { [weak self] in
            self?.confirmRemoveFriend(friend)
        }
        cell.acceptFriendInviteTapped = { [weak self] in
            self?.acceptInvite(from: friend)
        }
        cell.declineFriendInviteTapped = { [weak self] in
            self?.declineInvite(from: friend)
        }

        return cell
    }

    private func sendFriendRequest(to friend: User) {
        guard !loadingUsernames.contains(friend.userName) else { return }
        setLoading(true, for: friend.userName)

        Task {
            do {
                let updatedUser = try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                    await UserLogic.shared.sendFriendRequest(to: friend)
                }
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    if updatedUser == nil {
                        self.showErrorAlert(message: "Failed to send friend request. Please try again.")
                    } else {
                        self.reloadRow(for: friend.userName)
                    }
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.showErrorAlert(message: "Failed to send friend request. Please try again.")
                }
            }
        }
    }

    private func confirmCancelRequest(for friend: User) {
        presentConfirmationAlert(
            title: "Cancel Friend Request",
            message: "Are you sure you want to cancel the friend invite to @\(friend.userName)?",
            confirmTitle: "Remove Request",
            destructive: true
        ) { [weak self] in
            self?.cancelRequest(to: friend)
        }
    }

    private func confirmRemoveFriend(_ friend: User) {
        presentConfirmationAlert(
            title: "Remove Friend",
            message: "Are you sure you want to remove @\(friend.userName) from your friends?",
            confirmTitle: "Remove",
            destructive: true
        ) { [weak self] in
            self?.removeFriend(friend)
        }
    }

    private func cancelRequest(to friend: User) {
        guard !loadingUsernames.contains(friend.userName) else { return }
        setLoading(true, for: friend.userName)
        Task {
            do {
                try await UserLogic.shared.cancelRequest(to: friend)
                await MainActor.run {
                    self.markNotFriends(friend)
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.showErrorAlert(message: "Failed to cancel the friend request. Please try again.")
                }
            }
        }
    }

    private func removeFriend(_ friend: User) {
        guard !loadingUsernames.contains(friend.userName) else { return }
        setLoading(true, for: friend.userName)
        Task {
            do {
                try await UserLogic.shared.remove(friend: friend)
                await MainActor.run {
                    self.markNotFriends(friend)
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.showErrorAlert(message: "Failed to remove friend. Please try again.")
                }
            }
        }
    }

    private func acceptInvite(from friend: User) {
        guard !loadingUsernames.contains(friend.userName) else { return }
        setLoading(true, for: friend.userName)
        Task {
            do {
                _ = try await UserLogic.shared.accept(inviteFrom: friend)
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.reloadRow(for: friend.userName)
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.showErrorAlert(message: "Failed to accept the friend request. Please try again.")
                }
            }
        }
    }

    private func declineInvite(from friend: User) {
        guard !loadingUsernames.contains(friend.userName) else { return }
        setLoading(true, for: friend.userName)
        Task {
            do {
                try await UserLogic.shared.decline(inviteFrom: friend)
                await MainActor.run {
                    self.markNotFriends(friend)
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false, for: friend.userName)
                    self.showErrorAlert(message: "Failed to decline the friend request. Please try again.")
                }
            }
        }
    }

    private func markNotFriends(_ friend: User) {
        friend.friendshipKey = "not_friends"
        friend.requestPending = 0
        friend.requestSentBy = ""
        friend.alsoYourFriend = 0
        setLoading(false, for: friend.userName)
        reloadRow(for: friend.userName)
    }

    private func setLoading(_ loading: Bool, for userName: String) {
        if loading {
            loadingUsernames.insert(userName)
        } else {
            loadingUsernames.remove(userName)
        }
        reloadRow(for: userName)
    }

    private func reloadRow(for userName: String) {
        guard let row = friendListArray.firstIndex(where: {
            $0.userName.caseInsensitiveCompare(userName) == .orderedSame
        }) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
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
        destructive: Bool = false,
        onConfirm: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let style: UIAlertAction.Style = destructive ? .destructive : .default
        alert.addAction(UIAlertAction(title: confirmTitle, style: style) { _ in onConfirm() })
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = friendListArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let loggedInUser = userDefaultManager.getLoggedInUser()

        if selectedFriend.friendshipStatus == .you
            || selectedFriend.userName.caseInsensitiveCompare(loggedInUser) == .orderedSame {
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
            navigationController?.pushViewController(profileVC, animated: true)
            return
        }

        guard let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController else { return }
        vc.friend = selectedFriend
        navigationController?.pushViewController(vc, animated: true)
    }
}

