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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "IndividualGroupMembersVC")
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
        
        // Set up button action based on friendship status
        cell.friendActionTapped = { [weak self] in
            guard let self = self else { return }
            self.handleFriendAction(for: member, at: indexPath)
        }
        
        return cell
    }
    
    private func handleFriendAction(for user: User, at indexPath: IndexPath) {
        switch user.friendshipStatus {
        case .notFriends, .unknown:
            // Add Friend
            Task {
                let success = await UsersDataController.shared.sendFriendRequest(to: user)
                if success {
                    // Update local member
                    if let updatedUser = UsersDataController.shared.getUser(username: user.userName) {
                        groupMembers[indexPath.row] = updatedUser
                        DispatchQueue.main.async {
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
            }
            
        case .invitePendingSentByYou:
            // Cancel Request
            presentConfirmationAlert(
                title: "Cancel Friend Request",
                message: "Are you sure you want to cancel the friend invite to @\(user.userName)?",
                confirmTitle: "Cancel Request",
                destructive: true
            ) {
                Task {
                    do {
                        try await UsersDataController.shared.cancelRequest(to: user)
                        if let updatedUser = UsersDataController.shared.getUser(username: user.userName) {
                            self.groupMembers[indexPath.row] = updatedUser
                            DispatchQueue.main.async {
                                self.tableView.reloadRows(at: [indexPath], with: .none)
                            }
                        }
                    } catch {
                        print("Error cancelling friend request: \(error)")
                    }
                }
            }
            
        case .requestPendingSentByThem:
            // Accept Request
            Task {
                do {
                    let updatedUser = try await UsersDataController.shared.accept(inviteFrom: user)
                    groupMembers[indexPath.row] = updatedUser
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                } catch {
                    print("Error accepting invite: \(error)")
                }
            }
            
        case .friends:
            // Remove Friend
            presentConfirmationAlert(
                title: "Remove Friend",
                message: "Are you sure you want to remove @\(user.userName) from your friends?",
                confirmTitle: "Remove",
                destructive: true
            ) {
                Task {
                    do {
                        try await UsersDataController.shared.remove(friend: user)
                        if let updatedUser = UsersDataController.shared.getUser(username: user.userName) {
                            self.groupMembers[indexPath.row] = updatedUser
                            DispatchQueue.main.async {
                                self.tableView.reloadRows(at: [indexPath], with: .none)
                            }
                        }
                    } catch {
                        print("Error removing friend: \(error)")
                    }
                }
            }
            
        case .you:
            // No action for current user
            break
        }
    }
    
    private func presentConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String,
        destructive: Bool,
        completion: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: destructive ? .destructive : .default) { _ in
            completion()
        }
        alert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
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


