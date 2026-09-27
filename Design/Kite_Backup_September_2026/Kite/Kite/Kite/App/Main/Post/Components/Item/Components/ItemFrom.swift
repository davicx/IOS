//
//  ItemFrom.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

// ItemFrom is a UI renderer. It displays who posted. It does NOT refresh the table.

final class ItemFrom: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?
    private let userImageDiameter: CGFloat = 38
    private let userImageAreaWidth: CGFloat = 46

    //UI COMPONENTS
    private let userImageArea = UIView()
    private let userImageView = UIImageView()

    private let userNameView = UIView()
    private let userNameLabel = UILabel()

    private let postTimeView = UIView()
    private let postTimeLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        setupUserImageArea()
        setupUserNameView()
        setupPostTimeView()
        activateLayout()
    }

    //LAYOUT and UI
    private func setupUserImageArea() {
        userImageArea.backgroundColor = .clear
        userImageArea.translatesAutoresizingMaskIntoConstraints = false

        userImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: userImageView, diameter: userImageDiameter)
        userImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(userImageArea)
        userImageArea.addSubview(userImageView)
    }

    private func setupUserNameView() {
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.backgroundColor = .clear

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = Fonts.postUsernameFont
        userNameLabel.textColor = Colors.primaryGrayText
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail
        userNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        userNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        addSubview(userNameView)
        userNameView.addSubview(userNameLabel)
    }

    private func setupPostTimeView() {
        postTimeView.translatesAutoresizingMaskIntoConstraints = false
        postTimeView.backgroundColor = .clear

        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.font = Fonts.postedAtFont
        postTimeLabel.textColor = Colors.postedAtTextColor
        postTimeLabel.numberOfLines = 1
        postTimeLabel.lineBreakMode = .byTruncatingTail
        postTimeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        postTimeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addSubview(postTimeView)
        postTimeView.addSubview(postTimeLabel)
    }

    private func activateLayout() {
        NSLayoutConstraint.activate([
            userImageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageArea.topAnchor.constraint(equalTo: topAnchor),
            userImageArea.widthAnchor.constraint(equalToConstant: userImageAreaWidth),
            userImageArea.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Equal vertical padding (avatar stays 38; header shrinks via padding only)
            userImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: Layout.spacingXS),
            userImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: Layout.spacingXS),
            userImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -Layout.spacingXS),
            userImageView.widthAnchor.constraint(equalToConstant: userImageDiameter),
            userImageView.heightAnchor.constraint(equalToConstant: userImageDiameter),
            userImageArea.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: Layout.spacingXS),

            userNameView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: 2),
            userNameView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 22),

            userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor),

            postTimeView.leadingAnchor.constraint(equalTo: userNameView.trailingAnchor, constant: Layout.spacingXS),
            postTimeView.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            postTimeView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Layout.spacingXS),
            postTimeView.heightAnchor.constraint(equalTo: userNameView.heightAnchor),

            postTimeLabel.leadingAnchor.constraint(equalTo: postTimeView.leadingAnchor),
            postTimeLabel.centerYAnchor.constraint(equalTo: postTimeView.centerYAnchor, constant: 1),
            postTimeLabel.trailingAnchor.constraint(equalTo: postTimeView.trailingAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postTimeLabel.text = post.timeMessage ?? "now"

        guard let username = post.postFrom, !username.isEmpty else {
            userNameLabel.text = nil
            return
        }

        userNameLabel.text = username
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
                    self.userImageView.image = image
                }
            }
        }
    }
}
