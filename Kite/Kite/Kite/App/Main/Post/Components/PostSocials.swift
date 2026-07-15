//
//  PostSocials.swift
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

final class PostSocials: UIView {
    
    
    //LOGIC
    private let postDataController = PostDataController.shared
    private let spinnerHelper = SpinnerHelper()
    private var postID: Int?

    //UI COMPONENTS
    let postLikesView = UIView()
    let postCommentView = UIView()
    let postSharesView = UIView()

    private let likesIconView = UIImageView()
    private let likesIconBackground = UIView()
    private let likesCountLabel = UILabel()
    private let commentIconView = UIImageView()
    private let commentIconBackground = UIView()
    private let commentCountLabel = UILabel()
    private let sharesIconView = UIImageView()
    private let sharesIconBackground = UIView()
    private let sharesCountLabel = UILabel()

    private let stackView = UIStackView()
    private let countMaxWidth: CGFloat = 60
    private let iconSize: CGFloat = 24
    private let iconBackgroundSize: CGFloat = 28

    //MANAGE VIEWS
    override init(frame: CGRect) {
        print("POST SOCIALS")
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated(_:)),
            name: .postUpdated,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated(_:)),
            name: .commentUpdated,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //LAYOUT and UI
    private func setupViews() {
        // backgroundColor = UIColor.systemPurple.withAlphaComponent(0.3)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])

        // postLikesView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
        // postCommentView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.4)
        // postSharesView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.4)

        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        setupPostLikeViews()
        setupPostCommentViews()
        // setupPostSharesViews()

        stackView.addArrangedSubview(postLikesView)
        stackView.addArrangedSubview(postCommentView)
        // stackView.addArrangedSubview(postSharesView)
    }

    private func setupPostLikeViews() {
        postLikesView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLikeTapped))
        postLikesView.addGestureRecognizer(tap)

        likesIconBackground.backgroundColor = UIColor.tertiarySystemFill
        likesIconBackground.layer.cornerRadius = iconBackgroundSize / 2
        likesIconBackground.clipsToBounds = true

        likesIconView.image = UIImage(named: "liked") ?? UIImage(systemName: "heart") 
        likesIconView.contentMode = .scaleAspectFit
        likesIconView.tintColor = .label

        StyleOld.styleSocialCountText(likesCountLabel)
        likesCountLabel.text = "1,815"
        likesCountLabel.lineBreakMode = .byTruncatingTail

        [postLikesView, likesIconBackground, likesIconView, likesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        postLikesView.addSubview(likesIconBackground)
        likesIconBackground.addSubview(likesIconView)
        postLikesView.addSubview(likesCountLabel)

        NSLayoutConstraint.activate([
            postLikesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            likesIconBackground.leadingAnchor.constraint(equalTo: postLikesView.leadingAnchor),
            likesIconBackground.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
            likesIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
            likesIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
            likesIconView.centerXAnchor.constraint(equalTo: likesIconBackground.centerXAnchor),
            likesIconView.centerYAnchor.constraint(equalTo: likesIconBackground.centerYAnchor),
            likesIconView.widthAnchor.constraint(equalToConstant: iconSize),
            likesIconView.heightAnchor.constraint(equalToConstant: iconSize),
            likesCountLabel.leadingAnchor.constraint(equalTo: likesIconBackground.trailingAnchor, constant: 4),
            likesCountLabel.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
            likesCountLabel.trailingAnchor.constraint(equalTo: postLikesView.trailingAnchor),
            likesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
        ])
    }

    private func setupPostCommentViews() {
        commentIconBackground.backgroundColor = UIColor.tertiarySystemFill
        commentIconBackground.layer.cornerRadius = iconBackgroundSize / 2
        commentIconBackground.clipsToBounds = true

        commentIconView.image = UIImage(named: "comment") ?? UIImage(systemName: "text.bubble")
        commentIconView.contentMode = .scaleAspectFit
        commentIconView.tintColor = .label

        StyleOld.styleSocialCountText(commentCountLabel)
        commentCountLabel.text = "15"
        commentCountLabel.lineBreakMode = .byTruncatingTail

        [postCommentView, commentIconBackground, commentIconView, commentCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        postCommentView.addSubview(commentIconBackground)
        commentIconBackground.addSubview(commentIconView)
        postCommentView.addSubview(commentCountLabel)

        NSLayoutConstraint.activate([
            postCommentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            commentIconBackground.leadingAnchor.constraint(equalTo: postCommentView.leadingAnchor),
            commentIconBackground.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
            commentIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
            commentIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
            commentIconView.centerXAnchor.constraint(equalTo: commentIconBackground.centerXAnchor),
            commentIconView.centerYAnchor.constraint(equalTo: commentIconBackground.centerYAnchor),
            commentIconView.widthAnchor.constraint(equalToConstant: iconSize),
            commentIconView.heightAnchor.constraint(equalToConstant: iconSize),
            commentCountLabel.leadingAnchor.constraint(equalTo: commentIconBackground.trailingAnchor, constant: 4),
            commentCountLabel.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
            commentCountLabel.trailingAnchor.constraint(equalTo: postCommentView.trailingAnchor),
            commentCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
        ])
    }
    
    //ACTIONS
    @objc private func handleLikeTapped() {
        guard let postID,
              let post = postDataController.getPostByID(postID: postID) else { return }
        let groupID = post.groupID ?? 0

        postLikesView.isUserInteractionEnabled = false
        spinnerHelper.show(in: SpinnerHelper.keyWindow ?? self, delay: 0)

        Task {
            await PostLogic.shared.toggleLike(post: post, groupID: groupID)
            await MainActor.run {
                spinnerHelper.hide()
                postLikesView.isUserInteractionEnabled = true
            }
        }
    }

    @objc private func handlePostUpdated(_ notification: Notification) {
        guard let updatedPostID = notification.object as? Int,
              updatedPostID == postID else { return }
        refreshLikes()
    }

    
    
    //FUNCTIONS
    //Configure with post so like area (icon + count) and later like action use live data.
    func configure(postID: Int) {
        self.postID = postID
        refreshLikes()
    }
    
    //Updates the like area and comment count from PostDataController.
    private func refreshLikes() {
        guard let postID else {
            print("PostSocials: postID is nil, skipping refresh")
            return
        }
        guard let post = postDataController.getPostByID(postID: postID) else {
            print("PostSocials: post not found in PostDataController for postID \(postID)")
            return
        }
        let likeCount = post.simpleLikesArray?.count ?? 0
        let isLiked = post.isLikedByCurrentUser ?? false
        let commentCount = post.commentsArray?.count ?? 0

        likesIconView.image = isLiked
            ? (UIImage(named: "liked") ?? UIImage(systemName: "heart.fill"))
            : (UIImage(named: "like") ?? UIImage(systemName: "heart"))
        likesCountLabel.text = "\(likeCount)"
        commentCountLabel.text = "\(commentCount)"

        print("PostSocials: comment count = \(commentCount)")
    }


}


