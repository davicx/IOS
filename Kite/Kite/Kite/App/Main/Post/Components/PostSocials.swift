//
//  PostSocials.swift
//  Kite
//
//  Created by David Vasquez on 2/22/26.
//

import UIKit

final class PostSocials: UIView {


    //UI COMPONENTS
    let postLikesView = UIView()
    let postCommentView = UIView()
    let postSharesView = UIView()

    private let likesIconView = UIImageView()
    private let likesCountLabel = UILabel()
    private let commentIconView = UIImageView()
    private let commentCountLabel = UILabel()
    private let sharesIconView = UIImageView()
    private let sharesCountLabel = UILabel()

    private let stackView = UIStackView()
    private let countMaxWidth: CGFloat = 60
    private let iconSize: CGFloat = 24

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        setupPostLikeViews()
        setupPostCommentViews()
        setupPostSharesViews()

        stackView.addArrangedSubview(postLikesView)
        stackView.addArrangedSubview(postCommentView)
        stackView.addArrangedSubview(postSharesView)
    }

    private func setupPostLikeViews() {
        likesIconView.image = UIImage(systemName: "heart")
        likesIconView.contentMode = .scaleAspectFit
        likesIconView.tintColor = .label
        // likesIconView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
        Style.styleSocialCountText(likesCountLabel)
        likesCountLabel.text = "1,815"
        likesCountLabel.lineBreakMode = .byTruncatingTail
        // likesCountLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)

        [postLikesView, likesIconView, likesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        postLikesView.addSubview(likesIconView)
        postLikesView.addSubview(likesCountLabel)

        NSLayoutConstraint.activate([
            postLikesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            likesIconView.leadingAnchor.constraint(equalTo: postLikesView.leadingAnchor),
            likesIconView.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
            likesIconView.widthAnchor.constraint(equalToConstant: iconSize),
            likesIconView.heightAnchor.constraint(equalToConstant: iconSize),
            likesCountLabel.leadingAnchor.constraint(equalTo: likesIconView.trailingAnchor, constant: 2),
            likesCountLabel.centerYAnchor.constraint(equalTo: postLikesView.centerYAnchor),
            likesCountLabel.trailingAnchor.constraint(equalTo: postLikesView.trailingAnchor),
            likesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth),
            likesIconView.topAnchor.constraint(greaterThanOrEqualTo: postLikesView.topAnchor),
            likesIconView.bottomAnchor.constraint(lessThanOrEqualTo: postLikesView.bottomAnchor)
        ])
    }

    private func setupPostCommentViews() {
        commentIconView.image = UIImage(named: "comment") ?? UIImage(systemName: "text.bubble")
        commentIconView.contentMode = .scaleAspectFit
        commentIconView.tintColor = .label
        // commentIconView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
        Style.styleSocialCountText(commentCountLabel)
        commentCountLabel.text = "15"
        commentCountLabel.lineBreakMode = .byTruncatingTail
        // commentCountLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)

        [postCommentView, commentIconView, commentCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        postCommentView.addSubview(commentIconView)
        postCommentView.addSubview(commentCountLabel)

        NSLayoutConstraint.activate([
            postCommentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            commentIconView.leadingAnchor.constraint(equalTo: postCommentView.leadingAnchor),
            commentIconView.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
            commentIconView.widthAnchor.constraint(equalToConstant: iconSize),
            commentIconView.heightAnchor.constraint(equalToConstant: iconSize),
            commentCountLabel.leadingAnchor.constraint(equalTo: commentIconView.trailingAnchor, constant: 2),
            commentCountLabel.centerYAnchor.constraint(equalTo: postCommentView.centerYAnchor),
            commentCountLabel.trailingAnchor.constraint(equalTo: postCommentView.trailingAnchor),
            commentCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth),
            commentIconView.topAnchor.constraint(greaterThanOrEqualTo: postCommentView.topAnchor),
            commentIconView.bottomAnchor.constraint(lessThanOrEqualTo: postCommentView.bottomAnchor)
        ])
    }

    private func setupPostSharesViews() {
        sharesIconView.image = UIImage(named: "messenger") ?? UIImage(systemName: "message")
        sharesIconView.contentMode = .scaleAspectFit
        sharesIconView.tintColor = .label
        // sharesIconView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
        Style.styleSocialCountText(sharesCountLabel)
        sharesCountLabel.text = "5"
        sharesCountLabel.lineBreakMode = .byTruncatingTail
        // sharesCountLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)

        [postSharesView, sharesIconView, sharesCountLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        postSharesView.addSubview(sharesIconView)
        postSharesView.addSubview(sharesCountLabel)

        NSLayoutConstraint.activate([
            postSharesView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            sharesIconView.leadingAnchor.constraint(equalTo: postSharesView.leadingAnchor),
            sharesIconView.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
            sharesIconView.widthAnchor.constraint(equalToConstant: iconSize),
            sharesIconView.heightAnchor.constraint(equalToConstant: iconSize),
            sharesCountLabel.leadingAnchor.constraint(equalTo: sharesIconView.trailingAnchor, constant: 2),
            sharesCountLabel.centerYAnchor.constraint(equalTo: postSharesView.centerYAnchor),
            sharesCountLabel.trailingAnchor.constraint(equalTo: postSharesView.trailingAnchor),
            sharesCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: countMaxWidth),
            sharesIconView.topAnchor.constraint(greaterThanOrEqualTo: postSharesView.topAnchor),
            sharesIconView.bottomAnchor.constraint(lessThanOrEqualTo: postSharesView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
