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

    //UI COMPONENTS
    private let socialIconsLeft = UIView()
    private let socialIconsMiddle = UIView()
    private let socialIconsRight = UIView()
    private let likeImageView = UIImageView()
    private let commentImageView = UIImageView()
    private let bookmarkImageView = UIImageView()
    private let likeButton = UIButton(type: .custom)
    private let likeCountLabel = UILabel()
    private let commentCountLabel = UILabel()
    private let dotsStack = UIStackView()
    private var post: Post?
    private let iconSide: CGFloat = Layout.iconSize + 2

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        // socialIconsLeft.backgroundColor = UIColor.systemPink.withAlphaComponent(0.35)
        // socialIconsMiddle.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.35)
        // socialIconsRight.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.35)

        [socialIconsLeft, socialIconsMiddle, socialIconsRight].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        likeImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        likeImageView.tintColor = .black
        likeImageView.contentMode = .scaleAspectFit
        likeImageView.isUserInteractionEnabled = false
        commentImageView.image = UIImage(named: "Comment")
        commentImageView.contentMode = .scaleAspectFit
        commentImageView.accessibilityLabel = "Comment"
        bookmarkImageView.image = UIImage(named: "bookmark")
        bookmarkImageView.contentMode = .scaleAspectFit

        likeCountLabel.font = Fonts.semibold14
        likeCountLabel.textColor = UIColor(hex: "#171717")
        likeCountLabel.text = "0"

        commentCountLabel.font = Fonts.semibold14
        commentCountLabel.textColor = UIColor(hex: "#171717")
        commentCountLabel.text = "0"

        likeButton.backgroundColor = .clear
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        [likeImageView, likeCountLabel, commentImageView, commentCountLabel, likeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            socialIconsLeft.addSubview($0)
        }
        socialIconsLeft.bringSubviewToFront(likeButton)

        dotsStack.axis = .horizontal
        dotsStack.spacing = DesignStyleTemp.dotSpacing
        dotsStack.alignment = .center
        dotsStack.translatesAutoresizingMaskIntoConstraints = false
        socialIconsMiddle.addSubview(dotsStack)
        rebuildDots()

        bookmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        socialIconsRight.addSubview(bookmarkImageView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),

            socialIconsLeft.leadingAnchor.constraint(equalTo: leadingAnchor),
            socialIconsLeft.topAnchor.constraint(equalTo: topAnchor),
            socialIconsLeft.bottomAnchor.constraint(equalTo: bottomAnchor),

            socialIconsMiddle.leadingAnchor.constraint(equalTo: socialIconsLeft.trailingAnchor),
            socialIconsMiddle.topAnchor.constraint(equalTo: topAnchor),
            socialIconsMiddle.bottomAnchor.constraint(equalTo: bottomAnchor),
            socialIconsMiddle.trailingAnchor.constraint(equalTo: socialIconsRight.leadingAnchor),

            socialIconsRight.trailingAnchor.constraint(equalTo: trailingAnchor),
            socialIconsRight.topAnchor.constraint(equalTo: topAnchor),
            socialIconsRight.bottomAnchor.constraint(equalTo: bottomAnchor),
            socialIconsRight.widthAnchor.constraint(equalToConstant: 140),

            likeImageView.leadingAnchor.constraint(equalTo: socialIconsLeft.leadingAnchor, constant: 14),
            likeImageView.centerYAnchor.constraint(equalTo: socialIconsLeft.centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: iconSide),
            likeImageView.heightAnchor.constraint(equalToConstant: iconSide),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: Layout.spacingXS),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),

            commentImageView.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: Layout.spacingS),
            commentImageView.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: iconSide),
            commentImageView.heightAnchor.constraint(equalToConstant: iconSide),

            commentCountLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: Layout.spacingXS),
            commentCountLabel.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor),
            commentCountLabel.trailingAnchor.constraint(equalTo: socialIconsLeft.trailingAnchor, constant: -Layout.spacingS),

            likeButton.topAnchor.constraint(equalTo: likeImageView.topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: likeImageView.leadingAnchor),
            likeButton.trailingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: likeImageView.bottomAnchor),

            dotsStack.centerXAnchor.constraint(equalTo: socialIconsMiddle.centerXAnchor),
            dotsStack.centerYAnchor.constraint(equalTo: socialIconsMiddle.centerYAnchor),

            bookmarkImageView.trailingAnchor.constraint(equalTo: socialIconsRight.trailingAnchor, constant: -14),
            bookmarkImageView.centerYAnchor.constraint(equalTo: socialIconsRight.centerYAnchor),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: iconSide),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: iconSide)
        ])
    }

    //ACTIONS
    @objc private func likeTapped() {
        guard let post else { return }
        likeButton.isUserInteractionEnabled = false
        let groupID = post.groupID ?? 0
        Task {
            await PostLogic.shared.toggleLike(post: post, groupID: groupID)
            await MainActor.run {
                self.likeButton.isUserInteractionEnabled = true
            }
        }
    }

    //FUNCTIONS
    func configure(postID: Int) {
        guard let post = PostDataController.shared.getPostByID(postID: postID) else { return }
        configure(with: post)
    }

    func configure(with post: Post) {
        self.post = post
        let liked = post.isLikedByCurrentUser ?? false
        if liked {
            let symbol = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
            likeImageView.image = UIImage(systemName: "heart.fill", withConfiguration: symbol)
            likeImageView.tintColor = UIColor(hex: "#F9595F")
        } else {
            likeImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = .black
        }
        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"

        let commentCount = post.commentsArray?.count ?? 0
        commentCountLabel.text = "\(commentCount)"
        if commentCount > 1 {
            let symbol = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
            commentImageView.image = UIImage(systemName: "bubble.fill", withConfiguration: symbol)
            commentImageView.tintColor = UIColor(hex: "#E0A100")
        } else {
            commentImageView.image = UIImage(named: "Comment")
            commentImageView.tintColor = .black
        }
    }

    private func rebuildDots() {
        let pageCount = 4
        let page = 0
        let visible = min(pageCount, DesignStyleTemp.maxDots)
        for index in 0..<visible {
            let dot = UIView()
            dot.backgroundColor = index == page ? DesignStyleTemp.activePage : DesignStyleTemp.inactivePage
            dot.layer.cornerRadius = DesignStyleTemp.dotSize / 2
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
            dot.heightAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
            dotsStack.addArrangedSubview(dot)
        }
    }
}

