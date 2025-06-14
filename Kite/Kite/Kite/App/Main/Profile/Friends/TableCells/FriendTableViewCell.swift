//
//  FriendTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 6/6/25.
//

import UIKit



class FriendTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let friendActionButton = UIButton(type: .system)

    // Callback to your VC
    var friendActionTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        friendActionButton.addTarget(self, action: #selector(handleFriendActionTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, friendActionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        friendActionButton.layer.cornerRadius = 6
        friendActionButton.clipsToBounds = true
        friendActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        friendActionButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            friendActionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            friendActionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            friendActionButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")

        friendActionButton.isUserInteractionEnabled = true
        friendActionButton.isEnabled = true
        friendActionButton.setTitleColor(.white, for: .normal)
        friendActionButton.backgroundColor = .systemBlue
        friendActionButton.layer.borderWidth = 0

        switch user.friendshipKey {
        case FriendshipStatus.friends.rawValue:
            friendActionButton.setTitle("Friends", for: .normal)
            friendActionButton.backgroundColor = .white
            friendActionButton.setTitleColor(.black, for: .normal)
            friendActionButton.layer.borderWidth = 1
            friendActionButton.layer.borderColor = UIColor.lightGray.cgColor
            friendActionButton.isEnabled = false

        case FriendshipStatus.invitePendingSentByYou.rawValue:
            friendActionButton.setTitle("Pending (You Sent)", for: .normal)
            friendActionButton.backgroundColor = .gray
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = false
            friendActionButton.isUserInteractionEnabled = false

        case FriendshipStatus.requestPendingSentByThem.rawValue:
            friendActionButton.setTitle("Respond (They Sent)", for: .normal)
            friendActionButton.backgroundColor = .systemOrange
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = false  // or true if you want to support response here

        case FriendshipStatus.you.rawValue:
            friendActionButton.setTitle("You", for: .normal)
            friendActionButton.isEnabled = false
            friendActionButton.backgroundColor = .lightGray

        case FriendshipStatus.notFriends.rawValue:
            fallthrough
        default:
            friendActionButton.setTitle("Add Friend", for: .normal)
            friendActionButton.backgroundColor = .systemBlue
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = true
        }
    }

    
    /*
    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")

        if user.friendshipKey == "friends" {
            friendActionButton.setTitle("Friends", for: .normal)
            friendActionButton.backgroundColor = .white
            friendActionButton.setTitleColor(.black, for: .normal)
            friendActionButton.layer.borderWidth = 1
            friendActionButton.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            friendActionButton.setTitle("Add Friend", for: .normal)
            friendActionButton.backgroundColor = UIColor.systemBlue
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.layer.borderWidth = 0
        }
    }
    
    */

    @objc private func handleFriendActionTapped() {
        friendActionTapped?()
    }
}
