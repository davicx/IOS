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

// ItemFrom is a UI renderer. It displays who posted + caption. It does NOT refresh the table.

final class ItemFrom: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?
    private let userImageDiameter: CGFloat = 38
    private let userImageAreaWidth: CGFloat = 46
    private let captionMaxLines = 3

    //UI COMPONENTS
    private let userImageArea = UIView()
    private let userImageView = UIImageView()

    private let userNameView = UIView()
    private let userNameLabel = UILabel()

    private let postTimeView = UIView()
    private let postTimeLabel = UILabel()

    private let postCaptionView = UIView()
    private let postCaptionLabel = UILabel()

    private var captionBottomToFromConstraint: NSLayoutConstraint?
    private var metaBottomToFromConstraint: NSLayoutConstraint?

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
        backgroundColor = Colors.screenBackground
        setupUserImageArea()
        setupUserNameView()
        setupPostTimeView()
        setupPostCaptionView()
        activateLayout()
    }

    //LAYOUT and UI
    private func setupUserImageArea() {
        userImageArea.backgroundColor = Colors.screenBackground
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

    private func setupPostCaptionView() {
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionView.backgroundColor = .clear

        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.font = Fonts.postCaptionFont
        postCaptionLabel.textColor = Colors.postCaptionFontColor
        postCaptionLabel.numberOfLines = captionMaxLines
        postCaptionLabel.lineBreakMode = .byTruncatingTail
        postCaptionLabel.setContentHuggingPriority(.required, for: .vertical)
        postCaptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionLabel)
    }

    private func activateLayout() {
        let metaBottom = userNameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        let captionBottom = postCaptionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        metaBottomToFromConstraint = metaBottom
        captionBottomToFromConstraint = captionBottom

        NSLayoutConstraint.activate([
            // User image — top-aligned (does not stretch when caption grows)
            userImageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageArea.topAnchor.constraint(equalTo: topAnchor),
            userImageArea.widthAnchor.constraint(equalToConstant: userImageAreaWidth),

            userImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: Layout.spacingS),
            userImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: Layout.spacingXS),
            userImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -Layout.spacingXS),
            userImageView.widthAnchor.constraint(equalToConstant: userImageDiameter),
            userImageView.heightAnchor.constraint(equalToConstant: userImageDiameter),
            userImageArea.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: Layout.spacingS),

            // Username + time on one row (+2pt from user image)
            userNameView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingS),
            userNameView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: 2),
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
            postTimeLabel.trailingAnchor.constraint(equalTo: postTimeView.trailingAnchor),

            // Caption under name row (+2pt from user image, flush below name)
            postCaptionView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            postCaptionView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: 2),
            postCaptionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingXS),

            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionView.topAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: postCaptionView.leadingAnchor),
            postCaptionLabel.trailingAnchor.constraint(equalTo: postCaptionView.trailingAnchor),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor),

            captionBottom
        ])
        metaBottom.isActive = false
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postTimeLabel.text = post.timeMessage ?? "now"

        let caption = (post.postCaption ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        updateCaptionVisibility(caption: caption)

        guard let username = post.postFrom, !username.isEmpty else {
            userNameLabel.text = nil
            return
        }

        userNameLabel.text = username
        loadUserProfile(username: username)
    }

    private func updateCaptionVisibility(caption: String) {
        let hasCaption = !caption.isEmpty
        postCaptionLabel.text = hasCaption ? caption : nil
        postCaptionView.isHidden = !hasCaption

        captionBottomToFromConstraint?.isActive = hasCaption
        metaBottomToFromConstraint?.isActive = !hasCaption
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
