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
    let likeButton = UIButton(type: .system) // <--- New
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserViews()
        setupCommentViews()
        setupConstraints()
        setupDividerView()
        setupActions() // <--- New
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
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
        likeButton.tintColor = .systemRed
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(likeButton)
        footerView.addSubview(likesLabel)

        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 24),
            likeButton.heightAnchor.constraint(equalToConstant: 24),

            likesLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            likesLabel.trailingAnchor.constraint(lessThanOrEqualTo: footerView.trailingAnchor)
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

    private func setupActions() {
        likeButton.addTarget(self, action: #selector(didTapLikeComment), for: .touchUpInside)
    }


    @objc private func didTapLikeComment() {
        print("Like button tapped")
        // Handle UI update or delegate callback here
        delegate?.didTapLikeCommentButton(in: self)
    }
    
    func configureComment(with comment: CommentModel) {
        //print(comment.commentID)
        
        userNameLabel.text = comment.commentFrom
        commentTextView.text = comment.commentCaption

        let likeCount = comment.commentLikes?.count ?? comment.commentLikeCount ?? 0
        likesLabel.text = "\(likeCount) likes"

        let imageName = comment.commentLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    /*
     func setupButtonTarget() {
         likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
     }

     @objc private func likeButtonTapped() {
         delegate?.didTapLikeButton(in: self)
     }

     func configurePost(with post: Post) {
         postImage.image = post.postImageData ?? UIImage(named: Constants.Image.fallbackPostImage)
         postCaptionLabel.text = post.postCaption
         likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"

         let imageName = post.isLikedByCurrentUser == true ? "liked" : "like"
         likeButton.setImage(UIImage(named: imageName), for: .normal)
         

         stopLoading()
     }
     */
    

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




//WORKING
/*
class CommentCell: UITableViewCell {
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserViews()
        setupCommentViews()
        setupConstraints()
        setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        //headerView.backgroundColor = .systemPink
        bodyView.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        //footerView.backgroundColor = .white
        //footerView.backgroundColor = .blue
        
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
        bodyView.backgroundColor = .systemPurple.withAlphaComponent(0.3)

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
        footerView.backgroundColor = .white

        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(likesLabel)

        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: footerView.topAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
    }

    //Divider
    private func setupDividerView() {
        dividerView.backgroundColor = .lightGray
        contentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale) // 1px line
        ])
    }
    
    //Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MAIN: userView
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userView.widthAnchor.constraint(equalToConstant: 80),
            
            // MAIN: commentView
            commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Header View: Contains user name
            headerView.topAnchor.constraint(equalTo: commentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 24),
            
            // Body View: Contains comment caption
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            
            // Footer View: Contains likes
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 40),
            footerView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])
    }
    
    func configure(with comment: CommentModel) {
        userNameLabel.text = comment.commentFrom
        commentTextView.text = comment.commentCaption
        likesLabel.text = "\(comment.commentLikes?.count ?? 0) likes"
    }
}
*/
