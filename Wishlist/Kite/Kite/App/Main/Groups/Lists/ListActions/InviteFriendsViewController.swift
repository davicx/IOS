//
//  InviteFriendsViewController.swift
//  Kite
//

import UIKit


final class InviteFriendsViewController: UIViewController {

    var groupID: Int = 0
    var listName: String = ""
    var memberUsernames: [String] = []
    var onInvited: (([String]) -> Void)?

    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private let inviteButton = UIButton(type: .system)

    private var friends: [User] = []
    private var selectedUsernames: Set<String> = []
    private var isSending = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Invite Friends"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeTapped)
        )
        setupViews()
        loadFriends()
    }

    private func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 76, bottom: 0, right: 0)
        tableView.register(InviteFriendCell.self, forCellReuseIdentifier: "InviteFriendCell")
        view.addSubview(tableView)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No friends to invite"
        emptyLabel.font = Fonts.regular15
        emptyLabel.textColor = Colors.subtleGrayText
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)

        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.configuration = nil
        inviteButton.backgroundColor = Colors.primaryPink
        inviteButton.setTitleColor(.white, for: .normal)
        inviteButton.setTitleColor(.white, for: .disabled)
        inviteButton.titleLabel?.font = Fonts.buttonTikTokFont
        inviteButton.layer.cornerRadius = 8
        inviteButton.clipsToBounds = true
        inviteButton.setTitle("Invite", for: .normal)
        inviteButton.addTarget(self, action: #selector(inviteTapped), for: .touchUpInside)
        view.addSubview(inviteButton)
        refreshInviteButton()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inviteButton.topAnchor, constant: -Layout.spacingM),

            emptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            inviteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.spacingL),
            inviteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.spacingL),
            inviteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.spacingM),
            inviteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func loadFriends() {
        Task {
            do {
                try await FriendDataController.shared.fetchFriends()
            } catch {
                await MainActor.run {
                    self.showAlert(message: "Couldn’t load your friends. Please try again.")
                }
                return
            }

            let currentUser = GroupDataController.shared.currentUser
            let excluded = Set(memberUsernames.map { $0.lowercased() })
            let available = FriendDataController.shared.friends
                .filter { $0.friendshipStatus == .friends }
                .filter { $0.userName.caseInsensitiveCompare(currentUser) != .orderedSame }
                .filter { !excluded.contains($0.userName.lowercased()) }
                .sorted { $0.userName.localizedCaseInsensitiveCompare($1.userName) == .orderedAscending }

            await MainActor.run {
                self.friends = available
                self.emptyLabel.isHidden = !available.isEmpty
                self.tableView.reloadData()
                self.refreshInviteButton()
            }
        }
    }

    private func refreshInviteButton() {
        let canSend = !selectedUsernames.isEmpty && !isSending && !friends.isEmpty
        inviteButton.isEnabled = canSend
        inviteButton.alpha = canSend ? 1 : 0.45
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func inviteTapped() {
        guard !selectedUsernames.isEmpty, !isSending else { return }
        isSending = true
        refreshInviteButton()

        let names = selectedUsernames.sorted()
        let currentUser = GroupDataController.shared.currentUser
        Task {
            do {
                let response = try await GroupsAPI().inviteFriends(
                    currentUser: currentUser,
                    groupID: groupID,
                    invitedUsers: names,
                    listName: listName
                )
                await MainActor.run {
                    self.isSending = false
                    self.refreshInviteButton()
                    guard response.success else {
                        let message = response.message.isEmpty ? "Couldn’t invite friends." : response.message
                        self.showAlert(message: message)
                        return
                    }
                    guard !response.data.addedUsers.isEmpty else {
                        self.showAlert(message: "Those friends are already on this list.")
                        return
                    }
                    self.onInvited?(response.data.addedUsers)
                    self.dismiss(animated: true)
                }
            } catch {
                await MainActor.run {
                    self.isSending = false
                    self.refreshInviteButton()
                    self.showAlert(message: "Couldn’t invite friends. Please try again.")
                }
            }
        }
    }

    private func toggle(_ username: String) {
        if selectedUsernames.contains(username) {
            selectedUsernames.remove(username)
        } else {
            selectedUsernames.insert(username)
        }
        refreshInviteButton()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension InviteFriendsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteFriendCell", for: indexPath) as! InviteFriendCell
        cell.configure(with: friend, checked: selectedUsernames.contains(friend.userName))
        cell.onToggle = { [weak self] in
            self?.toggle(friend.userName)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        toggle(friend.userName)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
