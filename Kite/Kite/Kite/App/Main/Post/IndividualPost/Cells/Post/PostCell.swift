//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 7/21/25.
//

import UIKit



//HOME FEED: Kite 
class PostCell: UITableViewCell {
    
    //POST HEADER: Post Information
    let postHeaderView = createBaseView()
    let userImageHolderView = createBaseView()
    let userEventHolderView = createBaseView()
    let userMenuHolderView = createBaseView()
    
    //User Image
    let userImageView = createUserImageView()
    
    let userEventNameHolderView = createBaseView()
    let userEventTimeHolderView = createBaseView()

    let userEventNameText = createUserEventNameLabel()
    let userEventTimeText = createUserEventTimeLabel()
    
    //Menu
    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu-horizontal")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()

    //POST BODY: Post Image, Socials and Caption
    //Post Image
    let postImageView = createPostImageView()
    let postImage = createPostImage()
    
    //Post Socials
    let postSocialsView = createBaseView()
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
        setupMenu()
        setupBodyImageViews()
        //setupBodyCaptionViews()
        //setupBodySocialsViews()
        //setupFooterViews()
        
        print("PostCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //HEADER
    private func setupHeaderViews() {
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        postHeaderView.isUserInteractionEnabled = true
        addSubview(postHeaderView)

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        //Main Subviews
        userImageHolderView.translatesAutoresizingMaskIntoConstraints = false
        userImageHolderView.isUserInteractionEnabled = true
        userEventHolderView.translatesAutoresizingMaskIntoConstraints = false
        userEventHolderView.isUserInteractionEnabled = true
        userMenuHolderView.translatesAutoresizingMaskIntoConstraints = false
        userMenuHolderView.isUserInteractionEnabled = true
        
        postHeaderView.addSubview(userImageHolderView)
        postHeaderView.addSubview(userEventHolderView)
        postHeaderView.addSubview(userMenuHolderView)
        
        NSLayoutConstraint.activate([
            // Left: userImageHolderView
            userImageHolderView.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor),
            userImageHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userImageHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            userImageHolderView.widthAnchor.constraint(equalToConstant: 52),

            // Middle: userNameHolderView
            userEventHolderView.leadingAnchor.constraint(equalTo: userImageHolderView.trailingAnchor),
            userEventHolderView.trailingAnchor.constraint(equalTo: userMenuHolderView.leadingAnchor),
            userEventHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userEventHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            
            // Right: userMenuHolderView
            userMenuHolderView.trailingAnchor.constraint(equalTo: postHeaderView.trailingAnchor),
            userMenuHolderView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            userMenuHolderView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            userMenuHolderView.widthAnchor.constraint(equalToConstant: 52)

        ])
        
        //LEFT: User Image View
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageHolderView.addSubview(userImageView)

        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: userImageHolderView.leadingAnchor, constant: 5),
            userImageView.topAnchor.constraint(equalTo: userImageHolderView.topAnchor, constant: 4),
            userImageView.widthAnchor.constraint(equalToConstant: 42),
            userImageView.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        //MIDDLE: Group Information
        // Add name and time holder views to userNameHolderView
        userEventNameHolderView.translatesAutoresizingMaskIntoConstraints = false
        userEventTimeHolderView.translatesAutoresizingMaskIntoConstraints = false

        userEventHolderView.addSubview(userEventNameHolderView)
        userEventHolderView.addSubview(userEventTimeHolderView)

        NSLayoutConstraint.activate([
            userEventNameHolderView.topAnchor.constraint(equalTo: userEventHolderView.topAnchor),
            userEventNameHolderView.leadingAnchor.constraint(equalTo: userEventHolderView.leadingAnchor),
            userEventNameHolderView.trailingAnchor.constraint(equalTo: userEventHolderView.trailingAnchor),
            userEventNameHolderView.heightAnchor.constraint(equalToConstant: 24),

            userEventTimeHolderView.topAnchor.constraint(equalTo: userEventNameHolderView.bottomAnchor),
            userEventTimeHolderView.leadingAnchor.constraint(equalTo: userEventHolderView.leadingAnchor),
            userEventTimeHolderView.trailingAnchor.constraint(equalTo: userEventHolderView.trailingAnchor),
            userEventTimeHolderView.heightAnchor.constraint(equalToConstant: 24),
        ])

        userEventNameText.translatesAutoresizingMaskIntoConstraints = false
        userEventTimeText.translatesAutoresizingMaskIntoConstraints = false

        userEventNameHolderView.addSubview(userEventNameText)
        userEventTimeHolderView.addSubview(userEventTimeText)

