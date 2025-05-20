//
//  FollowingViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/18/25.
//


import UIKit


class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct User {
        let username: String
        let fullName: String
        let imageName: String
        var isFollowing: Bool
    }

    class UserCell: UITableViewCell {
        static let identifier = "UserCell"

        let profileImageView = UIImageView()
        let usernameLabel = UILabel()
        let fullNameLabel = UILabel()
        let followButton = UIButton(type: .system)

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 24
            profileImageView.clipsToBounds = true

            usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false

            fullNameLabel.font = UIFont.systemFont(ofSize: 14)
            fullNameLabel.textColor = .gray
            fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

            followButton.translatesAutoresizingMaskIntoConstraints = false
            followButton.layer.cornerRadius = 6
            followButton.clipsToBounds = true
            followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

            contentView.addSubview(profileImageView)
            contentView.addSubview(usernameLabel)
            contentView.addSubview(fullNameLabel)
            contentView.addSubview(followButton)

            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 48),
                profileImageView.heightAnchor.constraint(equalToConstant: 48),

                usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

                fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
                fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

                followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        func configure(with user: User) {
            profileImageView.image = UIImage(named: user.imageName)
            usernameLabel.text = user.username
            fullNameLabel.text = user.fullName
            let title = user.isFollowing ? "Following" : "Follow"
            followButton.setTitle(title, for: .normal)
            followButton.backgroundColor = user.isFollowing ? .white : UIColor.systemRed
            followButton.setTitleColor(user.isFollowing ? .black : .white, for: .normal)
            followButton.layer.borderWidth = user.isFollowing ? 1 : 0
            followButton.layer.borderColor = user.isFollowing ? UIColor.lightGray.cgColor : nil
        }
    }

    private let tableView = UITableView()
    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Following"

        setupUsers()
        setupTableView()
    }

    private func setupUsers() {
        // Placeholder users for now, will be replaced with API data later
        let imageNames = ["background_1", "background_2", "background_3"]
        for i in 0..<20 {
            users.append(User(
                username: "user\(i)",
                fullName: "Full Name \(i)",
                imageName: imageNames[i % imageNames.count],
                isFollowing: i % 2 == 0
            ))
        }
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(with: user)
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    @objc private func followButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        users[index].isFollowing.toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}


//WORKING
/*
class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var placeholderUsers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Following"
        
        placeholderUsers = (1...20).map { "User \($0)" }

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = placeholderUsers[indexPath.row]
        return cell
    }
}
*/
