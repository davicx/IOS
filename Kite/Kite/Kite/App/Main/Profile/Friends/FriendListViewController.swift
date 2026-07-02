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

    // Track loading state per username to prevent multiple simultaneous requests
    private var loadingUsernames: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friend List"
        view.backgroundColor = .white

        setupTableView()

        if let name = friendUserName {
            print("Viewing friend list of: \(name)")
            // Later: Fetch friendListArray via API
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        // Set loading state if this user is currently loading
        if loadingUsernames.contains(friend.userName) {
            cell.setLoading(true)
        }

        // Action for "Add Friend" button
        cell.addFriendTapped = { [weak self] in
            guard let self = self else { return }
            
            // Prevent multiple simultaneous requests for the same user
            guard !self.loadingUsernames.contains(friend.userName) else { return }
            
            self.loadingUsernames.insert(friend.userName)
            cell.setLoading(true)
            
            print("Adding friend: \(friend.userName)")

            Task {
                do {
                    // Use withTimeout to handle timeout
                    let updatedUser = try await withTimeout(seconds: Constants.Timeout.friendTimeout) {
                        await UserLogic.shared.sendFriendRequest(to: friend)
                    }

                    DispatchQueue.main.async {
                        self.loadingUsernames.remove(friend.userName)
                        if let updatedUser = updatedUser {
                            self.friendListArray[indexPath.row] = updatedUser
                            cell.configure(with: updatedUser)
                        } else {
                            cell.setLoading(false)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.loadingUsernames.remove(friend.userName)
                        cell.setLoading(false)
                        self.showErrorAlert(message: "Failed to send friend request. Please try again.")
                    }
                }
            }
        }

        return cell
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriend = friendListArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

