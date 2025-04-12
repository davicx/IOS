//
//  PostViewController.swift
//  Kite
//
//  Created by David Vasquez on 2/27/25.
//

import UIKit


class SinglePostViewController: UIViewController {
    
    var currentPost: Post!
    
    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let likeStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        
        if let post = currentPost {
            postImage.image = post.postImageData ?? UIImage(named: "background_10")
            postCaptionLabel.text = post.postCaption
            let currentLikeCount = post.simpleLikesArray?.count ?? 0
            likeCountLabel.text = "\(currentLikeCount)"
        } else {
            print("Error: currentPost is nil")
        }
    }
    
    func setupViews() {
        // Image View
        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postImage)
        
        // Caption Label
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.font = UIFont.systemFont(ofSize: 16)
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCaptionLabel)
        
        // Like Button
        let imageName = currentPost?.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
        likeButton.tintColor = .systemRed // optional if you're using a template image
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        // Like Count Label
        likeCountLabel.text = "0" // Default value
        likeCountLabel.font = UIFont.systemFont(ofSize: 18)
        likeCountLabel.textAlignment = .center
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        likeStackView.axis = .horizontal
        likeStackView.distribution = .fillEqually
        likeStackView.spacing = 8
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.addArrangedSubview(likeCountLabel)
        likeStackView.addArrangedSubview(likeButton)
        view.addSubview(likeStackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),
            
            likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
            likeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            likeStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func likeButtonTappedOriginal() {
        print("Like button tapped!")
        
        if let post = currentPost {
            // For now, just re-show the like count (you can later update the array if needed)
            let currentLikeCount = post.simpleLikesArray?.count ?? 0
            likeCountLabel.text = "\(currentLikeCount)"
        } else {
            print("Error: currentPost is nil")
        }
    }
    
    //Need Current Status to update and toggle 
    @objc func likeButtonTapped() {
        guard let post = currentPost else {
            print("Error: currentPost is nil")
            return
        }
        
        // Safely unwrap and toggle
        post.isLikedByCurrentUser = !(post.isLikedByCurrentUser ?? false)
        
        // Update button image
        let newImageName = post.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: newImageName), for: .normal)
        
        // Optional: update like count label if you modify the count
        let currentLikeCount = post.simpleLikesArray?.count ?? 0
        likeCountLabel.text = "\(currentLikeCount)"
    }
}


