//
//  CommentCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//


import UIKit

class CommentCell: UITableViewCell {
    
    //VIEWS
    let commentView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let commentLeftView = CreateViewStyles.createUIView(backgroundColor: .systemPink)
    let commentRightView = CreateViewStyles.createUIView(backgroundColor: .clear)
    
    let commentHeader = CreateViewStyles.createUIView(backgroundColor: .systemYellow)
    let commentBody = CreateViewStyles.createUIView(backgroundColor: .systemBlue)
    let commentFooter = CreateViewStyles.createUIView(backgroundColor: .systemGreen)
    
    let dividerView = CreateViewStyles.createCommentDividerView()

 
    //IMAGE AND LABELS
    let commentLabel = CreateViewStyles.createCommentLabel()
    let profileImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDividerViews()
        setupMainViews()
        setupHeaderViews()
        setupBodyViews()
        setupFooterViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDividerViews()
        setupMainViews()
        setupHeaderViews()
        setupBodyViews()
        setupFooterViews()
    }
    
 
    //VIEWS: Main Views
    private func setupMainViews() {
        // Set translatesAutoresizingMaskIntoConstraints for all views
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentLeftView.translatesAutoresizingMaskIntoConstraints = false
        commentRightView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add views to content view
        contentView.addSubview(commentView)
        commentView.addSubview(commentLeftView)
        commentView.addSubview(commentRightView)
        
        // Setup profile image
        profileImageView.image = UIImage(named: "background_1")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 20 // Half of 48 for circular image
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        commentLeftView.addSubview(profileImageView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // commentView: full width, expandable height
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: dividerView.topAnchor),
            
            // commentLeftView: 52 wide, full height
            commentLeftView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentLeftView.topAnchor.constraint(equalTo: commentView.topAnchor),
            commentLeftView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor),
            commentLeftView.widthAnchor.constraint(equalToConstant: 52),
            
            // commentRightView: fills remaining space
            commentRightView.leadingAnchor.constraint(equalTo: commentLeftView.trailingAnchor),
            commentRightView.topAnchor.constraint(equalTo: commentView.topAnchor),
            commentRightView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentRightView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor),
            
            // profileImageView: 48x48, 8px from top, centered horizontally
            profileImageView.topAnchor.constraint(equalTo: commentLeftView.topAnchor, constant: 6),
            profileImageView.centerXAnchor.constraint(equalTo: commentLeftView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //HEADER: Username and Menu Label
    let commentMenuView = CreateViewStyles.createUIView(backgroundColor: .systemRed)
    let commentUserNameView = CreateViewStyles.createUIView(backgroundColor: .systemOrange)
    
    // User name views inside commentUserNameView
    let userNameView = CreateViewStyles.createUIView(backgroundColor: .systemPurple)
    let userHandleView = CreateViewStyles.createUIView(backgroundColor: .systemTeal)
    
    // Labels for user info
    let userNameLabel = UILabel()
    let userHandleLabel = UILabel()
    
    // Footer holder views
    let likeHolderView = CreateViewStyles.createUIView(backgroundColor: .systemRed)
    let likeHolderCount = CreateViewStyles.createUIView(backgroundColor: .systemBlue)
    let commentHolderView = CreateViewStyles.createUIView(backgroundColor: .systemGreen)
    let commentHolderCount = CreateViewStyles.createUIView(backgroundColor: .systemOrange)
    
    // Footer images and labels
    let likeImageView = UIImageView()
    let likeCountLabel = UILabel()
    let commentImageView = UIImageView()
    let commentCountLabel = UILabel()
    
    // Menu image
    let menuImageView = UIImageView()
    
  
    private func setupHeaderViews() {
        // Set translatesAutoresizingMaskIntoConstraints for header views
        commentHeader.translatesAutoresizingMaskIntoConstraints = false
        commentMenuView.translatesAutoresizingMaskIntoConstraints = false
        commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userHandleView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userHandleLabel.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add commentHeader to commentRightView
        commentRightView.addSubview(commentHeader)
        
        // Add header views to commentHeader
        commentHeader.addSubview(commentUserNameView)
        commentHeader.addSubview(commentMenuView)
        
        // Add menu image to commentMenuView
        commentMenuView.addSubview(menuImageView)
        
        // Add user name views to commentUserNameView
        commentUserNameView.addSubview(userNameView)
        commentUserNameView.addSubview(userHandleView)
        
        // Add labels to their respective views
        userNameView.addSubview(userNameLabel)
        userHandleView.addSubview(userHandleLabel)
        
        // Setup menu image
        menuImageView.image = UIImage(named: "menu-dots-gray")
        menuImageView.contentMode = .scaleAspectFit
        
        // Setup labels
        userNameLabel.text = "Frodo Baggins"
        userNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        userNameLabel.textColor = .black
        
        userHandleLabel.text = "@frodo"
        userHandleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        userHandleLabel.textColor = .gray
        
        // Setup constraints for header views
        NSLayoutConstraint.activate([
            commentHeader.topAnchor.constraint(equalTo: commentRightView.topAnchor),
            commentHeader.leadingAnchor.constraint(equalTo: commentRightView.leadingAnchor),
            commentHeader.trailingAnchor.constraint(equalTo: commentRightView.trailingAnchor),
            commentHeader.heightAnchor.constraint(equalToConstant: 32),
        
            // commentUserNameView: fills remaining space, left aligned
            commentUserNameView.leadingAnchor.constraint(equalTo: commentHeader.leadingAnchor),
            commentUserNameView.topAnchor.constraint(equalTo: commentHeader.topAnchor),
            commentUserNameView.bottomAnchor.constraint(equalTo: commentHeader.bottomAnchor),
            commentUserNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
            
            // commentMenuView: 32 wide, right aligned
            commentMenuView.trailingAnchor.constraint(equalTo: commentHeader.trailingAnchor),
            commentMenuView.topAnchor.constraint(equalTo: commentHeader.topAnchor),
            commentMenuView.bottomAnchor.constraint(equalTo: commentHeader.bottomAnchor),
            commentMenuView.widthAnchor.constraint(equalToConstant: 32),
            
            // userNameView: top half of commentUserNameView (16px tall)
            userNameView.topAnchor.constraint(equalTo: commentUserNameView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 16),
            
            // userHandleView: bottom half of commentUserNameView (16px tall)
            userHandleView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userHandleView.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor),
            userHandleView.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor),
            userHandleView.heightAnchor.constraint(equalToConstant: 16),
            
            // userNameLabel: inside userNameView with no left padding
            userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
            userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userNameView.trailingAnchor, constant: -4),
            
            // userHandleLabel: inside userHandleView with no left padding
            userHandleLabel.leadingAnchor.constraint(equalTo: userHandleView.leadingAnchor),
            userHandleLabel.centerYAnchor.constraint(equalTo: userHandleView.centerYAnchor),
            userHandleLabel.trailingAnchor.constraint(lessThanOrEqualTo: userHandleView.trailingAnchor, constant: -4),
            
            // menuImageView: centered in commentMenuView
            menuImageView.centerXAnchor.constraint(equalTo: commentMenuView.centerXAnchor),
            menuImageView.centerYAnchor.constraint(equalTo: commentMenuView.centerYAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 16),
            menuImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    //BODY: Caption
    private func setupBodyViews() {
        commentBody.translatesAutoresizingMaskIntoConstraints = false
        
        // Add body views to commentRightView
        commentRightView.addSubview(commentBody)
        
        // Add commentLabel to commentBody
        commentBody.addSubview(commentLabel)
        
        // Setup constraints for body views
        NSLayoutConstraint.activate([
            // commentBody: dynamic height, between header and footer
            commentBody.topAnchor.constraint(equalTo: commentHeader.bottomAnchor),
            commentBody.leadingAnchor.constraint(equalTo: commentRightView.leadingAnchor),
            commentBody.trailingAnchor.constraint(equalTo: commentRightView.trailingAnchor),
            
            // commentLabel: inside commentBody with no padding
            commentLabel.topAnchor.constraint(equalTo: commentBody.topAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentBody.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: commentBody.trailingAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: commentBody.bottomAnchor)
        ])
    }
    
    //FOOTER: Socials
    private func setupFooterViews() {
        commentFooter.translatesAutoresizingMaskIntoConstraints = false
        likeHolderView.translatesAutoresizingMaskIntoConstraints = false
        likeHolderCount.translatesAutoresizingMaskIntoConstraints = false
        commentHolderView.translatesAutoresizingMaskIntoConstraints = false
        commentHolderCount.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add commentFooter to commentRightView
        commentRightView.addSubview(commentFooter)
        
        // Add footer holder views to commentFooter
        commentFooter.addSubview(likeHolderView)
        commentFooter.addSubview(likeHolderCount)
        commentFooter.addSubview(commentHolderView)
        commentFooter.addSubview(commentHolderCount)
        
        // Add images and labels to their respective views
        likeHolderView.addSubview(likeImageView)
        likeHolderCount.addSubview(likeCountLabel)
        commentHolderView.addSubview(commentImageView)
        commentHolderCount.addSubview(commentCountLabel)
        
        // Setup images
        likeImageView.image = UIImage(named: "like")
        likeImageView.contentMode = .scaleAspectFit
        likeImageView.tintColor = .black
        
        commentImageView.image = UIImage(named: "comment")
        commentImageView.contentMode = .scaleAspectFit
        commentImageView.tintColor = .black
        
        // Setup labels
        likeCountLabel.text = "25"
        likeCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        likeCountLabel.textColor = .black
        likeCountLabel.textAlignment = .center
        
        commentCountLabel.text = "8"
        commentCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        commentCountLabel.textColor = .black
        commentCountLabel.textAlignment = .center
        
        // Setup constraints for footer views
        NSLayoutConstraint.activate([
            // commentFooter: 24 tall at bottom
            commentFooter.topAnchor.constraint(equalTo: commentBody.bottomAnchor),
            commentFooter.leadingAnchor.constraint(equalTo: commentRightView.leadingAnchor),
            commentFooter.trailingAnchor.constraint(equalTo: commentRightView.trailingAnchor),
            commentFooter.bottomAnchor.constraint(equalTo: commentRightView.bottomAnchor),
            commentFooter.heightAnchor.constraint(equalToConstant: 24),
            
            // likeHolderView: 24 wide, leftmost
            likeHolderView.leadingAnchor.constraint(equalTo: commentFooter.leadingAnchor),
            likeHolderView.topAnchor.constraint(equalTo: commentFooter.topAnchor),
            likeHolderView.bottomAnchor.constraint(equalTo: commentFooter.bottomAnchor),
            likeHolderView.widthAnchor.constraint(equalToConstant: 24),
            
            // likeHolderCount: 24 wide, next to likeHolderView
            likeHolderCount.leadingAnchor.constraint(equalTo: likeHolderView.trailingAnchor),
            likeHolderCount.topAnchor.constraint(equalTo: commentFooter.topAnchor),
            likeHolderCount.bottomAnchor.constraint(equalTo: commentFooter.bottomAnchor),
            likeHolderCount.widthAnchor.constraint(equalToConstant: 24),
            
            // commentHolderView: 24 wide, next to likeHolderCount
            commentHolderView.leadingAnchor.constraint(equalTo: likeHolderCount.trailingAnchor),
            commentHolderView.topAnchor.constraint(equalTo: commentFooter.topAnchor),
            commentHolderView.bottomAnchor.constraint(equalTo: commentFooter.bottomAnchor),
            commentHolderView.widthAnchor.constraint(equalToConstant: 24),
            
            // commentHolderCount: 24 wide, next to commentHolderView
            commentHolderCount.leadingAnchor.constraint(equalTo: commentHolderView.trailingAnchor),
            commentHolderCount.topAnchor.constraint(equalTo: commentFooter.topAnchor),
            commentHolderCount.bottomAnchor.constraint(equalTo: commentFooter.bottomAnchor),
            commentHolderCount.widthAnchor.constraint(equalToConstant: 24),
            
            // likeImageView: centered in likeHolderView
            likeImageView.centerXAnchor.constraint(equalTo: likeHolderView.centerXAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: likeHolderView.centerYAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: 20),
            likeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // likeCountLabel: centered in likeHolderCount
            likeCountLabel.centerXAnchor.constraint(equalTo: likeHolderCount.centerXAnchor),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeHolderCount.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: likeHolderCount.leadingAnchor, constant: 2),
            likeCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: likeHolderCount.trailingAnchor, constant: -2),
            
            // commentImageView: centered in commentHolderView
            commentImageView.centerXAnchor.constraint(equalTo: commentHolderView.centerXAnchor),
            commentImageView.centerYAnchor.constraint(equalTo: commentHolderView.centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: 20),
            commentImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // commentCountLabel: centered in commentHolderCount
            commentCountLabel.centerXAnchor.constraint(equalTo: commentHolderCount.centerXAnchor),
            commentCountLabel.centerYAnchor.constraint(equalTo: commentHolderCount.centerYAnchor),
            commentCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: commentHolderCount.leadingAnchor, constant: 2),
            commentCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: commentHolderCount.trailingAnchor, constant: -2)
        ])
    }

    
    //DIVIDER: Divider Views
    private func setupDividerViews() {
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            // dividerView: 2px black line at bottom
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    
    //ACTIONS
    func updateComment(with comment: Comment) {
        let commentCaption = comment.commentCaption ?? "no comment"
        commentLabel.text = commentCaption
    }
}



