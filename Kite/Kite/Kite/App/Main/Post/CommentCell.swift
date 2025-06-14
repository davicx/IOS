//
//  CommentCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//


import UIKit



//Need a Did Like Comment Delegate
protocol CommentCellDelegate: AnyObject {
     func didTapLikeCommentButton(in cell: CommentCell)
}


class CommentCell: UITableViewCell {
    weak var delegate: CommentCellDelegate?
    
    // MAIN: Views
    let userView = UIView()
    let commentView = UIView()
    let dividerView = UIView()
    
    //COMMENT
    let userInfoView = UIView()
    let commentCaptionView = UIView()
    let commentSocialsView = UIView()
    
    //UI LABELS
    let userNameLabel = UILabel()
    let userFirstNameLabel = UILabel()
    let timeLabel = UILabel()
    let menuButton = UIButton(type: .system)
    let likesLabel = UILabel()
    let likeCommentButton = UIButton(type: .system)
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserInfoView()
        setupCommentCaptionView()
        setupCommentSocialsView()
        //setupCommentSocialsView()
        setupActions()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupActions() {
        likeCommentButton.addTarget(self, action: #selector(didTapLikeComment), for: .touchUpInside)
    }

    @objc private func didTapLikeComment() {
        print("STEP 1: CommentCell - User tapped Like button and called didTapLikeCommentButton in controller")
        delegate?.didTapLikeCommentButton(in: self)
    }
    
    //CELL SETUP
    func configureComment(with comment: Comment) {
        //print("CommentCell: configureComment was called to set up cell")
        
        //Comment From Image
        
        //Comment User Info
        if let userName = comment.userName {
            userNameLabel.text = "@\(userName)"
        } else {
            userNameLabel.text = "@unknown"
        }

        let first = comment.firstName ?? "Unknown"
        let last = comment.lastName ?? "Unknown"
        userFirstNameLabel.text = "\(first) \(last)"

        
        //Comment Caption
        if let textView = commentCaptionView.subviews.compactMap({ $0 as? UITextView }).first {
            textView.text = comment.commentCaption
        }
        
        let likeCount = comment.commentLikes?.count ?? comment.commentLikeCount ?? 0
        likesLabel.text = "\(likeCount) likes"

        let imageName = comment.commentLikedByCurrentUser == true ? "liked" : "like"
        likeCommentButton.setImage(UIImage(named: imageName), for: .normal)

        stopLoading()
    }

    
    //FUNCTIONS
    func startLoading() {
        likeCommentButton.isEnabled = false
    }

    func stopLoading() {
        likeCommentButton.isEnabled = true
    }

 
    //STYLE
    private func setupMainViews() {
         userView.backgroundColor = .blue
         commentView.backgroundColor = .systemPink
         dividerView.backgroundColor = .black

         [userView, commentView, dividerView].forEach {
             $0.translatesAutoresizingMaskIntoConstraints = false
             contentView.addSubview($0)
         }

         NSLayoutConstraint.activate([
             // userView: fixed width, full vertical
             userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             userView.topAnchor.constraint(equalTo: contentView.topAnchor),
             userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             userView.widthAnchor.constraint(equalToConstant: 80),

             // commentView: takes remaining space
             commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
             commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
             commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

             // dividerView: full width, 1 pixel height at bottom
             dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
         ])
        
        
        //Set up User Image
        let userImageView = UIImageView()
        
        userImageView.image = UIImage(named: "user")
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 30
        
        userView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 65),
            userImageView.heightAnchor.constraint(equalToConstant: 65)
        ])
     }
    
    private func setupUserInfoView() {
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.backgroundColor = .yellow
        commentView.addSubview(userInfoView)

        let userNameView = UIView()
        userNameView.backgroundColor = .lightGray
        userNameView.translatesAutoresizingMaskIntoConstraints = false

        let userFirstNameView = UIView()
        userFirstNameView.backgroundColor = .systemRed
        userFirstNameView.translatesAutoresizingMaskIntoConstraints = false

        let commentMenuView = UIView()
        commentMenuView.translatesAutoresizingMaskIntoConstraints = false
        commentMenuView.backgroundColor = .clear
        userInfoView.addSubview(userNameView)
        userInfoView.addSubview(userFirstNameView)
        userInfoView.addSubview(commentMenuView)

        // Add labels
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userFirstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.addSubview(userNameLabel)
        userFirstNameView.addSubview(userFirstNameLabel)

        // Stack for time label and menu button
        let timeMenuStack = UIStackView()
        timeMenuStack.axis = .horizontal
        timeMenuStack.alignment = .center
        timeMenuStack.distribution = .equalSpacing
        timeMenuStack.spacing = 8
        timeMenuStack.translatesAutoresizingMaskIntoConstraints = false
        commentMenuView.addSubview(timeMenuStack)

        // Time label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "14h"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        timeMenuStack.addArrangedSubview(timeLabel)

        // Menu button
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "menu-vertical-50")?.withRenderingMode(.alwaysOriginal)
        menuButton.setImage(image, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        timeMenuStack.addArrangedSubview(menuButton)

        // Only size constraints for button inside stack
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24)
        ])

        // Layout constraints
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: commentView.topAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 48),

            commentMenuView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            commentMenuView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor),
            commentMenuView.widthAnchor.constraint(equalToConstant: 80),
            commentMenuView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),

            userNameView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 24),

            userFirstNameView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userFirstNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userFirstNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
            userFirstNameView.heightAnchor.constraint(equalToConstant: 24),

            userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor, constant: 8),
            userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userNameView.trailingAnchor, constant: -4),

            userFirstNameLabel.leadingAnchor.constraint(equalTo: userFirstNameView.leadingAnchor, constant: 8),
            userFirstNameLabel.centerYAnchor.constraint(equalTo: userFirstNameView.centerYAnchor),
            userFirstNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userFirstNameView.trailingAnchor, constant: -4),

            timeMenuStack.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),
            timeMenuStack.centerYAnchor.constraint(equalTo: commentMenuView.centerYAnchor)
        ])
    }

    
    private func setupUserInfoViewWORKING() {
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.backgroundColor = .yellow
        commentView.addSubview(userInfoView)

        let userNameView = UIView()
        userNameView.backgroundColor = .lightGray
        userNameView.translatesAutoresizingMaskIntoConstraints = false

        let userFirstNameView = UIView()
        userFirstNameView.backgroundColor = .systemRed
        userFirstNameView.translatesAutoresizingMaskIntoConstraints = false

        let commentMenuView = UIView()
        commentMenuView.translatesAutoresizingMaskIntoConstraints = false
        commentMenuView.backgroundColor = .clear // or .systemBlue for testing
        userInfoView.addSubview(userNameView)
        userInfoView.addSubview(userFirstNameView)
        userInfoView.addSubview(commentMenuView)

        // Add labels to user views
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userFirstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.addSubview(userNameLabel)
        userFirstNameView.addSubview(userFirstNameLabel)

        // Time label setup
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "14h"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        commentMenuView.addSubview(timeLabel)

        // Menu button setup
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "menu-vertical-50")?.withRenderingMode(.alwaysOriginal)
        menuButton.setImage(image, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        commentMenuView.addSubview(menuButton)
        

        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: commentView.topAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 48),

            commentMenuView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            commentMenuView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor),
            commentMenuView.widthAnchor.constraint(equalToConstant: 80),
            commentMenuView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),

            userNameView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 24),

            userFirstNameView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userFirstNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userFirstNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
            userFirstNameView.heightAnchor.constraint(equalToConstant: 24),

            userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor, constant: 8),
            userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userNameView.trailingAnchor, constant: -4),

            userFirstNameLabel.leadingAnchor.constraint(equalTo: userFirstNameView.leadingAnchor, constant: 8),
            userFirstNameLabel.centerYAnchor.constraint(equalTo: userFirstNameView.centerYAnchor),
            userFirstNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userFirstNameView.trailingAnchor, constant: -4),

            timeLabel.topAnchor.constraint(equalTo: commentMenuView.topAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),

            menuButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
            menuButton.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    
    private func setupCommentCaptionView() {
        commentCaptionView.translatesAutoresizingMaskIntoConstraints = false
        commentCaptionView.backgroundColor = .white // background for caption
        commentView.addSubview(commentCaptionView)

        let commentTextView = UITextView()
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.isEditable = false
        commentTextView.isScrollEnabled = false
        commentTextView.font = UIFont.systemFont(ofSize: 14)
        commentTextView.text = "Placeholder for caption"
        commentCaptionView.addSubview(commentTextView)

        NSLayoutConstraint.activate([
            commentCaptionView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            commentCaptionView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentCaptionView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),

            commentTextView.topAnchor.constraint(equalTo: commentCaptionView.topAnchor, constant: 4),
            commentTextView.leadingAnchor.constraint(equalTo: commentCaptionView.leadingAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: commentCaptionView.trailingAnchor, constant: -8),
            commentTextView.bottomAnchor.constraint(equalTo: commentCaptionView.bottomAnchor, constant: -4)
        ])
    }
    
    
    private func setupCommentSocialsView() {
        // Setup container view
        commentSocialsView.translatesAutoresizingMaskIntoConstraints = false
        commentSocialsView.backgroundColor = .green // temp color for debugging
        commentView.addSubview(commentSocialsView)

        NSLayoutConstraint.activate([
            commentSocialsView.topAnchor.constraint(equalTo: commentCaptionView.bottomAnchor),
            commentSocialsView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentSocialsView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentSocialsView.heightAnchor.constraint(equalToConstant: 28),
            commentSocialsView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])

        // Setup like button
        likeCommentButton.tintColor = .systemRed
        likeCommentButton.setImage(UIImage(named: "like"), for: .normal)
        likeCommentButton.translatesAutoresizingMaskIntoConstraints = false
        commentSocialsView.addSubview(likeCommentButton)

        // Setup likes label
        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        commentSocialsView.addSubview(likesLabel)

        // Setup activity indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        commentSocialsView.addSubview(activityIndicator)

        // Constraints for subviews inside commentSocialsView
        NSLayoutConstraint.activate([
            likeCommentButton.centerYAnchor.constraint(equalTo: commentSocialsView.centerYAnchor),
            likeCommentButton.leadingAnchor.constraint(equalTo: commentSocialsView.leadingAnchor, constant: 16),
            likeCommentButton.widthAnchor.constraint(equalToConstant: 24),
            likeCommentButton.heightAnchor.constraint(equalToConstant: 24),

            likesLabel.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeCommentButton.trailingAnchor, constant: 8),

            activityIndicator.centerXAnchor.constraint(equalTo: likeCommentButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor)
        ])
    }

    //ACTIONS
    @objc private func menuButtonTapped() {
        print("hi")
    }


}
