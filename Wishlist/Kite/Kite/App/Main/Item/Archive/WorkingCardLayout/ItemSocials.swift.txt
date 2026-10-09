//
//  ItemSocials.swift
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

final class ItemSocials: UIView {

    //UI COMPONENTS
    private let likeImageView = UIImageView()
    private let likeCountLabel = UILabel()
    private let commentImageView = UIImageView()
    private let commentCountLabel = UILabel()
    private let bookmarkImageView = UIImageView()

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
        likeImageView.image = UIImage(named: "like")
        likeImageView.accessibilityLabel = "Like"
        commentImageView.image = UIImage(named: "comment")
        commentImageView.accessibilityLabel = "Comment"
        bookmarkImageView.image = UIImage(named: "bookmark")
        bookmarkImageView.accessibilityLabel = "Bookmark"

        [likeImageView, commentImageView, bookmarkImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFit
            $0.isAccessibilityElement = true
            addSubview($0)
        }

        [likeCountLabel, commentCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = Fonts.regular14
            $0.textColor = Colors.primaryGrayText
            $0.numberOfLines = 1
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Layout.touchTargetSize),

            likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            likeImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: Layout.spacingXS),
            likeCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            commentImageView.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: Layout.spacingL),
            commentImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            commentImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            commentCountLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: Layout.spacingXS),
            commentCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            commentCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: bookmarkImageView.leadingAnchor, constant: -Layout.spacingM),

            bookmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let liked = post.isLikedByCurrentUser ?? false
        likeImageView.image = UIImage(named: liked ? "Liked" : "like")
        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"
        commentCountLabel.text = "\(post.commentsArray?.count ?? 0)"
    }
}
