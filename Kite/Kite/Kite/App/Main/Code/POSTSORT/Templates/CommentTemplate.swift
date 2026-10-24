//
//  CommentTemplate.swift
//  Kite
//
//  Created by David Vasquez on 11/15/25.
//

import UIKit


class CommentTemplate: UIView {
    
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



//How to Use
/*

 class ViewController: UIViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         
         let commentView = UserCommentTemplate()
         commentView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(commentView)
         
         commentView.configure(
             userName: "Bilbo",
             commentText: "This looks great! Love how reusable this is. This looks great! Love how reusable this is.",
             image: UIImage(named: "background_1")
         )
         
         NSLayoutConstraint.activate([
             commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             commentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
         ])
     }
 }

 
 */
