//
//  CommentCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class CommentCell: UITableViewCell {

    //LOGIC
    // Step 3 = owner-only Delete menu.
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var postDataController: PostDataController { PostDataController.shared }
    private var loadUserName: String?
    private var commentID: Int?
    private var postID: Int?

    //UI COMPONENTS
    //Left: User Image
    private let userImageArea = UIView()
    private let userProfileImageView = UIImageView()

    //Right Column
    private let commentHeaderView = UIView()
    private let userNameLabel = UILabel()
    private let postedAtLabel = UILabel()
    private let menuButton = UIButton(type: .system)

    private let commentBodyView = UIView()
    private let commentBodyLabel = UILabel()

    private let commentFooterView = UIView()
    private let likeImageView = UIImageView()
    private let likeCountLabel = UILabel()

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        separatorInset = .zero
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = Colors.screenBackground
        contentView.backgroundColor = Colors.screenBackground

        setupCommentViews()
        setupDeleteMenu()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCommentViews() {
        setupUserImageArea()
        setupCommentHeaderView()
        setupCommentBodyView()
        setupCommentFooterView()
    }

    //LAYOUT and UI
    //LEFT: User Image Area — smaller avatar (matches PostCaption)
    private func setupUserImageArea() {
        userImageArea.backgroundColor = Colors.screenBackground
        userImageArea.translatesAutoresizingMaskIntoConstraints = false

        userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 38)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(userImageArea)
        userImageArea.addSubview(userProfileImageView)

        NSLayoutConstraint.activate([
            userImageArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImageArea.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImageArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userImageArea.widthAnchor.constraint(equalToConstant: 46),

            userProfileImageView.topAnchor.constraint(equalTo: userImageArea.topAnchor, constant: 8),
            userProfileImageView.leadingAnchor.constraint(equalTo: userImageArea.leadingAnchor, constant: 2),
            userProfileImageView.trailingAnchor.constraint(equalTo: userImageArea.trailingAnchor, constant: -6),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 38),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    //RIGHT: Comment Header — [username] [time] ........ [menu]
    private func setupCommentHeaderView() {
        commentHeaderView.backgroundColor = Colors.screenBackground
        commentHeaderView.translatesAutoresizingMaskIntoConstraints = false

        userNameLabel.font = Fonts.postUsernameFont
        userNameLabel.textColor = Colors.primaryGrayText
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail
        userNameLabel.text = "username"
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false

        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.postedAtTextColor
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail
        postedAtLabel.text = "now"
        postedAtLabel.translatesAutoresizingMaskIntoConstraints = false

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-dots-gray"), for: .normal)
        menuButton.tintColor = .systemGray
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.contentHorizontalAlignment = .fill
        menuButton.contentVerticalAlignment = .fill
        menuButton.isHidden = true

        userNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        userNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        postedAtLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        postedAtLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        menuButton.setContentHuggingPriority(.required, for: .horizontal)
        menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(commentHeaderView)
        commentHeaderView.addSubview(userNameLabel)
        commentHeaderView.addSubview(postedAtLabel)
        commentHeaderView.addSubview(menuButton)

        NSLayoutConstraint.activate([
            commentHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            commentHeaderView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            commentHeaderView.heightAnchor.constraint(equalToConstant: 28),

            userNameLabel.leadingAnchor.constraint(equalTo: commentHeaderView.leadingAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),

            postedAtLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 4),
            postedAtLabel.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor, constant: 1),
            postedAtLabel.trailingAnchor.constraint(lessThanOrEqualTo: menuButton.leadingAnchor, constant: -8),

            menuButton.trailingAnchor.constraint(equalTo: commentHeaderView.trailingAnchor),
            menuButton.centerYAnchor.constraint(equalTo: commentHeaderView.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 26),
            menuButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    //RIGHT: Comment Body — expanding caption
    private func setupCommentBodyView() {
        commentBodyView.backgroundColor = Colors.screenBackground
        commentBodyView.translatesAutoresizingMaskIntoConstraints = false

        commentBodyLabel.font = Fonts.postCaptionFont
        commentBodyLabel.textColor = Colors.postCaptionFontColor
        commentBodyLabel.numberOfLines = 0
        commentBodyLabel.text = "Comment body"
        commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false

        commentBodyLabel.setContentHuggingPriority(.required, for: .vertical)
        commentBodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        contentView.addSubview(commentBodyView)
        commentBodyView.addSubview(commentBodyLabel)

        NSLayoutConstraint.activate([
            commentBodyView.topAnchor.constraint(equalTo: commentHeaderView.bottomAnchor, constant: -4),
            commentBodyView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentBodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            commentBodyLabel.topAnchor.constraint(equalTo: commentBodyView.topAnchor),
            commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyView.leadingAnchor),
            commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyView.trailingAnchor),
            commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyView.bottomAnchor)
        ])
    }

    //RIGHT: Comment Footer — compact likes row (stub UI for Step 1)
    private func setupCommentFooterView() {
        commentFooterView.backgroundColor = Colors.screenBackground
        commentFooterView.translatesAutoresizingMaskIntoConstraints = false

        likeImageView.image = UIImage(named: "like")
        likeImageView.contentMode = .scaleAspectFit
        likeImageView.translatesAutoresizingMaskIntoConstraints = false

        likeCountLabel.font = Fonts.regular14
        likeCountLabel.textColor = Colors.postedAtTextColor
        likeCountLabel.text = "0"
        likeCountLabel.textAlignment = .center
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(commentFooterView)
        commentFooterView.addSubview(likeImageView)
        commentFooterView.addSubview(likeCountLabel)

        NSLayoutConstraint.activate([
            commentFooterView.topAnchor.constraint(equalTo: commentBodyView.bottomAnchor, constant: 4),
            commentFooterView.leadingAnchor.constraint(equalTo: userImageArea.trailingAnchor),
            commentFooterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            commentFooterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            commentFooterView.heightAnchor.constraint(equalToConstant: 24),

            likeImageView.leadingAnchor.constraint(equalTo: commentFooterView.leadingAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: commentFooterView.centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: 18),
            likeImageView.heightAnchor.constraint(equalToConstant: 18),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 6),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor)
        ])
    }

    //ACTIONS
    private func setupDeleteMenu() {
        let deleteAction = UIAction(
            title: "Delete",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.confirmDelete()
        }

        menuButton.menu = UIMenu(children: [deleteAction])
        menuButton.showsMenuAsPrimaryAction = true
    }

    private func confirmDelete() {
        guard let viewController = findViewController() else { return }

        let alert = UIAlertController(
            title: "Delete Comment?",
            message: "Are you sure you want to delete this comment? This cannot be undone.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteComment()
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewController.present(alert, animated: true)
        }
    }

    private func deleteComment() {
        guard let commentID, let postID else {
            print("Delete Comment: missing commentID or postID")
            return
        }

        Task {
            let success = await PostLogic.shared.deleteComment(postID: postID, commentID: commentID)
            await MainActor.run {
                if !success {
                    self.showDeleteFailedAlert()
                }
            }
        }
    }

    private func showDeleteFailedAlert() {
        guard let viewController = findViewController() else { return }
        let alert = UIAlertController(
            title: "Couldn’t delete comment",
            message: "Something went wrong. Please try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        loadUserName = nil
        commentID = nil
        postID = nil

        userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
        userNameLabel.text = "username"
        postedAtLabel.text = "now"
        commentBodyLabel.text = "Comment body"
        likeCountLabel.text = "0"
        likeImageView.image = UIImage(named: "like")
        menuButton.isHidden = true
    }

    //FUNCTIONS
    func configureCommentCell(with comment: Comment) {
        commentID = comment.commentID
        postID = comment.postID

        let username = comment.userName ?? comment.commentFrom
        userNameLabel.text = (username?.isEmpty == false) ? username : "username"
        postedAtLabel.text = comment.timeMessage ?? "now"

        if let caption = comment.commentCaption, !caption.isEmpty {
            commentBodyLabel.text = caption
        } else {
            commentBodyLabel.text = "Comment body"
        }

        let likeCount = comment.commentLikeCount ?? comment.commentLikes?.count ?? 0
        likeCountLabel.text = "\(likeCount)"
        likeImageView.image = (comment.commentLikedByCurrentUser == true)
            ? (UIImage(named: "liked") ?? UIImage(systemName: "heart.fill"))
            : (UIImage(named: "like") ?? UIImage(systemName: "heart"))

        let author = comment.commentFrom ?? comment.userName ?? ""
        let currentUser = postDataController.currentUser
        menuButton.isHidden = author.isEmpty
            || author.caseInsensitiveCompare(currentUser) != .orderedSame

        if let username, !username.isEmpty {
            loadUserProfile(username: username)
        } else {
            loadUserName = nil
            userProfileImageView.image = UIImage(named: "user") ?? UIImage(named: "background_1")
        }
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
                    self.userProfileImageView.image = image
                }
            }
        }
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let viewController = next as? UIViewController {
                return viewController
            }
            responder = next
        }
        return nil
    }
}