/*
//WORKS BUT HALF DONE
class CommentCell: UITableViewCell {

    let commentUserView = createBaseView(backgroundColor: .systemPink) // Just to visually debug
    
    //COMMENT BODY: Three views stacked vertically
    let commentBodyUserView = createBaseView(backgroundColor: .yellow)
    let commentBodyCaptionView = createBaseView(backgroundColor: .lightGray)
    let commentBodySocialsView = createBaseView(backgroundColor: .green)
    
    //COMMENT BODY LABELS
    let commentBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment goes here..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserViews()
        setupBodyViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUserViews()
        setupBodyViews()
    }

    //COMMENT: User View
    private func setupUserViews() {
        commentUserView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentUserView)

        NSLayoutConstraint.activate([
            // commentUserView: 52 wide, full height, aligned left
            commentUserView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentUserView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentUserView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentUserView.widthAnchor.constraint(equalToConstant: 52),

        ])

    }

    //COMMENT: Body Views - Three views stacked vertically
    private func setupBodyViews() {
        //Setup the three body views
        commentBodyUserView.translatesAutoresizingMaskIntoConstraints = false
        commentBodyCaptionView.translatesAutoresizingMaskIntoConstraints = false
        commentBodySocialsView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(commentBodyUserView)
        contentView.addSubview(commentBodyCaptionView)
        contentView.addSubview(commentBodySocialsView)

        //commentBodyUserView: 20 tall
        NSLayoutConstraint.activate([
            commentBodyUserView.leadingAnchor.constraint(equalTo: commentUserView.trailingAnchor),
            commentBodyUserView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentBodyUserView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentBodyUserView.heightAnchor.constraint(equalToConstant: 20),
        ])

        //commentBodyCaptionView: Let the label determine the height
        NSLayoutConstraint.activate([
            commentBodyCaptionView.leadingAnchor.constraint(equalTo: commentUserView.trailingAnchor),
            commentBodyCaptionView.topAnchor.constraint(equalTo: commentBodyUserView.bottomAnchor, constant: 0),
            commentBodyCaptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

        //commentBodySocialsView: 20 tall
        NSLayoutConstraint.activate([
            commentBodySocialsView.leadingAnchor.constraint(equalTo: commentUserView.trailingAnchor),
            commentBodySocialsView.topAnchor.constraint(equalTo: commentBodyCaptionView.bottomAnchor, constant: 0),
            commentBodySocialsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentBodySocialsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentBodySocialsView.heightAnchor.constraint(equalToConstant: 20),
        ])

        //Add the comment body label to the caption view
        commentBodyCaptionView.addSubview(commentBodyLabel)
        NSLayoutConstraint.activate([
            commentBodyLabel.topAnchor.constraint(equalTo: commentBodyCaptionView.topAnchor, constant: 8),
            commentBodyLabel.bottomAnchor.constraint(equalTo: commentBodyCaptionView.bottomAnchor, constant: -8),
            commentBodyLabel.leadingAnchor.constraint(equalTo: commentBodyCaptionView.leadingAnchor, constant: 8),
            commentBodyLabel.trailingAnchor.constraint(equalTo: commentBodyCaptionView.trailingAnchor, constant: -8),
        ])
    }
    
    //ACTIONS
    func updateComment(with comment: Comment) {
        let commentCaption = comment.commentCaption ?? "no comment"
        commentBodyLabel.text = commentCaption
    }
}


func createBaseView(userInteractionEnabled: Bool = true, backgroundColor: UIColor? = nil) -> UIView {
    let view = UIView()
    view.backgroundColor = backgroundColor ?? .clear
    view.isUserInteractionEnabled = userInteractionEnabled
    return view
}

func createCommentDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .black
    
    return view
}

*/



//WORKING
/*
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

*/