/*
final class PostSocials: UIView {

    //UI COMPONENTS
    private let likeImageView = UIImageView()
    private let commentImageView = UIImageView()
    private let bookmarkImageView = UIImageView()
    private let likeWell = UIView()
    private let likeButton = UIButton(type: .custom)
    private let commentWell = UIView()
    private let bookmarkWell = UIView()
    private let likeCountLabel = UILabel()
    private var post: Post?
    private let actionsDivider = UIView()
    private let socialDivider = UIView()
    private let iconSide: CGFloat = Layout.iconSize + 2

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        likeImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        likeImageView.tintColor = .black
        likeImageView.isUserInteractionEnabled = false
        likeImageView.accessibilityLabel = "Like"
        commentImageView.image = UIImage(named: "comment")
        commentImageView.accessibilityLabel = "Comment"
        bookmarkImageView.image = UIImage(named: "bookmark")
        bookmarkImageView.accessibilityLabel = "Bookmark"

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.backgroundColor = .clear
        likeButton.accessibilityLabel = "Like"
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        likeWell.addSubview(likeImageView)
        likeWell.addSubview(likeButton)
        likeWell.bringSubviewToFront(likeButton)
        commentWell.addSubview(commentImageView)
        bookmarkWell.addSubview(bookmarkImageView)
        [likeWell, commentWell, bookmarkWell].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        [likeImageView, commentImageView, bookmarkImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFit
            $0.isAccessibilityElement = true
        }

        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        likeCountLabel.textColor = UIColor(hex: "#171717")
        likeCountLabel.numberOfLines = 1
        addSubview(likeCountLabel)

        actionsDivider.translatesAutoresizingMaskIntoConstraints = false
        actionsDivider.backgroundColor = UIColor(hex: "#B0B4BC")
        addSubview(actionsDivider)

        socialDivider.translatesAutoresizingMaskIntoConstraints = false
        socialDivider.backgroundColor = UIColor(hex: "#B0B4BC")
        addSubview(socialDivider)

        NSLayoutConstraint.activate([
            likeWell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingS),
            likeWell.topAnchor.constraint(equalTo: topAnchor),
            likeWell.widthAnchor.constraint(equalToConstant: 52),
            likeWell.heightAnchor.constraint(equalToConstant: 52),
            likeWell.bottomAnchor.constraint(equalTo: socialDivider.topAnchor),

            likeImageView.centerXAnchor.constraint(equalTo: likeWell.centerXAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: iconSide),
            likeImageView.heightAnchor.constraint(equalToConstant: iconSide),

            likeButton.topAnchor.constraint(equalTo: likeWell.topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: likeWell.leadingAnchor),
            likeButton.trailingAnchor.constraint(equalTo: likeWell.trailingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: likeWell.bottomAnchor),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: Layout.spacingXS),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),

            actionsDivider.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: Layout.spacingL),
            actionsDivider.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            actionsDivider.widthAnchor.constraint(equalToConstant: 0.5),
            actionsDivider.heightAnchor.constraint(equalToConstant: 22),

            commentWell.leadingAnchor.constraint(equalTo: actionsDivider.trailingAnchor, constant: Layout.spacingL),
            commentWell.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            commentWell.widthAnchor.constraint(equalToConstant: 44),
            commentWell.heightAnchor.constraint(equalToConstant: 44),

            commentImageView.centerXAnchor.constraint(equalTo: commentWell.centerXAnchor),
            commentImageView.centerYAnchor.constraint(equalTo: commentWell.centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: iconSide),
            commentImageView.heightAnchor.constraint(equalToConstant: iconSide),

            bookmarkWell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingS),
            bookmarkWell.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            bookmarkWell.widthAnchor.constraint(equalToConstant: 44),
            bookmarkWell.heightAnchor.constraint(equalToConstant: 44),

            bookmarkImageView.centerXAnchor.constraint(equalTo: bookmarkWell.centerXAnchor),
            bookmarkImageView.centerYAnchor.constraint(equalTo: bookmarkWell.centerYAnchor),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: iconSide),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: iconSide),

            socialDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            socialDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            socialDivider.bottomAnchor.constraint(equalTo: bottomAnchor),
            socialDivider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    //ACTIONS
    @objc private func likeTapped() {
        guard let post else { return }
        likeButton.isUserInteractionEnabled = false
        let groupID = post.groupID ?? 0
        Task {
            await PostLogic.shared.toggleLike(post: post, groupID: groupID)
            await MainActor.run {
                self.likeButton.isUserInteractionEnabled = true
            }
        }
    }

    //FUNCTIONS
    func configure(postID: Int) {
        guard let post = PostDataController.shared.getPostByID(postID: postID) else { return }
        configure(with: post)
    }

    func configure(with post: Post) {
        self.post = post
        let liked = post.isLikedByCurrentUser ?? false
        if liked {
            let symbol = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
            likeImageView.image = UIImage(systemName: "heart.fill", withConfiguration: symbol)
            likeImageView.tintColor = UIColor(hex: "#F9595F")
        } else {
            likeImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = .black
        }

        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"
    }
}

*/

