//
//  FullFile.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/30/25.
//  Copyright © 2025 David Vasquez. All rights reserved.
//

import Foundation

/*
class ViewController: UIViewController {

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNotifications()

        //Get Data from API
        Task {
            await UserDataController.shared.fetchUsers()
        }
    }
    
    //DATA: User Data
    @objc private func usersUpdated() {
        tableView.reloadData()
    }
    
    @objc private func userUpdated(_ notification: Notification) {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(usersUpdated),
            name: .usersUpdated,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userUpdated(_:)),
            name: .userUpdated,
            object: nil
        )
    }

    //TABLE VIEW
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataController.shared.getAllUsers().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let users = UserDataController.shared.getAllUsers()
        let currentUser = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell

        cell.setUser(user: currentUser)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = UserDataController.shared.getAllUsers()[indexPath.row]
        performSegue(withIdentifier: "showIndividualUser", sender: user.userName)
        
    }

    //Send Just the username
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIndividualUser",
           let destination = segue.destination as? IndividualPostViewController,
           let username = sender as? String {
            destination.selectedUsername = username
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


class UserCell: UITableViewCell {

    // Containers (50% / 50%)
    private let leftContainer = UIView()
    private let rightContainer = UIView()

    // UI
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let followerCountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none

        [leftContainer, rightContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        [userImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            leftContainer.addSubview($0)
        }

        [userNameLabel, followerCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            rightContainer.addSubview($0)
        }

        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 40

        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        followerCountLabel.font = .systemFont(ofSize: 14)
        followerCountLabel.textColor = .gray
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            // Left container (50%)
            leftContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            // Right container (50%)
            rightContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightContainer.leadingAnchor.constraint(equalTo: leftContainer.trailingAnchor),

            // Image 80x80 centered left
            userImageView.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 80),
            userImageView.heightAnchor.constraint(equalToConstant: 80),

            // Username label
            userNameLabel.topAnchor.constraint(equalTo: rightContainer.topAnchor, constant: 25),
            userNameLabel.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: 12),
            userNameLabel.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor, constant: -12),

            // Follower count label
            followerCountLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 6),
            followerCountLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            followerCountLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor)
        ])
    }

    func setUser(user: User) {
        userNameLabel.text = user.userName
        followerCountLabel.text = "Followers: \(user.userFollowers.count)"
        userImageView.image = user.userImage
    }
}


class IndividualPostViewController: UIViewController {

    //DATA Identity-only (no stale User object)
    var selectedUsername: String!

    //UI ELEMENTS
    private let imageContainer = UIView()
    private let userImageView = UIImageView()
    
    private let userNameLabel = UILabel()

    private let followButton = UIButton(type: .system)
    private let unfollowButton = UIButton(type: .system)

    private let followersStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        configureWithUser()

        //DATA: Listen for updates to this user
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userUpdatedNotification(_:)),
            name: .userUpdated,
            object: nil
        )

        // Button action
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }

   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //LAYOUT
     private func setupViews() {
         // Image container
         imageContainer.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(imageContainer)

         // User image
         userImageView.translatesAutoresizingMaskIntoConstraints = false
         userImageView.contentMode = .scaleAspectFill
         userImageView.clipsToBounds = true
         imageContainer.addSubview(userImageView)

         // Username
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         userNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
         userNameLabel.textAlignment = .center
         view.addSubview(userNameLabel)

         // Follow button
         followButton.translatesAutoresizingMaskIntoConstraints = false
         followButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
         followButton.layer.cornerRadius = 6
         followButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
         followButton.setTitleColor(.white, for: .normal)
         view.addSubview(followButton)

         // Followers stack
         followersStackView.translatesAutoresizingMaskIntoConstraints = false
         followersStackView.axis = .vertical
         followersStackView.spacing = 8
         view.addSubview(followersStackView)
     }

     private func setupConstraints() {
         NSLayoutConstraint.activate([
             // Image container
             imageContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             imageContainer.heightAnchor.constraint(equalToConstant: 180),

             // User image
             userImageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
             userImageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
             userImageView.widthAnchor.constraint(equalToConstant: 120),
             userImageView.heightAnchor.constraint(equalToConstant: 120),

             // Username
             userNameLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 12),
             userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

             // Follow button
             followButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
             followButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             followButton.widthAnchor.constraint(equalToConstant: 140),
             followButton.heightAnchor.constraint(equalToConstant: 44),

             // Followers stack
             followersStackView.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 16),
             followersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             followersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
         ])

         // Circle user image
         userImageView.layer.cornerRadius = 60
     }
     
    
    //LOGIC
    //Set Cell up
    func configureWithUser() {
        guard let user = UserDataController.shared.getUserByUsername(userName: selectedUsername) else { return }

        // Basic info
        userImageView.image = user.userImage
        userNameLabel.text = user.userName

        // Followers list
        followersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let titleLabel = UILabel()
        titleLabel.text = "Followers"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        followersStackView.addArrangedSubview(titleLabel)

        for follower in user.userFollowers {
            let label = UILabel()
            label.text = follower
            label.font = .systemFont(ofSize: 16)
            followersStackView.addArrangedSubview(label)
        }

        // Follow button state
        let currentUser = AuthManager.shared.currentUser
        let isFollowing = user.userFollowers.contains(currentUser)
        followButton.setTitle(isFollowing ? "Following" : "Follow", for: .normal)
        followButton.backgroundColor = isFollowing ? UIColor.systemGray : UIColor.systemBlue
    }
    
    //ACTIONS
    @objc private func didTapFollowButton() {
        guard let user = UserDataController.shared.getUserByUsername(userName: selectedUsername) else { return }

        let currentUser = AuthManager.shared.currentUser
        let isFollowing = user.userFollowers.contains(currentUser)

        if isFollowing {
            // Show alert to unfollow
            let alert = UIAlertController(title: "Unfollow?", message: "Do you want to unfollow \(user.userName)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Unfollow", style: .destructive) { _ in
                UserDataController.shared.unfollowUser(targetUserName: self.selectedUsername, followerUsername: currentUser)
            })
            present(alert, animated: true)
        } else {
            // Follow immediately
            UserDataController.shared.followUser(targetUserName: selectedUsername, followerUsername: currentUser)
        }
    }

    //Notification
    @objc private func userUpdatedNotification(_ notification: Notification) {
        guard let updatedUsername = notification.object as? String,
              updatedUsername == selectedUsername else { return }
        configureWithUser()
    }
    
}

//DATA
final class UserDataController {
    
    private let usersAPI = UsersAPI()

    static let shared = UserDataController()
    private init() {}

    // Keyed by userName for fast lookup & no duplicates
    private(set) var users: [String: User] = [:]
    
    // Get all users
    func fetchUsers() async {
        do {
            // Step 1 – Call API
            let fetchedUsers = try await usersAPI.getUsersAPI()

            // Step 2 – Clear old data
            users.removeAll()

            // Step 3 – Store users
            for user in fetchedUsers {
                users[user.userName] = user
            }

            // Step 4 – Notify app
            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .usersUpdated,
                    object: nil
                )
            }

        } catch {
            print("UserDataController: Failed to fetch users - \(error)")
        }
    }

    // Read single user by username
    //CALL: let user = UserDataController.shared.getUserByUsername(userName: "Alice")
    func getUserByUsername(userName: String) -> User? {
        return users[userName]
    }

    // Read all users
    func getAllUsers() -> [User] {
        return Array(users.values)
    }

    // Follow user
    func followUser(targetUserName: String, followerUsername: String) {
        // Locate user
        guard var user = users[targetUserName] else { return }

        // Mutate data (idempotent)
        if !user.userFollowers.contains(followerUsername) {
            user.userFollowers.append(followerUsername)
        }

        users[targetUserName] = user

        // Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserName
        )
    }

    // Unfollow user
    func unfollowUser(targetUserName: String, followerUsername: String) {
        // Locate user
        guard var user = users[targetUserName] else { return }

        // Mutate data
        user.userFollowers.removeAll {
            $0 == followerUsername
        }

        users[targetUserName] = user

        // Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserName
        )
    }

    // Debug print users
    func debugPrintUsers() {
        for (userName, user) in users {
            print("USERNAME: \(userName)")
            print("Name: \(user.userName)")
            print("Followers: \(user.userFollowers)")
            print("-------------")
        }
    }
}

extension Notification.Name {
    static let usersUpdated = Notification.Name("usersUpdated")
    static let userUpdated  = Notification.Name("userUpdated")
}


final class UsersAPI {

    //API: Call Get Users
    func getUsersAPI() async throws -> [User] {

        if #available(iOS 13.0, *) {
            // Non-blocking async/await delay
            try await Task.sleep(nanoseconds: 500_000_000)
        } else {
            // Pre-iOS 13 fallback — MUST NOT be on main thread
            Thread.sleep(forTimeInterval: 0.5)
        }

        // Pretend this came from the backend
        return createUsers()
    }

    
    private func createUsers() -> [User] {

        let david = User(
            userName: "David",
            userImage: UIImage(named: "river"),
            userFollowers: ["Sam", "Merry"]
        )

        let frodo = User(
            userName: "Frodo",
            userImage: UIImage(named: "train"),
            userFollowers: ["Sam", "Merry"]
        )

        let sam = User(
            userName: "Sam",
            userImage: UIImage(named: "night")
        )

        let merry = User(
            userName: "Merry",
            userImage: UIImage(named: "whale"),
            userFollowers: ["Sam"]
        )

        return [david, frodo, sam, merry]
    }
}

*/