        NSLayoutConstraint.activate([
            userEventNameText.topAnchor.constraint(equalTo: userEventNameHolderView.topAnchor, constant: 6),
            userEventNameText.bottomAnchor.constraint(equalTo: userEventNameHolderView.bottomAnchor),
            userEventNameText.leadingAnchor.constraint(equalTo: userEventNameHolderView.leadingAnchor, constant: 4),
            userEventNameText.trailingAnchor.constraint(equalTo: userEventNameHolderView.trailingAnchor, constant: -8),

            userEventTimeText.topAnchor.constraint(equalTo: userEventTimeHolderView.topAnchor),
            userEventTimeText.bottomAnchor.constraint(equalTo: userEventTimeHolderView.bottomAnchor, constant: -6),
            userEventTimeText.leadingAnchor.constraint(equalTo: userEventTimeHolderView.leadingAnchor, constant: 4),
            userEventTimeText.trailingAnchor.constraint(equalTo: userEventTimeHolderView.trailingAnchor, constant: -8),
        ])

        //RIGHT: Setup Menu
        userMenuHolderView.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: userMenuHolderView.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: userMenuHolderView.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // Add menu button directly to content view for proper user interaction
        contentView.addSubview(menuButton)
        
        // Update constraints to position relative to content view
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24),
        ])

    }
    

    //BODY: The full post
    private func setupBodyImageViews() {
        
        //Post Image
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postImageView)
        postImageView.addSubview(postImage)
        
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            //Post Image View
            postImageView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImage.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            postImage.leftAnchor.constraint(equalTo: postImageView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: postImageView.rightAnchor, constant: -0),
            postImage.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -0),
            
        ])

    }
    
    private func setupBodyCaptionViews() {
    
        //Post Caption
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionLabel)
        
        postCaptionHeightConstraint = postCaptionView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        
        NSLayoutConstraint.activate([
     
            //Post Caption View
            postCaptionView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 0),
            postCaptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postCaptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionView.topAnchor, constant: 0),
            postCaptionLabel.leftAnchor.constraint(equalTo: postCaptionView.leftAnchor, constant: 0),
            postCaptionLabel.rightAnchor.constraint(equalTo: postCaptionView.rightAnchor, constant: -0),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: -0),

        ])

    }
   
    private func setupBodySocialsViews() {
        
        //Post Socials
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialsLabel)
        
        
        NSLayoutConstraint.activate([

            //Post Socials View
            postSocialsView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: 0),
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

        userEventNameText.text = post.groupName ?? "No Group"
        userEventTimeText.text = post.timeMessage ?? "No Time"
        
        //POST BODY: Setup
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = post.postCaption ?? "no caption"
        
        let imageHeight = getImageHeight(image: currentImage)
        postImageHeightConstraint?.constant = imageHeight
        postImage.image = currentImage
        
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        //let captionUserNameHeight = 20.0
        //let totalCaptionHeight = captionHeight + captionUserNameHeight
        
        postCaptionHeightConstraint?.constant = captionHeight
        postCaptionLabel.text = postCaption
        
        postSocialsLabel.text = "Post Like Count: \(post.simpleLikesArray?.count ?? 0)"
        
        layoutIfNeeded()
    }
    
    //ITEM SETUP: Actual Item Information (Item has all Post properties plus item-specific data)
    func updateItem(with item: Item) {
        
        //POST HEADER: Setup
        let groupImage = item.groupImageData ?? UIImage(named: "background_1") ?? UIImage()
        userImageView.image = groupImage

        userEventNameText.text = item.groupName ?? "No Group"
        userEventTimeText.text = item.timeMessage ?? "No Time"
        
        //POST BODY: Setup
        let currentImage = item.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = item.postCaption ?? "no caption"
        
        let imageHeight = getImageHeight(image: currentImage)
        postImageHeightConstraint?.constant = imageHeight
        postImage.image = currentImage
        
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postCaptionHeightConstraint?.constant = captionHeight
        postCaptionLabel.text = postCaption
        
        postSocialsLabel.text = "Post Like Count: \(item.simpleLikesArray?.count ?? 0)"
        
        layoutIfNeeded()
    }
    
    //ACTIONS
    //Function 1: Setup the menu
    private func setupMenu() {
        //print("PostCell: Setting up menu")
        
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
            print("PostCell: Edit tapped")
        }

        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            print("PostCell: Delete tapped")
        }

        let menu = UIMenu(title: "", children: [editAction, deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        
        //print("PostCell: Menu setup complete")
    }
    
    @objc private func menuButtonTapped() {
        print("PostCell: Menu button was tapped!")
    }


    
}

//BASE VIEWS
func createBaseView(userInteractionEnabled: Bool = true) -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    view.isUserInteractionEnabled = userInteractionEnabled
    return view
}



//HEADER VIEWS

//LEFT: User Image
func createUserImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 21 // Half of 42 for circle
    imageView.backgroundColor = .white
    return imageView
}

func createUserEventNameLabel() -> UILabel {
    let label = UILabel()
    label.text = "Group Name"
    label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    label.textColor = .black
    return label
}

func createUserEventTimeLabel() -> UILabel {
    let label = UILabel()
    label.text = "Time Message"
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .darkGray
    return label
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
    view.backgroundColor = .black
    
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



