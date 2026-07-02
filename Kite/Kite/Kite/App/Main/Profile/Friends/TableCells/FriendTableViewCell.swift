//
//  FriendTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 6/6/25.
//

import UIKit

//FriendTableViewCell -> Class:: YourFriendsTableViewCell
//FriendTableViewCell -> Class:: FriendTableViewCell

//IndividualGroupMembersVC FriendTableViewCell

class FriendTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()

    let addFriendButton = UIButton(type: .system)
    let cancelFriendInviteButton = UIButton(type: .system)
    let removeFriendButton = UIButton(type: .system)
    let acceptButton = UIButton(type: .system)
    let declineButton = UIButton(type: .system)

    private let loadingSpinner = UIActivityIndicatorView(style: .medium)
    private var loadingTargetButton: UIButton?

    // Callbacks to your VC
    var addFriendTapped: (() -> Void)?
    var cancelFriendInviteTapped: (() -> Void)?
    var removeFriendTapped: (() -> Void)?
    var acceptFriendInviteTapped: (() -> Void)?
    var declineFriendInviteTapped: (() -> Void)?

    private(set) var isLoading = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()

        addFriendButton.addTarget(self, action: #selector(handleAddFriendTapped), for: .touchUpInside)
        cancelFriendInviteButton.addTarget(self, action: #selector(handleCancelTapped), for: .touchUpInside)
        removeFriendButton.addTarget(self, action: #selector(handleRemoveTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(handleAcceptTapped), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(handleDeclineTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        addFriendTapped = nil
        cancelFriendInviteTapped = nil
        removeFriendTapped = nil
        acceptFriendInviteTapped = nil
        declineFriendInviteTapped = nil
        setLoading(false)
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel,
         addFriendButton, cancelFriendInviteButton, removeFriendButton,
         acceptButton, declineButton, loadingSpinner].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        addFriendButton.setTitle("Add Friend", for: .normal)
        Buttons.addFriendButtonStyle(button: addFriendButton)

        cancelFriendInviteButton.setTitle("Cancel", for: .normal)
        Buttons.cancelFriendInviteButtonStyle(button: cancelFriendInviteButton)

        removeFriendButton.setTitle("Friends", for: .normal)
        Buttons.removeFriendButtonStyle(button: removeFriendButton)

        acceptButton.setTitle("Accept", for: .normal)
        Buttons.acceptFriendRequestButtonStyle(button: acceptButton)

        declineButton.setTitle("Decline", for: .normal)
        Buttons.declineFriendRequestButtonStyle(button: declineButton)

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

            addFriendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addFriendButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addFriendButton.widthAnchor.constraint(equalToConstant: 100),

            cancelFriendInviteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cancelFriendInviteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cancelFriendInviteButton.widthAnchor.constraint(equalToConstant: 100),

            removeFriendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            removeFriendButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            removeFriendButton.widthAnchor.constraint(equalToConstant: 100),

            acceptButton.trailingAnchor.constraint(equalTo: declineButton.leadingAnchor, constant: -8),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 80),

            declineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.widthAnchor.constraint(equalToConstant: 80),

            loadingSpinner.centerXAnchor.constraint(equalTo: removeFriendButton.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: removeFriendButton.centerYAnchor)
        ])
    }

    func configure(with user: User, parentViewController: String? = nil) {
        if let parentViewController {
            printCellLoadInfo(cellName: "FriendTableViewCell", parentVC: parentViewController)
        }

        usernameLabel.text = "@\(user.userName)"
        fullNameLabel.text = user.displayName
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")

        addFriendButton.isHidden = true
        cancelFriendInviteButton.isHidden = true
        removeFriendButton.isHidden = true
        acceptButton.isHidden = true
        declineButton.isHidden = true
        loadingTargetButton = nil

        switch user.friendshipStatus {
        case .friends:
            removeFriendButton.isHidden = false
            loadingTargetButton = removeFriendButton

        case .invitePendingSentByYou:
            cancelFriendInviteButton.isHidden = false
            loadingTargetButton = cancelFriendInviteButton

        case .requestPendingSentByThem:
            acceptButton.isHidden = false
            declineButton.isHidden = false
            loadingTargetButton = acceptButton

        case .notFriends, .unknown:
            addFriendButton.isHidden = false
            loadingTargetButton = addFriendButton

        case .you:
            break
        }

        setLoading(false)
    }

    func setLoading(_ loading: Bool) {
        isLoading = loading

        [addFriendButton, cancelFriendInviteButton, removeFriendButton, acceptButton, declineButton].forEach {
            $0.isEnabled = !loading
        }

        loadingTargetButton?.alpha = loading ? 0.6 : 1.0

        if loading {
            loadingTargetButton?.setTitle("", for: .normal)
            loadingSpinner.startAnimating()
        } else {
            loadingSpinner.stopAnimating()
            restoreButtonTitles()
        }
    }

    private func restoreButtonTitles() {
        addFriendButton.setTitle("Add Friend", for: .normal)
        cancelFriendInviteButton.setTitle("Cancel", for: .normal)
        removeFriendButton.setTitle("Friends", for: .normal)
        acceptButton.setTitle("Accept", for: .normal)
        declineButton.setTitle("Decline", for: .normal)
    }

    @objc private func handleAddFriendTapped() {
        addFriendTapped?()
    }

    @objc private func handleCancelTapped() {
        cancelFriendInviteTapped?()
    }

    @objc private func handleRemoveTapped() {
        removeFriendTapped?()
    }

    @objc private func handleAcceptTapped() {
        acceptFriendInviteTapped?()
    }

    @objc private func handleDeclineTapped() {
        declineFriendInviteTapped?()
    }
}
