//
//  IndividualPostViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit


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



//NEW PULL IN 
/*
 import UIKit

 final class IndividualPostViewController: UIViewController {



     // MARK: - Lifecycle





 }

 */

//WORKING
//ORIGINAL
/*

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

*/


//OLDER

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

