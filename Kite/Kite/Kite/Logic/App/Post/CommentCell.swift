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
    
    // USER: Views
    let userImageView = UIImageView()
    
    // COMMENT: Views
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()
    
    // Header, Body, Footer Content
    let userNameLabel = UILabel()
    let commentTextView = UITextView()
    let likesLabel = UILabel()
    let likeCommentButton = UIButton(type: .system) // <--- New
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserViews()
        setupCommentViews()
        setupConstraints()
        setupDividerView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //ACTIONS
    private func setupActions() {
        likeCommentButton.addTarget(self, action: #selector(didTapLikeComment), for: .touchUpInside)
    }


    @objc private func didTapLikeComment() {
        print("STEP 1: CommentCell- User tapped Like button and called didTapLikeCommentButton inside IndividualPostViewController")
        delegate?.didTapLikeCommentButton(in: self)
    }
    
    //CELL SETUP
    func configureComment(with comment: Comment) {
        print("CommentCell: configureComment was called to set up cell")
        userNameLabel.text = comment.commentFrom
        commentTextView.text = comment.commentCaption

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
        userView.backgroundColor = .white
        commentView.backgroundColor = .clear
        
        contentView.addSubview(userView)
        contentView.addSubview(commentView)
        
        [userView, commentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupUserViews() {
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

    private func setupCommentViews() {
        bodyView.backgroundColor = .systemPurple.withAlphaComponent(0.3)


        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        [headerView, bodyView, footerView].forEach {
            commentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupHeaderView()
        setupBodyView()
        setupFooterView()
    }

    private func setupHeaderView() {
        headerView.backgroundColor = .systemPink

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(userNameLabel)

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }

    private func setupBodyView() {
        commentTextView.isScrollEnabled = false
        commentTextView.isEditable = false
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false

        bodyView.addSubview(commentTextView)

        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])
    }

    private func setupFooterView() {
        likeCommentButton.tintColor = .systemRed
        likeCommentButton.setImage(UIImage(named: "like"), for: .normal)
        likeCommentButton.translatesAutoresizingMaskIntoConstraints = false

        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(likeCommentButton)
        footerView.addSubview(likesLabel)
        //footerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            likeCommentButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likeCommentButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            likeCommentButton.widthAnchor.constraint(equalToConstant: 24),
            likeCommentButton.heightAnchor.constraint(equalToConstant: 24),

            likesLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeCommentButton.trailingAnchor, constant: 8),
            likesLabel.trailingAnchor.constraint(lessThanOrEqualTo: footerView.trailingAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: likeCommentButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor)
        ])
    }

    private func setupDividerView() {
        dividerView.backgroundColor = .lightGray
        contentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userView.widthAnchor.constraint(equalToConstant: 80),

            commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerView.topAnchor.constraint(equalTo: commentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 24),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 40),
            footerView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])
    }

}



//INTERESTING COMMENTS
/*
protocol CommentCellDelegate: AnyObject {
    func didTapLikeCommentButton(in cell: CommentCell)
}

class CommentCell: UITableViewCell {
    weak var delegate: CommentCellDelegate?

    // MAIN VIEWS
    let containerView = UIView()
    let userView = UIView()
    let commentView = UIView()
    let dividerView = UIView()

    // USER
    let userImageView = UIImageView()

    // COMMENT SUBVIEWS
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    // CONTENT
    let userNameLabel = UILabel()
    let commentTextView = UITextView()
    let likesLabel = UILabel()
    let likeCommentButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // CONFIGURE
    func configureComment(with comment: Comment) {
        userNameLabel.text = comment.commentFrom
        commentTextView.text = comment.commentCaption

        let likeCount = comment.commentLikes?.count ?? comment.commentLikeCount ?? 0
        likesLabel.text = "\(likeCount) likes"

        let imageName = comment.commentLikedByCurrentUser == true ? "liked" : "like"
        likeCommentButton.setImage(UIImage(named: imageName), for: .normal)
        
        stopLoading()
    }

    // ACTIONS
    private func setupActions() {
        likeCommentButton.addTarget(self, action: #selector(didTapLikeComment), for: .touchUpInside)
    }

    @objc private func didTapLikeComment() {
        delegate?.didTapLikeCommentButton(in: self)
    }

    func startLoading() {
        likeCommentButton.isEnabled = false
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        likeCommentButton.isEnabled = true
        activityIndicator.stopAnimating()
    }

    // SETUP VIEWS
    private func setupViews() {
        backgroundColor = UIColor.systemGray6

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        [userView, commentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }

        // USER VIEW
        userImageView.image = UIImage(named: "user")
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 25
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userView.addSubview(userImageView)

        // COMMENT STRUCTURE
        [headerView, bodyView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            commentView.addSubview($0)
        }

        // HEADER
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(userNameLabel)

        // BODY
        commentTextView.isScrollEnabled = false
        commentTextView.isEditable = false
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.backgroundColor = .clear
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.addSubview(commentTextView)

        // FOOTER
        likeCommentButton.tintColor = .systemRed
        likeCommentButton.setImage(UIImage(named: "like"), for: .normal)
        likeCommentButton.translatesAutoresizingMaskIntoConstraints = false

        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        footerView.addSubview(likeCommentButton)
        footerView.addSubview(likesLabel)
        footerView.addSubview(activityIndicator)

        // DIVIDER
        dividerView.backgroundColor = .lightGray
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerView)
    }

    // CONSTRAINTS
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            userView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            userView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            userView.widthAnchor.constraint(equalToConstant: 50),
            userView.heightAnchor.constraint(equalToConstant: 50),

            userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: userView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),

            commentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor, constant: 12),
            commentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            commentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            headerView.topAnchor.constraint(equalTo: commentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),

            userNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 4),
            bodyView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),

            commentTextView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 8),
            footerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 24),
            footerView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor),

            likeCommentButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likeCommentButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            likeCommentButton.widthAnchor.constraint(equalToConstant: 24),
            likeCommentButton.heightAnchor.constraint(equalToConstant: 24),

            likesLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeCommentButton.trailingAnchor, constant: 8),

            activityIndicator.centerXAnchor.constraint(equalTo: likeCommentButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor),

            dividerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

*/
