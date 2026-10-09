//
//  ItemCaption.swift
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

// ItemCaption shows who posted and the caption.
// Layout: [ image | username / posted / caption ]

final class ItemCaption: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?
    private let avatarSize: CGFloat = 48

    //UI COMPONENTS
    private let imageContainer = UIView()
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postedAtLabel = UILabel()
    private let captionLabel = UILabel()
    private let textStack = UIStackView()

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
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.backgroundColor = .clear
        addSubview(imageContainer)

        profileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: profileImageView, diameter: avatarSize)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(profileImageView)

        usernameLabel.font = Fonts.postUsernameFont
        usernameLabel.textColor = Colors.primaryGrayText
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail

        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.postedAtTextColor
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail

        captionLabel.font = Fonts.postCaptionFont
        captionLabel.textColor = Colors.postCaptionFontColor
        captionLabel.numberOfLines = 0
        captionLabel.lineBreakMode = .byTruncatingTail

        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = Layout.spacingXS
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(usernameLabel)
        textStack.addArrangedSubview(postedAtLabel)
        textStack.addArrangedSubview(captionLabel)
        addSubview(textStack)

        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: avatarSize),
            imageContainer.heightAnchor.constraint(equalToConstant: avatarSize),
            imageContainer.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            profileImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),

            textStack.topAnchor.constraint(equalTo: topAnchor, constant: -Layout.spacingXS),
            textStack.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: Layout.spacingM),
            textStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postedAtLabel.text = post.timeMessage ?? "now"

        let caption = post.postCaption?.trimmingCharacters(in: .whitespacesAndNewlines)
        captionLabel.text = (caption?.isEmpty == false) ? caption : nil
        captionLabel.isHidden = captionLabel.text == nil

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
