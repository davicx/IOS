//
//  ItemSocials.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemSocials: UIView {

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
    private var midnight = false

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
        likeCountLabel.font = Fonts.socialCountFont
        likeCountLabel.textColor = Colors.primaryText
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

    func applyMidnight(_ on: Bool) {
        midnight = on
        backgroundColor = on ? MidnightColors.cardBackground : Colors.screenBackground
        likeCountLabel.textColor = on ? MidnightColors.primaryText : Colors.primaryText
        let line = on ? MidnightColors.divider : UIColor(hex: "#B0B4BC")
        actionsDivider.backgroundColor = line
        socialDivider.backgroundColor = line
        if on {
            commentImageView.image = UIImage(named: "comment")?.withRenderingMode(.alwaysTemplate)
            commentImageView.tintColor = MidnightColors.icon
            bookmarkImageView.image = UIImage(named: "bookmark")?.withRenderingMode(.alwaysTemplate)
            bookmarkImageView.tintColor = MidnightColors.icon
        } else {
            commentImageView.image = UIImage(named: "comment")
            commentImageView.tintColor = nil
            bookmarkImageView.image = UIImage(named: "bookmark")
            bookmarkImageView.tintColor = nil
        }
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
    func configure(with post: Post) {
        self.post = post
        let liked = post.isLikedByCurrentUser ?? false
        if liked {
            let symbol = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
            likeImageView.image = UIImage(systemName: "heart.fill", withConfiguration: symbol)
            likeImageView.tintColor = midnight ? MidnightColors.primaryAction : UIColor(hex: "#F9595F")
        } else {
            likeImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = midnight ? MidnightColors.icon : .black
        }

        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"
    }
}
