//
//  CreateGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/3/25.
//


import UIKit


class CreateGroupViewController: UIViewController, UITextFieldDelegate {
    private var friends: [Friend] = []
    private var selectedUsernames: Set<String> = []

    private let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCloseButton()
        setupLayout()
        nameField.delegate = self
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let localFriends = FriendDataController.shared.splitFriendsByStatus().friends
        if localFriends.isEmpty {
            Task {
                do {
                    try await FriendDataController.shared.fetchFriends()
                    self.friends = FriendDataController.shared.splitFriendsByStatus().friends
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to fetch friends: \(error)")
                }
            }
        } else {
            self.friends = localFriends
            self.tableView.reloadData()
        }
    }

    //ACTION
    //Buttons
    @objc private func createGroup() {
        guard let groupName = nameField.text, !groupName.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Group name is required")
            return
        }

        Task {
            do {
                // Sample data, just like in your Postman call
                let currentUser = "davey"
                let groupType = "kite"
                let groupPrivate = 1
                let groupUsers = Array(selectedUsernames)
                let notificationMessage = "Invited you to a new Group"
                let notificationType = "group_invite"
                let notificationLink = "http://localhost:3003/group/77"
                
                print("Group users to invite:", groupUsers)

                let response = try await GroupsAPI().newGroupFormData(
                    currentUser: currentUser,
                    groupName: groupName,
                    groupType: groupType,
                    groupPrivate: groupPrivate,
                    groupUsers: groupUsers,
                    notificationMessage: notificationMessage,
                    notificationType: notificationType,
                    notificationLink: notificationLink
                )
                /*
                let response = try await GroupsAPI().newGroup(
                    currentUser: currentUser,
                    groupName: groupName,
                    groupType: groupType,
                    groupPrivate: groupPrivate,
                    groupUsers: groupUsers,
                    notificationMessage: notificationMessage,
                    notificationType: notificationType,
                    notificationLink: notificationLink
                )
                */

                print("Created group response: \(response)")
                dismiss(animated: true)

            } catch {
                print("Failed to create group: \(error)")
            }
        }
    }

    
    @objc private func closeTapped() {
        let alert = UIAlertController(title: "Warning", message: "Do you want to stop creating the group?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.dismiss(animated: true)
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    //Functions
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasText = !(textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        createButton.isEnabled = hasText
        createButton.backgroundColor = hasText ? .systemBlue : .lightGray
    }
    
    //TABLE VIEW
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewGroupFriendTableViewCell.self, forCellReuseIdentifier: "NewGroupFriendTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView() // Removes empty cells
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -10)
        ])
    }

    
    //LAYOUT
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        view.addSubview(nameField)
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        createButton.addTarget(self, action: #selector(createGroup), for: .touchUpInside)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name your group"
        field.borderStyle = .roundedRect
        return field
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create group", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.isEnabled = false // initially disabled
        return button
    }()

    private func setupCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
}


extension CreateGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupFriendTableViewCell", for: indexPath) as? NewGroupFriendTableViewCell else {
            return UITableViewCell()
        }
        
        let friend = friends[indexPath.row]
        cell.configure(with: friend)
        
        // Track checked usernames
        cell.onCheckboxToggle = { [weak self] isChecked in
            guard let self = self else { return }
            if isChecked {
                self.selectedUsernames.insert(friend.friendName)
            } else {
                self.selectedUsernames.remove(friend.friendName)
            }
        }
        
        return cell
    }

}
