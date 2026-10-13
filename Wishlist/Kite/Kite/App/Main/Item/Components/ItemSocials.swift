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
    private let commentWell = UIView()
    private let bookmarkWell = UIView()
    private let likeCountLabel = UILabel()

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
        likeImageView.image = UIImage(named: "like")
        likeImageView.accessibilityLabel = "Like"
        commentImageView.image = UIImage(named: "comment")
        commentImageView.accessibilityLabel = "Comment"
        bookmarkImageView.image = UIImage(named: "bookmark")
        bookmarkImageView.accessibilityLabel = "Bookmark"

        likeWell.addSubview(likeImageView)
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

        NSLayoutConstraint.activate([
            likeWell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingS),
            likeWell.topAnchor.constraint(equalTo: topAnchor),
            likeWell.widthAnchor.constraint(equalToConstant: 44),
            likeWell.heightAnchor.constraint(equalToConstant: 44),

            likeImageView.centerXAnchor.constraint(equalTo: likeWell.centerXAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            likeImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: Layout.spacingXS),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeImageView.centerYAnchor),

            commentWell.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: Layout.spacingS),
            commentWell.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            commentWell.widthAnchor.constraint(equalToConstant: 44),
            commentWell.heightAnchor.constraint(equalToConstant: 44),

            commentImageView.centerXAnchor.constraint(equalTo: commentWell.centerXAnchor),
            commentImageView.centerYAnchor.constraint(equalTo: commentWell.centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            commentImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            bookmarkWell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingS),
            bookmarkWell.centerYAnchor.constraint(equalTo: likeWell.centerYAnchor),
            bookmarkWell.widthAnchor.constraint(equalToConstant: 44),
            bookmarkWell.heightAnchor.constraint(equalToConstant: 44),

            bookmarkImageView.centerXAnchor.constraint(equalTo: bookmarkWell.centerXAnchor),
            bookmarkImageView.centerYAnchor.constraint(equalTo: bookmarkWell.centerYAnchor),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            likeWell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let liked = post.isLikedByCurrentUser ?? false
        likeImageView.image = UIImage(named: liked ? "Liked" : "like")

        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"
    }
}
