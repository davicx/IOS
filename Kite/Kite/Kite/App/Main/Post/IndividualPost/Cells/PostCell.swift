//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 7/21/25.
//

import UIKit


class PostCell: UITableViewCell {
    
    //POST HEADER: Post Information
    let postHeaderView = createHeaderView()
    
    let userImageHolderView = createUserImageHolderView()
    let userNameHolderView = createUserNameHolderView()
    let userMenuHolderView = createUserMenuHolderView()
    
    //User Image
    let userImageView = createUserImageView()
    
    

    
    
    
    //POST BODY: Post Image, Socials and Caption
    //Post Image
    let postImageView = createPostImageView()
    let postImage = createPostImage()
    
    //Post Socials
    let postSocialsView = createPostSocialsView()
    let postSocialsLabel = createPostSocialsText()
    
    //Post Caption
    let postCaptionView = createPostCaptionView()
    let postCaptionLabel = createPostCaptionText()
    
    //Heights for Dynamic Content
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    //Post Divider
    let postDividerView = createPostDividerView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeaderViews()
        setupBodyViews()
        setupFooterViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderViews() {
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postHeaderView)

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // Add subviews
        userImageHolderView.translatesAutoresizingMaskIntoConstraints = false
        userNameHolderView.translatesAutoresizingMaskIntoConstraints = false
        userMenuHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        postHeaderView.addSubview(userImageHolderView)
        postHeaderView.addSubview(userNameHolderView)
        postHeaderView.addSubview(userMenuHolderView)
        
        NSLayoutConstraint.activate([
            // Left: userImageHolderView
            userImageHolderView.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor),
            userImageHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userImageHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            userImageHolderView.widthAnchor.constraint(equalToConstant: 52),

            // Middle: userNameHolderView
            userNameHolderView.leadingAnchor.constraint(equalTo: userImageHolderView.trailingAnchor),
            userNameHolderView.trailingAnchor.constraint(equalTo: userMenuHolderView.leadingAnchor),
            userNameHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userNameHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            
            // Right: userMenuHolderView
            userMenuHolderView.trailingAnchor.constraint(equalTo: postHeaderView.trailingAnchor),
            userMenuHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userMenuHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            userMenuHolderView.widthAnchor.constraint(equalToConstant: 52)

            
        ])
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageHolderView.addSubview(userImageView)

        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: userImageHolderView.leadingAnchor, constant: 5),
            userImageView.topAnchor.constraint(equalTo: userImageHolderView.topAnchor, constant: 4),
            userImageView.widthAnchor.constraint(equalToConstant: 42),
            userImageView.heightAnchor.constraint(equalToConstant: 42)
        ])

    }

    
    //BODY: The full post
    private func setupBodyViews() {
        
        //Post Image
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postImageView)
        postImageView.addSubview(postImage)
        
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true
        
        //Post Caption
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionLabel)
        
        postCaptionHeightConstraint = postCaptionView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        //Post Socials
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialsLabel)
        
        
        NSLayoutConstraint.activate([
            
            //Post Image View
            postImageView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImage.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            postImage.leftAnchor.constraint(equalTo: postImageView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: postImageView.rightAnchor, constant: -0),
            postImage.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -0),
            
            //Post Caption View
            postCaptionView.topAnchor.constraint(equalTo: postSocialsLabel.bottomAnchor, constant: 0),
            postCaptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postCaptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionView.topAnchor, constant: 0),
            postCaptionLabel.leftAnchor.constraint(equalTo: postCaptionView.leftAnchor, constant: 0),
            postCaptionLabel.rightAnchor.constraint(equalTo: postCaptionView.rightAnchor, constant: -0),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: -0),
           
            //Post Socials View
            postSocialsView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 0),
            postSocialsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postSocialsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postSocialsView.heightAnchor.constraint(equalToConstant: 40),
           
            postSocialsLabel.topAnchor.constraint(equalTo: postSocialsView.topAnchor, constant: 0),
            postSocialsLabel.leftAnchor.constraint(equalTo: postSocialsView.leftAnchor, constant: 0),
            postSocialsLabel.rightAnchor.constraint(equalTo: postSocialsView.rightAnchor, constant: -0),
            postSocialsLabel.bottomAnchor.constraint(equalTo: postSocialsView.bottomAnchor, constant: -0),
  
        ])
        
    }
    

    //FOOTER: Divider
    private func setupFooterViews() {
        postDividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postDividerView)
        
        NSLayoutConstraint.activate([
            postDividerView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: 0),
            postDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postDividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postDividerView.heightAnchor.constraint(equalToConstant: 5),
            
            //Chat Maybe
            //postDividerView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
        
    }
    
    //POST SETUP: Actual Post Information
    func updatePost(with post: Post) {
        
        //POST HEADER: Setup
        let groupImage = post.groupImageData ?? UIImage(named: "background_1") ?? UIImage()
        userImageView.image = groupImage

        //POST BODY: Setup
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = post.postCaption ?? "no caption"
        
        let imageHeight = getImageHeight(image: currentImage)
        postImageHeightConstraint?.constant = imageHeight
        postImage.image = currentImage
        
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        postCaptionHeightConstraint?.constant = captionHeight
        postCaptionLabel.text = postCaption
        
        postSocialsLabel.text = "Post Like Count: \(post.simpleLikesArray?.count ?? 0)"
        
        layoutIfNeeded()
    }
    
}


//HEADER VIEWS
func createHeaderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemPink
    
    return view
}

//Main header layout
func createUserImageHolderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .orange
    return view
}

func createUserNameHolderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .cyan
    return view
}

func createUserMenuHolderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .purple
    return view
}

//User Image
func createUserImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 21 // Half of 42 for circle
    imageView.backgroundColor = .white
    return imageView
}

//BODY VIEWS
func createPostImageView() -> UIView {
    let view = UIView()
    view.backgroundColor = .lightGray
    
    return view

}

func createPostCaptionView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

}

func createPostSocialsView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

}

//FOOTER VIEWS
func createFooterView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view
}


//UI VIEWS
func createPostImage() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}

func createPostCaptionText() -> UILabel {
    let label = UILabel()
    label.text = "CAPTION: My Caption"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    //label.textAlignment = .center
    label.backgroundColor = .green
    
    return label
}

func createPostDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemRed
    
    return view
}

 
//TEMP
func createPostSocialsText() -> UILabel {
    let label = UILabel()
    label.text = "SOCIALS: Post User"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .blue
    
    return label
}



