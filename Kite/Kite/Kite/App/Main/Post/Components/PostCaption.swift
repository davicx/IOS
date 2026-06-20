//
//  PostCaption.swift
//  Kite
//
//  Created by David Vasquez on 2/22/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class PostCaption: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?

    //UI COMPONENTS
    //Left: User Image
    let userImageArea = UIView()
    let userProfileImageView = UIImageView()

    //Right Column
    let commentHeaderView = UIView()
    let commentBodyView = UIView()
    let commentFooterView = UIView()

    //Body: expanding comment text (placeholder for now)
    private let commentBodyLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupUserImageArea()
        setupCommentHeaderView()
        setupCommentBodyView()
        setupCommentFooterView()
    }

    //LEFT: User Image Area
    private func setupUserImageArea() {
        userImageArea.backgroundColor = Colors.screenBackground

        userProfileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 48)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(userImageArea)
        userImageArea.translatesAutoresizingMaskIntoConstraints = false
        userImageArea.addSubview(userProfileImageView)

        NSLayoutConstraint.activate([
            userImageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageArea.topAnchor.constraint(equalTo: topAnchor),
            userImageArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            userImageArea.widthAnchor.constraint(equalToConstant: 56),

            userProfileImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: 8),
            userProfileImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: 4),
            userProfileImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -4),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 48),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 48)
        ])

        loadCurrentUserProfile()
    }

    //RIGHT: Comment Header
    private func setupCommentHeaderView() {
        commentHeaderView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.80, alpha: 1.0)

        addSubview(commentHeaderView)
        commentHeaderView.translatesAutoresizingMaskIntoConstraints = false

        addTempLabel(
            "commentHeaderView\nComment Header\n40 tall · fill remaining width",
            to: commentHeaderView
        )

        NSLayoutConstraint.activate([
            commentHeaderView.topAnchor.constraint(equalTo: topAnchor),
            commentHeaderView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentHeaderView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }

    //RIGHT: Comment Body
    private func setupCommentBodyView() {
        commentBodyView.backgroundColor = UIColor(red: 0.86, green: 0.82, blue: 0.96, alpha: 1.0)

        commentBodyLabel.font = UIFont.systemFont(ofSize: 14)
        commentBodyLabel.textColor = Colors.primaryText
        commentBodyLabel.numberOfLines = 0
        commentBodyLabel.text = "commentBodyView — height expands with text. 60pt min height · fill remaining width."

        addSubview(commentBodyView)
        commentBodyView.translatesAutoresizingMaskIntoConstraints = false
        commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        commentBodyView.addSubview(commentBodyLabel)

        NSLayoutConstraint.activate([
            commentBodyView.topAnchor.constraint(equalTo: commentHeaderView.bottomAnchor),
            commentBodyView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentBodyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),

            commentBodyLabel.topAnchor.constraint(equalTo: commentBodyView.topAnchor, constant: 8),
            commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyView.leadingAnchor, constant: 8),
            commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyView.trailingAnchor, constant: -8),
            commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyView.bottomAnchor, constant: -8)
        ])
    }

    //RIGHT: Comment Footer
    private func setupCommentFooterView() {
        commentFooterView.backgroundColor = UIColor.systemGray5

        addSubview(commentFooterView)
        commentFooterView.translatesAutoresizingMaskIntoConstraints = false

        addTempLabel(
            "commentFooterView\n40 tall · fill remaining width",
            to: commentFooterView
        )

        NSLayoutConstraint.activate([
            commentFooterView.topAnchor.constraint(equalTo: commentBodyView.bottomAnchor),
            commentFooterView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentFooterView.heightAnchor.constraint(equalToConstant: 40),
            commentFooterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with comment: Comment) {
        if let caption = comment.commentCaption, !caption.isEmpty {
            commentBodyLabel.text = caption
        }
    }

    private func loadCurrentUserProfile() {
        let username = usersDataController.currentUser
        guard !username.isEmpty else {
            print("PostCaption: missing current user")
            return
        }

        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                print("PostCaption: failed to load user \(username)")
                return
            }

            guard loadUserName == username else { return }

            await MainActor.run {
                guard self.loadUserName == username else { return }
                if let image = user.profileImage {
                    self.userProfileImageView.image = image
                }
            }
        }
    }

    //TEMP
    private func addTempLabel(_ text: String, to view: UIView) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = Colors.primaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -4)
        ])
    }
}
