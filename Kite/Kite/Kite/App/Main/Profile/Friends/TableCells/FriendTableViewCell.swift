//
//  FriendTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 6/6/25.
//

import UIKit


//IndividualGroupMembersVC FriendTableViewCell

class FriendTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let friendActionButton = UIButton(type: .system)
    private let loadingSpinner = UIActivityIndicatorView(style: .medium)

    // Callback to your VC
    var friendActionTapped: (() -> Void)?
    
    // Track loading state
    private(set) var isLoading = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        friendActionButton.addTarget(self, action: #selector(handleFriendActionTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, friendActionButton, loadingSpinner].forEach {
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
        
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.color = .white

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
            friendActionButton.widthAnchor.constraint(equalToConstant: 100),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: friendActionButton.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: friendActionButton.centerYAnchor)
        ])
    }

    func configure(with user: User) {
        usernameLabel.text = "@\(user.userName)"
        fullNameLabel.text = user.displayName
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")

        friendActionButton.isUserInteractionEnabled = true
        friendActionButton.isEnabled = true
        friendActionButton.setTitleColor(.white, for: .normal)
        friendActionButton.backgroundColor = .systemBlue
        friendActionButton.layer.borderWidth = 0
        friendActionButton.isHidden = false

        switch user.friendshipStatus {
        case .friends:
            friendActionButton.setTitle("Friends", for: .normal)
            friendActionButton.backgroundColor = .white
            friendActionButton.setTitleColor(.black, for: .normal)
            friendActionButton.layer.borderWidth = 1
            friendActionButton.layer.borderColor = UIColor.lightGray.cgColor
            friendActionButton.isEnabled = true

        case .invitePendingSentByYou:
            friendActionButton.setTitle("Cancel", for: .normal)
            friendActionButton.backgroundColor = UIColor(red: 1.0, green: 0.18, blue: 0.48, alpha: 1.0)
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = true
            friendActionButton.isUserInteractionEnabled = true

        case .requestPendingSentByThem:
            friendActionButton.setTitle("Accept", for: .normal)
            friendActionButton.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = true

        case .you:
            friendActionButton.isHidden = true

        case .notFriends, .unknown:
            friendActionButton.setTitle("Add Friend", for: .normal)
            friendActionButton.backgroundColor = .systemBlue
            friendActionButton.setTitleColor(.white, for: .normal)
            friendActionButton.isEnabled = true
        }
        
        // Reset loading state
        setLoading(false)
    }
    
    func setLoading(_ loading: Bool) {
        isLoading = loading
        friendActionButton.isEnabled = !loading
        friendActionButton.alpha = loading ? 0.6 : 1.0
        
        if loading {
            friendActionButton.setTitle("", for: .normal)
            loadingSpinner.startAnimating()
        } else {
            loadingSpinner.stopAnimating()
        }
    }

    
    @objc private func handleFriendActionTapped() {
        friendActionTapped?()
    }
}
