//
//  FollowingViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/18/25.
//


import UIKit


class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users: [Friend] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Following"
        view.backgroundColor = .white
        
        for user in users {
            print("User: \(user.requestSentBy),  \(user.friendName), requestPending: \(user.requestPending)")
        }
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72

        // Register your custom cell
        tableView.register(YourFriendsTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell)
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.friendCell, for: indexPath) as! YourFriendsTableViewCell
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = users[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

