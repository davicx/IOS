//
//  FriendTableUserCell.swift
//  Kite
//
//  Created by David Vasquez on 5/21/25.
//


import UIKit


class YourFriendsTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)
    let acceptButton = UIButton(type: .system)
    let declineButton = UIButton(type: .system)

    // Callbacks to your VC
    var cancelRequestTapped: (() -> Void)?
    var acceptInviteTapped: (() -> Void)?
    var declineInviteTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()

        followButton.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(handleAcceptTapped),for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(handleDeclineTapped),for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView,
         usernameLabel,
         fullNameLabel,
         followButton,
         acceptButton,
         declineButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        [followButton, acceptButton, declineButton].forEach {
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.contentEdgeInsets = UIEdgeInsets(top: 8,
                                                left: 12,
                                                bottom: 8,
                                                right: 12)
        }

        // Default titles (we’ll hide/show as needed)
        acceptButton.setTitle("Accept", for: .normal)
        declineButton.setTitle("Decline", for: .normal)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                   constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,
                                               constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -12),

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                   constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 100),

            acceptButton.trailingAnchor.constraint(equalTo: followButton.leadingAnchor,
                                                   constant: -8),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 80),

            declineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -16),
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder

        // Hide all by default
        followButton.isHidden = true
        acceptButton.isHidden = true
        declineButton.isHidden = true

        switch user.friendshipKey {
        case "friends":
            followButton.isHidden = false
            followButton.setTitle("Friends", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.lightGray.cgColor

        case "request_pending":
            followButton.isHidden = false
            followButton.setTitle("Cancel", for: .normal)
            followButton.backgroundColor = UIColor(red: 1.0,
                                                  green: 0.18,
                                                  blue: 0.48,
                                                  alpha: 1.0) // pink
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0

        case "invite_pending":
            acceptButton.isHidden = false
            declineButton.isHidden = false

            acceptButton.backgroundColor = UIColor(red: 0.1,
                                                   green: 0.7,
                                                   blue: 0.2,
                                                   alpha: 1.0)
            declineButton.backgroundColor = UIColor(red: 0.9,
                                                    green: 0.2,
                                                    blue: 0.2,
                                                    alpha: 1.0)

        default:
            break
        }
    }

    @objc private func handleFollowTapped() {
        cancelRequestTapped?()
    }

    @objc private func handleAcceptTapped() {
        acceptInviteTapped?()
    }

    @objc private func handleDeclineTapped() {
        declineInviteTapped?()
    }
}


//WORKING
/*
class YourFriendsTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)
    let acceptButton = UIButton(type: .system)
    let declineButton = UIButton(type: .system)

    var cancelRequestTapped: (() -> Void)?
    var acceptInviteTapped: (() -> Void)?
    var declineInviteTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        followButton.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(handleAcceptTapped), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(handleDeclineTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, followButton, acceptButton, declineButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        [followButton, acceptButton, declineButton].forEach {
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        }

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

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 100),

            acceptButton.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 60),

            declineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder

        acceptButton.isHidden = true
        declineButton.isHidden = true
        followButton.isHidden = false

        switch user.friendshipKey {
        case "request_pending":
            followButton.setTitle("Cancel", for: .normal)
            followButton.backgroundColor = .lightGray
            followButton.setTitleColor(.white, for: .normal)

        case "invite_pending":
            followButton.isHidden = true
            acceptButton.isHidden = false
            declineButton.isHidden = false

            acceptButton.setTitle("Accept", for: .normal)
            acceptButton.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
            acceptButton.setTitleColor(.white, for: .normal)

            declineButton.setTitle("Decline", for: .normal)
            declineButton.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
            declineButton.setTitleColor(.white, for: .normal)

        default:
            followButton.setTitle("Friends", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    @objc private func handleFollowTapped() {
        //cancelRequestTapped?()
        print("cancelRequestTapped")
    }

    @objc private func handleAcceptTapped() {
        //acceptInviteTapped?()
        print("acceptInviteTapped")

    }

    @objc private func handleDeclineTapped() {
        //declineInviteTapped?()
        print("declineInviteTapped")

    }
}
 */

/*
 //SIMPLE WORKING
class YourFriendsTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        followButton.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
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
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 96)
        ])

    }

    @objc private func handleFollowTapped() {
        //followButtonTapped?()
        print("HIYA!")
    }
    
    let pinkColor = UIColor(red: 1.0, green: 0.18, blue: 0.48, alpha: 1.0) // #FF2D7E

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder

        if user.requestPending == 1 {
            // Show pink Follow button
            followButton.setTitle("Add Friend", for: .normal)
            followButton.backgroundColor = UIColor(red: 1.0, green: 0.18, blue: 0.48, alpha: 1.0) // Pink
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0
        } else {
            // Show default "Following" style
            followButton.setTitle("Friends", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}


*/
