//
//  UserViewController.swift
//  TableViewPlayground
//
//  Created by David Vasquez on 11/27/25.
//

import UIKit


class UserViewController: UIViewController {

    var user: User!

    private let nameLabel = UILabel()
    private let likeLabel = UILabel()
    private let plusButton = UIButton(type: .system)
    private let minusButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        likeLabel.font = .systemFont(ofSize: 22)

        nameLabel.text = user.name
        likeLabel.text = "Likes: \(user.likes)"

        plusButton.setTitle("+", for: .normal)
        minusButton.setTitle("-", for: .normal)
        plusButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)

        view.addSubview(nameLabel)
        view.addSubview(likeLabel)
        view.addSubview(plusButton)
        view.addSubview(minusButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),

            likeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),

            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            plusButton.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 40),

            minusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            minusButton.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 40)
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshUI),
            name: .userUpdated,
            object: nil
        )
    }

    @objc private func incrementTapped() {
        UserDataController.shared.incrementLikes(for: user)
    }

    @objc private func decrementTapped() {
        UserDataController.shared.decrementLikes(for: user)
    }

    @objc private func refreshUI() {
        likeLabel.text = "Likes: \(user.likes)"
    }
}

/*
class UserViewController: UIViewController {
    
    var user: User!
    
    private let nameLabel = UILabel()
    private let likeLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        likeLabel.font = .systemFont(ofSize: 22)
        
        nameLabel.text = user.name
        likeLabel.text = "Likes: \(user.likes)"
        
        likeButton.setTitle("❤️ Like", for: .normal)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        
        view.addSubview(nameLabel)
        view.addSubview(likeLabel)
        view.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            likeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 40)
        ])
        
        // 🔥 Listen for updates (optional)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshUI),
            name: .userUpdated,
            object: nil
        )
    }
    
    @objc private func didTapLike() {
        UserDataController.shared.incrementLikes(for: user)
    }
    
    @objc private func refreshUI() {
        likeLabel.text = "Likes: \(user.likes)"
    }
}
 */

//WORKS
/*
class UserViewController: UIViewController {

    var user: User?

    private let usernameLabel = UILabel()
    private let likeLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    private let unlikeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        guard let user else { return }

        // OBSERVE UPDATES
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userUpdated(_:)),
            name: .userUpdated,
            object: nil
        )

        // LABELS
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "You clicked \(user.username)"
        usernameLabel.font = .systemFont(ofSize: 24, weight: .bold)

        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.text = "\(user.likeCount)"
        likeLabel.font = .systemFont(ofSize: 20)

        // BUTTONS
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setTitle("❤️ Like", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        unlikeButton.translatesAutoresizingMaskIntoConstraints = false
        unlikeButton.setTitle("💔 Unlike", for: .normal)
        unlikeButton.addTarget(self, action: #selector(unlikeTapped), for: .touchUpInside)

        view.addSubview(usernameLabel)
        view.addSubview(likeButton)
        view.addSubview(unlikeButton)
        view.addSubview(likeLabel)

        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),

            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),

            unlikeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unlikeButton.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 20),

            likeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeLabel.topAnchor.constraint(equalTo: unlikeButton.bottomAnchor, constant: 20)
        ])
    }

    // MARK: - Actions
    @objc private func likeTapped() {
        guard let username = user?.username else { return }
        UserDataController.shared.like(username)
    }

    @objc private func unlikeTapped() {
        guard let username = user?.username else { return }
        UserDataController.shared.unlike(username)
    }

    // MARK: - Sync UI when data updates
    @objc private func userUpdated(_ note: Notification) {
        guard let username = user?.username else { return }
        guard let updatedUser = UserDataController.shared.getUser(username) else { return }

        DispatchQueue.main.async {
            self.likeLabel.text = "\(updatedUser.likeCount)"
        }
    }
}
*/


/*
class UserViewController: UIViewController {

    var username: String?   // <-- This will receive the value

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        if let username = username {
            print("Received: \(username)")
        }

        // Example label on screen:
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You clicked \(username ?? "Unknown")"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

*/