/*
 // Saved background colors (commented out in setupViews / setup*):
 // self: systemPurple 0.3 | postLikesView: systemTeal 0.4 | postCommentView: systemOrange 0.4 | postSharesView: systemIndigo 0.4
 // icon views: systemRed 0.5 | count labels: systemGreen 0.5

 
 group_messages
 group_message_id
 message
 message_status sent, delivered, failed
 created- time
 recieved- time

 group_users
 message_app
 message_phone
 message_email

 user_profile
 email
 phone

 */


/*
private func setupPostSharesViews() {
    sharesIconBackground.backgroundColor = UIColor.tertiarySystemFill
    sharesIconBackground.layer.cornerRadius = iconBackgroundSize / 2
    sharesIconBackground.clipsToBounds = true

    sharesIconView.image = UIImage(named: "messenger") ?? UIImage(systemName: "message")
    sharesIconView.contentMode = .scaleAspectFit
    sharesIconView.tintColor = .label

    Style.styleSocialCountText(sharesCountLabel)
    sharesCountLabel.text = "5"
    sharesCountLabel.lineBreakMode = .byTruncatingTail

    [postSharesView, sharesIconBackground, sharesIconView, sharesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    postSharesView.addSubview(sharesIconBackground)
    sharesIconBackground.addSubview(sharesIconView)
    postSharesView.addSubview(sharesCountLabel)

    NSLayoutConstraint.activate([
        postSharesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
        sharesIconBackground.leadingAnchor.constraint(equalTo: postSharesView.leadingAnchor),
        sharesIconBackground.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
        sharesIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
        sharesIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
        sharesIconView.centerXAnchor.constraint(equalTo: sharesIconBackground.centerXAnchor),
        sharesIconView.centerYAnchor.constraint(equalTo: sharesIconBackground.centerYAnchor),
        sharesIconView.widthAnchor.constraint(equalToConstant: iconSize),
        sharesIconView.heightAnchor.constraint(equalToConstant: iconSize),
        sharesCountLabel.leadingAnchor.constraint(equalTo: sharesIconBackground.trailingAnchor, constant: 4),
        sharesCountLabel.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
        sharesCountLabel.trailingAnchor.constraint(equalTo: postSharesView.trailingAnchor),
        sharesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
    ])
}
*/
