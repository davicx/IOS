//
//  UserCommentTemplate.swift
//  Playground
//
//  Created by David Vasquez on 11/12/25.
//


import UIKit


class UserCommentTemplate: UIView {
    
    // MARK: - Subviews (containers)
    let commentImageView = UIView()
    let commentUserNameView = UIView()
    let commentTextView = UIView()
    
    // MARK: - Internal Elements
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()
    private let commentLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommentView()
        setupCommentImageView()
        setupCommentUserNameView()
        setupCommentTextView()
        setupMainConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCommentView()
        setupCommentImageView()
        setupCommentUserNameView()
        setupCommentTextView()
        setupMainConstraints()
    }
    
    // MARK: - Setup Container
    private func setupCommentView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup Image View
    private func setupCommentImageView() {
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.layer.cornerRadius = 8
        commentImageView.clipsToBounds = true
        addSubview(commentImageView)
        
        userImage.image = UIImage(named: "background_1")
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 30
        userImage.layer.masksToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: commentImageView.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Setup User Name View
    private func setupCommentUserNameView() {
        commentUserNameView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        commentUserNameView.layer.cornerRadius = 6
        commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentUserNameView)
        
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentUserNameView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor, constant: -8),
            userNameLabel.centerYAnchor.constraint(equalTo: commentUserNameView.centerYAnchor)
        ])
    }
    
    // MARK: - Setup Comment Text View
    private func setupCommentTextView() {
        commentTextView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        commentTextView.layer.cornerRadius = 6
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentTextView)
        
        commentLabel.text = "This is an example comment text that can expand to multiple lines if needed."
        commentLabel.font = UIFont.systemFont(ofSize: 15)
        commentLabel.textColor = .white
        commentLabel.numberOfLines = 0
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -8),
            commentLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Layout Constraints
    private func setupMainConstraints() {
        NSLayoutConstraint.activate([
            commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentImageView.widthAnchor.constraint(equalToConstant: 60),
            commentImageView.heightAnchor.constraint(equalToConstant: 60),
            
            commentUserNameView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentUserNameView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentUserNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentUserNameView.heightAnchor.constraint(equalToConstant: 32),
            
            commentTextView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentTextView.topAnchor.constraint(equalTo: commentUserNameView.bottomAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    func configure(userName: String, commentText: String, image: UIImage?) {
        userNameLabel.text = userName
        commentLabel.text = commentText
        userImage.image = image
    }
}

/*
 import UIKit
 import Kingfisher

 class UserCommentTemplate: UIView {
     
     // MARK: - Subviews (containers)
     let commentImageView = UIView()
     let commentUserNameView = UIView()
     let commentTextView = UIView()
     
     // MARK: - Internal Elements
     private let userImage = UIImageView()
     private let userNameLabel = UILabel()
     private let commentLabel = UILabel()
     
     // MARK: - Init
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupCommentView()
         setupCommentImageView()
         setupCommentUserNameView()
         setupCommentTextView()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setupCommentView()
         setupCommentImageView()
         setupCommentUserNameView()
         setupCommentTextView()
     }
     
     // MARK: - Setup Container
     private func setupCommentView() {
         backgroundColor = UIColor.systemGray6
         layer.cornerRadius = 10
         translatesAutoresizingMaskIntoConstraints = false
     }
     
     // MARK: - Setup Image View
     private func setupCommentImageView() {
         commentImageView.translatesAutoresizingMaskIntoConstraints = false
         commentImageView.layer.cornerRadius = 8
         commentImageView.clipsToBounds = true
         addSubview(commentImageView)
         
         userImage.image = UIImage(named: "placeholder_avatar")
         userImage.contentMode = .scaleAspectFill
         userImage.layer.cornerRadius = 30
         userImage.layer.masksToBounds = true
         userImage.translatesAutoresizingMaskIntoConstraints = false
         userImage.backgroundColor = UIColor.systemGray4 // Placeholder color
         commentImageView.addSubview(userImage)
         
         NSLayoutConstraint.activate([
             commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
             commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
             commentImageView.widthAnchor.constraint(equalToConstant: 60),
             commentImageView.heightAnchor.constraint(equalToConstant: 60),
             
             userImage.centerXAnchor.constraint(equalTo: commentImageView.centerXAnchor),
             userImage.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor),
             userImage.widthAnchor.constraint(equalToConstant: 60),
             userImage.heightAnchor.constraint(equalToConstant: 60)
         ])
     }
     
     // MARK: - Setup User Name View
     private func setupCommentUserNameView() {
         commentUserNameView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
         commentUserNameView.layer.cornerRadius = 6
         commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(commentUserNameView)
         
         userNameLabel.text = "User Name"
         userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
         userNameLabel.textColor = .white
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         commentUserNameView.addSubview(userNameLabel)
         
         NSLayoutConstraint.activate([
             commentUserNameView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
             commentUserNameView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
             commentUserNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
             commentUserNameView.heightAnchor.constraint(equalToConstant: 32),
             
             userNameLabel.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor, constant: 8),
             userNameLabel.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor, constant: -8),
             userNameLabel.centerYAnchor.constraint(equalTo: commentUserNameView.centerYAnchor)
         ])
     }
     
     // MARK: - Setup Comment Text View
     private func setupCommentTextView() {
         commentTextView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
         commentTextView.layer.cornerRadius = 6
         commentTextView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(commentTextView)
         
         commentLabel.text = "This is an example comment text that can expand to multiple lines if needed."
         commentLabel.font = UIFont.systemFont(ofSize: 15)
         commentLabel.textColor = .white
         commentLabel.numberOfLines = 0
         commentLabel.translatesAutoresizingMaskIntoConstraints = false
         commentTextView.addSubview(commentLabel)
         
         NSLayoutConstraint.activate([
             commentTextView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
             commentTextView.topAnchor.constraint(equalTo: commentUserNameView.bottomAnchor, constant: 8),
             commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
             commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
             
             commentLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 8),
             commentLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -8),
             commentLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 8),
             commentLabel.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: -8)
         ])
     }
     
     // MARK: - Configure using Kingfisher
     func configure(userName: String, commentText: String, imageURL: URL?) {
         userNameLabel.text = userName
         commentLabel.text = commentText
         
         let placeholder = UIImage(named: "placeholder_avatar")
         
         if let url = imageURL {
             userImage.kf.setImage(
                 with: url,
                 placeholder: placeholder,
                 options: [
                     .transition(.fade(0.3)),
                     .cacheOriginalImage
                 ]
             )
         } else {
             userImage.image = placeholder
         }
     }
 }

 */


/*
//SDWebImage or Kingfisher
class UserCommentTemplate: UIView {
    
    // MARK: - Subviews (containers)
    let commentImageView = UIView()
    let commentUserNameView = UIView()
    let commentTextView = UIView()
    
    // MARK: - Internal Elements
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()
    private let commentLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommentView()
        setupCommentImageView()
        setupCommentUserNameView()
        setupCommentTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCommentView()
        setupCommentImageView()
        setupCommentUserNameView()
        setupCommentTextView()
    }
    
    // MARK: - Setup Container
    private func setupCommentView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        //layer.borderWidth = 1
        //layer.borderColor = UIColor.systemGray3.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup Image View
    private func setupCommentImageView() {
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        //commentImageView.backgroundColor = UIColor.systemGray4
        commentImageView.layer.cornerRadius = 8
        commentImageView.clipsToBounds = true
        addSubview(commentImageView)
        
        userImage.image = UIImage(named: "background_1")
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 30
        userImage.layer.masksToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentImageView.widthAnchor.constraint(equalToConstant: 60),
            commentImageView.heightAnchor.constraint(equalToConstant: 60),
            
            userImage.centerXAnchor.constraint(equalTo: commentImageView.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Setup User Name View
    private func setupCommentUserNameView() {
        commentUserNameView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        commentUserNameView.layer.cornerRadius = 6
        commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentUserNameView)
        
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentUserNameView.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            commentUserNameView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentUserNameView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentUserNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentUserNameView.heightAnchor.constraint(equalToConstant: 32),
            
            userNameLabel.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor, constant: -8),
            userNameLabel.centerYAnchor.constraint(equalTo: commentUserNameView.centerYAnchor)
        ])
    }
    
    // MARK: - Setup Comment Text View
    private func setupCommentTextView() {
        commentTextView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        commentTextView.layer.cornerRadius = 6
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentTextView)
        
        commentLabel.text = "This is an example comment text that can expand to multiple lines if needed."
        commentLabel.font = UIFont.systemFont(ofSize: 15)
        commentLabel.textColor = .white
        commentLabel.numberOfLines = 0
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentTextView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentTextView.topAnchor.constraint(equalTo: commentUserNameView.bottomAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            commentLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -8),
            commentLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    func configure(userName: String, commentText: String, image: UIImage?) {
        userNameLabel.text = userName
        commentLabel.text = commentText
        userImage.image = image
    }
}
*/

//WORKS
/*
class UserCommentTemplate: UIView {
    
    // MARK: - Subviews (containers)
    let commentImageView = UIView()
    let commentUserNameView = UIView()
    let commentTextView = UIView()
    
    // MARK: - Internal Elements
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()
    private let commentLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = UIColor.systemGray6
        
        // Image container setup
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.backgroundColor = UIColor.systemGray4   // NEW
        commentImageView.layer.cornerRadius = 8                  // NEW
        commentImageView.clipsToBounds = true
        addSubview(commentImageView)
        
        userImage.image = UIImage(named: "background_1")
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 30     // NEW (2/3 scale = 40/2)
        userImage.layer.masksToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.addSubview(userImage)
        
        // Username container
        commentUserNameView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        commentUserNameView.layer.cornerRadius = 6
        commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentUserNameView)
        
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentUserNameView.addSubview(userNameLabel)
        
        // Comment text container
        commentTextView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        commentTextView.layer.cornerRadius = 6
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentTextView)
        
        commentLabel.text = "This is an example comment text that can expand to multiple lines if needed."
        commentLabel.font = UIFont.systemFont(ofSize: 15)
        commentLabel.textColor = .white
        commentLabel.numberOfLines = 0
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.addSubview(commentLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Image container
            commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentImageView.widthAnchor.constraint(equalToConstant: 60),
            commentImageView.heightAnchor.constraint(equalToConstant: 60),
            
            // Actual image inside (2/3 size)
            userImage.centerXAnchor.constraint(equalTo: commentImageView.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: commentImageView.centerYAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 60),   // NEW
            userImage.heightAnchor.constraint(equalToConstant: 60),  // NEW
            
            // Username view
            commentUserNameView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentUserNameView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentUserNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentUserNameView.heightAnchor.constraint(equalToConstant: 32),
            
            // Username label inside
            userNameLabel.leadingAnchor.constraint(equalTo: commentUserNameView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: commentUserNameView.trailingAnchor, constant: -8),
            userNameLabel.centerYAnchor.constraint(equalTo: commentUserNameView.centerYAnchor),
            
            // Comment text view
            commentTextView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentTextView.topAnchor.constraint(equalTo: commentUserNameView.bottomAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Comment label inside
            commentLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -8),
            commentLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    func configure(userName: String, commentText: String, image: UIImage?) {
        userNameLabel.text = userName
        commentLabel.text = commentText
        userImage.image = image
    }
}


*/

/*
class UserCommentTemplate: UIView {
    
    // MARK: - Subviews
    let commentImageView = UIImageView()
    let commentUserNameView = UILabel()
    let commentTextView = UILabel()
    private let userNameBackground = UIView()
    private let commentBackground = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = UIColor.systemGray5
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        // Image View
        commentImageView.image = UIImage(named: "background_1")
        commentImageView.contentMode = .scaleAspectFill
        commentImageView.layer.cornerRadius = 30 // half of 60
        commentImageView.layer.masksToBounds = true
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentImageView)
        
        // Username background
        userNameBackground.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        userNameBackground.layer.cornerRadius = 4
        userNameBackground.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userNameBackground)
        
        // Username label
        commentUserNameView.font = UIFont.boldSystemFont(ofSize: 16)
        commentUserNameView.textColor = .white
        commentUserNameView.text = "User Name"
        commentUserNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameBackground.addSubview(commentUserNameView)
        
        // Comment background
        commentBackground.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        commentBackground.layer.cornerRadius = 6
        commentBackground.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentBackground)
        
        // Comment Text
        commentTextView.font = UIFont.systemFont(ofSize: 15)
        commentTextView.textColor = .black
        commentTextView.numberOfLines = 0
        commentTextView.text = "This is an example of comment text that expands to multiple lines if needed."
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentBackground.addSubview(commentTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Image view
            commentImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentImageView.widthAnchor.constraint(equalToConstant: 60),
            commentImageView.heightAnchor.constraint(equalToConstant: 60),
            
            // Username background
            userNameBackground.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            userNameBackground.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userNameBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            userNameBackground.heightAnchor.constraint(equalToConstant: 40),
            
            // Username label inside
            commentUserNameView.leadingAnchor.constraint(equalTo: userNameBackground.leadingAnchor, constant: 8),
            commentUserNameView.trailingAnchor.constraint(equalTo: userNameBackground.trailingAnchor, constant: -8),
            commentUserNameView.centerYAnchor.constraint(equalTo: userNameBackground.centerYAnchor),
            
            // Comment background
            commentBackground.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 12),
            commentBackground.topAnchor.constraint(equalTo: userNameBackground.bottomAnchor, constant: 8),
            commentBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            commentBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Comment text inside
            commentTextView.leadingAnchor.constraint(equalTo: commentBackground.leadingAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: commentBackground.trailingAnchor, constant: -8),
            commentTextView.topAnchor.constraint(equalTo: commentBackground.topAnchor, constant: 8),
            commentTextView.bottomAnchor.constraint(equalTo: commentBackground.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure method
    func configure(userName: String, commentText: String, image: UIImage?) {
        commentUserNameView.text = userName
        commentTextView.text = commentText
        commentImageView.image = image
    }
}

*/