/*
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
    private let bookmarkIconView = UIImageView()
    private let bookmarkIconBackground = UIView()
    private let bookmarkCountLabel = UILabel()

    private let stackView = UIStackView()
    private let countMaxWidth: CGFloat = 60
    private let iconSize: CGFloat = 24
    private let iconBackgroundSize: CGFloat = 28

    //MANAGE VIEWS
    override init(frame: CGRect) {
        //print("POST SOCIALS")
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
        setupPostBookmarkViews()

        stackView.addArrangedSubview(postLikesView)
        stackView.addArrangedSubview(postCommentView)
        stackView.addArrangedSubview(postSharesView)
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

    private func setupPostBookmarkViews() {
        bookmarkIconBackground.backgroundColor = UIColor.tertiarySystemFill
        bookmarkIconBackground.layer.cornerRadius = iconBackgroundSize / 2
        bookmarkIconBackground.clipsToBounds = true

        bookmarkIconView.image = UIImage(named: "bookmark") ?? UIImage(systemName: "bookmark")
        bookmarkIconView.contentMode = .scaleAspectFit
        bookmarkIconView.tintColor = .label

        StyleOld.styleSocialCountText(bookmarkCountLabel)
        bookmarkCountLabel.text = "4"
        bookmarkCountLabel.lineBreakMode = .byTruncatingTail

        [postSharesView, bookmarkIconBackground, bookmarkIconView, bookmarkCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        postSharesView.addSubview(bookmarkIconBackground)
        bookmarkIconBackground.addSubview(bookmarkIconView)
        postSharesView.addSubview(bookmarkCountLabel)

        NSLayoutConstraint.activate([
            postSharesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            bookmarkIconBackground.leadingAnchor.constraint(equalTo: postSharesView.leadingAnchor),
            bookmarkIconBackground.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
            bookmarkIconBackground.widthAnchor.constraint(equalToConstant: iconBackgroundSize),
            bookmarkIconBackground.heightAnchor.constraint(equalToConstant: iconBackgroundSize),
            bookmarkIconView.centerXAnchor.constraint(equalTo: bookmarkIconBackground.centerXAnchor),
            bookmarkIconView.centerYAnchor.constraint(equalTo: bookmarkIconBackground.centerYAnchor),
            bookmarkIconView.widthAnchor.constraint(equalToConstant: iconSize),
            bookmarkIconView.heightAnchor.constraint(equalToConstant: iconSize),
            bookmarkCountLabel.leadingAnchor.constraint(equalTo: bookmarkIconBackground.trailingAnchor, constant: 4),
            bookmarkCountLabel.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
            bookmarkCountLabel.trailingAnchor.constraint(equalTo: postSharesView.trailingAnchor),
            bookmarkCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth)
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

        //print("PostSocials: comment count = \(commentCount)")
    }


}

*/

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
