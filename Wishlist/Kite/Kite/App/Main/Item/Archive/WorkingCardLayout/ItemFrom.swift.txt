//
//  ItemFrom.swift
//  Kite
//
//  Created by David Vasquez on 10/4/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

// ItemFrom displays who posted. It does not refresh the table.

final class ItemFrom: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?
    private let avatarSize: CGFloat = 48

    //UI COMPONENTS
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postedAtLabel = UILabel()
    private let userTextStack = UIStackView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        profileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: profileImageView, diameter: avatarSize)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        usernameLabel.font = Fonts.postUsernameFont
        usernameLabel.textColor = Colors.primaryGrayText
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail

        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.postedAtTextColor
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail

        userTextStack.axis = .vertical
        userTextStack.alignment = .leading
        userTextStack.spacing = 0
        userTextStack.translatesAutoresizingMaskIntoConstraints = false
        userTextStack.addArrangedSubview(usernameLabel)
        userTextStack.addArrangedSubview(postedAtLabel)

        addSubview(profileImageView)
        addSubview(userTextStack)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            profileImageView.heightAnchor.constraint(equalToConstant: avatarSize),

            userTextStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Layout.spacingM),
            userTextStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            userTextStack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postedAtLabel.text = post.timeMessage ?? "now"

        guard let username = post.postFrom, !username.isEmpty else {
            usernameLabel.text = nil
            return
        }

        usernameLabel.text = username
        loadUserProfile(username: username)
    }

    private func loadUserProfile(username: String) {
        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                return
            }

            guard loadUserName == username else { return }

            await MainActor.run {
                guard self.loadUserName == username else { return }
                if let image = user.profileImage {
                    self.profileImageView.image = image
                }
            }
        }
    }
}
