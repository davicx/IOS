//
//  IndividualPostViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit


class IndividualPostViewController: UIViewController {

    var selectedUser: User?

    // MARK: - UI Elements

    private let imageContainer = UIView()
    private let userImageView = UIImageView()

    private let userNameLabel = UILabel()

    private let followButton = UIButton(type: .system)
    private let unfollowButton = UIButton(type: .system)

    private let followersStackView = UIStackView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViews()
        setupConstraints()
        configureWithUser()
    }

    // MARK: - Setup

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

        // Buttons
        followButton.translatesAutoresizingMaskIntoConstraints = false
        unfollowButton.translatesAutoresizingMaskIntoConstraints = false

        followButton.setTitle("Follow", for: .normal)
        unfollowButton.setTitle("Unfollow", for: .normal)

        view.addSubview(followButton)
        view.addSubview(unfollowButton)

        // Followers stack
        followersStackView.translatesAutoresizingMaskIntoConstraints = false
        followersStackView.axis = .vertical
        followersStackView.spacing = 8
        view.addSubview(followersStackView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([

            // Image area (top)
            imageContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 180),

            // User image (circle)
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
            followButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            followButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            followButton.heightAnchor.constraint(equalToConstant: 44),

            // Unfollow button
            unfollowButton.topAnchor.constraint(equalTo: followButton.topAnchor),
            unfollowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unfollowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            unfollowButton.heightAnchor.constraint(equalToConstant: 44),

            // Followers list
            followersStackView.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 16),
            followersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            followersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        // Circle image
        userImageView.layer.cornerRadius = 60
    }

    // MARK: - Configure

    private func configureWithUser() {
        guard let user = selectedUser else { return }

        userImageView.image = user.userImage
        userNameLabel.text = user.userName

        // Title label for followers
        let titleLabel = UILabel()
        titleLabel.text = "Followers"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        followersStackView.addArrangedSubview(titleLabel)

        // One label per follower
        for follower in user.userFollowers {
            let label = UILabel()
            label.text = follower
            label.font = .systemFont(ofSize: 16)
            followersStackView.addArrangedSubview(label)
        }
    }
}


/*
class IndividualPostViewController: UIViewController {

    var selectedUser: User?

    let postTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(postTextLabel)

        // NOT laying out yet
        postTextLabel.text = selectedUser?.userName
        print(selectedUser?.userName ?? "No user selected")
    }
}


*/
/*
class IndividualPostViewController: UIViewController {
    
    var selectedVideoTitle: String = ""
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedVideoTitle)
        postTextLabel.text = selectedVideoTitle
    }

}
*/

