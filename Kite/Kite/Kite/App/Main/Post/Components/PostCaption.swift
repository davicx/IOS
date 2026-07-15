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


// PostCaption is a UI renderer. It displays post caption info. It does NOT decide when or how the table refreshes.
// The ViewController reacts to data changes via NotificationCenter.


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
    let userNameLabel = UILabel()
    let postedAtLabel = UILabel()
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
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 38)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(userImageArea)
        userImageArea.translatesAutoresizingMaskIntoConstraints = false
        userImageArea.addSubview(userProfileImageView)

        NSLayoutConstraint.activate([
            userImageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageArea.topAnchor.constraint(equalTo: topAnchor),
            userImageArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            userImageArea.widthAnchor.constraint(equalToConstant: 46),

            userProfileImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: 6),
            userProfileImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: 4),
            userProfileImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -4),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 38),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    //RIGHT: Comment Header — [username] [time ago] on one row, left aligned (Instagram-style)
    private func setupCommentHeaderView() {
        commentHeaderView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.80, alpha: 1.0)

        userNameLabel.font = Fonts.postUsernameFont
        userNameLabel.textColor = Colors.primaryText
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail

        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.postedAtTextColor
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail

        userNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        userNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        postedAtLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        postedAtLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addSubview(commentHeaderView)
        commentHeaderView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        postedAtLabel.translatesAutoresizingMaskIntoConstraints = false

        commentHeaderView.addSubview(userNameLabel)
        commentHeaderView.addSubview(postedAtLabel)

        NSLayoutConstraint.activate([
            commentHeaderView.topAnchor.constraint(equalTo: topAnchor),
            commentHeaderView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentHeaderView.heightAnchor.constraint(equalToConstant: 22),

            userNameLabel.leadingAnchor.constraint(equalTo: commentHeaderView.leadingAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),

            postedAtLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 4),
            postedAtLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor, constant: 1),
            postedAtLabel.trailingAnchor.constraint(lessThanOrEqualTo: commentHeaderView.trailingAnchor)
        ])
    }

    //RIGHT: Comment Body — height hugs post caption (dynamic, no min height)
    private func setupCommentBodyView() {
        commentBodyView.backgroundColor = UIColor(red: 0.86, green: 0.82, blue: 0.96, alpha: 1.0)

        commentBodyLabel.font = Fonts.postCaptionFont
        commentBodyLabel.textColor = Colors.postCaptionFontColor
        commentBodyLabel.numberOfLines = 0
        commentBodyLabel.text = "body"

        commentBodyLabel.setContentHuggingPriority(.required, for: .vertical)
        commentBodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        addSubview(commentBodyView)
        commentBodyView.translatesAutoresizingMaskIntoConstraints = false
        commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        commentBodyView.addSubview(commentBodyLabel)

        NSLayoutConstraint.activate([
            commentBodyView.topAnchor.constraint(equalTo: commentHeaderView.bottomAnchor),
            commentBodyView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),

            commentBodyLabel.topAnchor.constraint(equalTo: commentBodyView.topAnchor),
            commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyView.leadingAnchor),
            commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyView.trailingAnchor),
            commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyView.bottomAnchor)
        ])
    }

    //RIGHT: Comment Footer
    private func setupCommentFooterView() {
        commentFooterView.backgroundColor = UIColor.systemGray5

        addSubview(commentFooterView)
        commentFooterView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            commentFooterView.topAnchor.constraint(equalTo: commentBodyView.bottomAnchor),
            commentFooterView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentFooterView.heightAnchor.constraint(equalToConstant: 2),
            commentFooterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let postID = post.postID
        let postCaption = post.postCaption ?? "no caption"

        print("PostCaption: postID=\(postID) caption=\(postCaption)")

        commentBodyLabel.text = postCaption
        postedAtLabel.text = post.timeMessage ?? "now"

        guard let username = post.postFrom, !username.isEmpty else {
            userNameLabel.text = nil
            print("PostCaption: missing postFrom for postID \(postID)")
            return
        }

        userNameLabel.text = username
        print("PostCaption: userName=\(username)")
        loadUserProfile(username: username)
    }

    private func loadUserProfile(username: String) {
        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                print("PostCaption: failed to load user \(username)")
                return
            }

            guard loadUserName == username else { return }

            print("PostCaption: userName=\(user.userName) userImage=\(user.userImage)")

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
