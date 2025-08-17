//
//  HomePostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/26/25.
//

import UIKit


class HomePostCell: UITableViewCell {
    

    //MAIN VIEWS
    let postHeaderView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postImageView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postCaptionView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postSocialsView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postDividerView = CreateViewStyles.createUIView(backgroundColor: .clear)
    
    // Add height constraint for dynamic sizing
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?


    //HEADER
    let headerGroupImageView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let headerGroupImage = UIImageView()
    
    let headerGroupNameView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let headerGroupNameLabel = UILabel()
    
    let headerGroupInfoView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let headerGroupInfoLabel = UILabel()
    
    let headerGroupMenuView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let headerGroupMenuIcon = UIImageView()
    
    //GOOD USES STYLE
    private func setupHeaderViews() {
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupImageView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupImage.translatesAutoresizingMaskIntoConstraints = false
        headerGroupNameView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerGroupInfoView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        headerGroupMenuView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupMenuIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup group image
        Style.styleGroupImage(headerGroupImage)
        
        // Use Style class for group name label styling
        Style.styleUserNameLabel(headerGroupNameLabel)
        
        // Use Style class for group info label styling
        Style.styleGroupInfoLabel(headerGroupInfoLabel)
        
        // Setup menu icon
        headerGroupMenuIcon.image = UIImage(named: "menu-horizontal")
        headerGroupMenuIcon.contentMode = .scaleAspectFit
        
        // Add views and set constraints as before
        contentView.addSubview(postHeaderView)
        postHeaderView.addSubview(headerGroupImageView)
        headerGroupImageView.addSubview(headerGroupImage)
        postHeaderView.addSubview(headerGroupNameView)
        headerGroupNameView.addSubview(headerGroupNameLabel)
        postHeaderView.addSubview(headerGroupInfoView)
        headerGroupInfoView.addSubview(headerGroupInfoLabel)
        postHeaderView.addSubview(headerGroupMenuView)
        headerGroupMenuView.addSubview(headerGroupMenuIcon)

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 52),
            
            headerGroupImageView.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor, constant: 10),
            headerGroupImageView.centerYAnchor.constraint(equalTo: postHeaderView.centerYAnchor),
            headerGroupImageView.widthAnchor.constraint(equalToConstant: 40),
            headerGroupImageView.heightAnchor.constraint(equalToConstant: 40),
            
            headerGroupImage.topAnchor.constraint(equalTo: headerGroupImageView.topAnchor),
            headerGroupImage.leadingAnchor.constraint(equalTo: headerGroupImageView.leadingAnchor),
            headerGroupImage.trailingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor),
            headerGroupImage.bottomAnchor.constraint(equalTo: headerGroupImageView.bottomAnchor),
            
            headerGroupNameView.topAnchor.constraint(equalTo: postHeaderView.topAnchor, constant: 4),
            headerGroupNameView.leadingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor, constant: 10),
            headerGroupNameView.trailingAnchor.constraint(equalTo: headerGroupMenuView.leadingAnchor, constant: -10),
            headerGroupNameView.heightAnchor.constraint(equalToConstant: 26),
            
            headerGroupNameLabel.topAnchor.constraint(equalTo: headerGroupNameView.topAnchor),
            headerGroupNameLabel.leadingAnchor.constraint(equalTo: headerGroupNameView.leadingAnchor),
            headerGroupNameLabel.trailingAnchor.constraint(equalTo: headerGroupNameView.trailingAnchor),
            headerGroupNameLabel.bottomAnchor.constraint(equalTo: headerGroupNameView.bottomAnchor),
            
            headerGroupInfoView.topAnchor.constraint(equalTo: headerGroupNameView.bottomAnchor),
            headerGroupInfoView.leadingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor, constant: 10),
            headerGroupInfoView.trailingAnchor.constraint(equalTo: headerGroupMenuView.leadingAnchor, constant: -10),
            headerGroupInfoView.heightAnchor.constraint(equalToConstant: 26),
            
            headerGroupInfoLabel.topAnchor.constraint(equalTo: headerGroupInfoView.topAnchor),
            headerGroupInfoLabel.leadingAnchor.constraint(equalTo: headerGroupInfoView.leadingAnchor),
            headerGroupInfoLabel.trailingAnchor.constraint(equalTo: headerGroupInfoView.trailingAnchor),
            headerGroupInfoLabel.bottomAnchor.constraint(equalTo: headerGroupInfoView.bottomAnchor),
            
            headerGroupMenuView.trailingAnchor.constraint(equalTo: postHeaderView.trailingAnchor, constant: -10),
            headerGroupMenuView.centerYAnchor.constraint(equalTo: postHeaderView.centerYAnchor),
            headerGroupMenuView.widthAnchor.constraint(equalToConstant: 50),
            headerGroupMenuView.heightAnchor.constraint(equalToConstant: 50),
            
            headerGroupMenuIcon.centerXAnchor.constraint(equalTo: headerGroupMenuView.centerXAnchor),
            headerGroupMenuIcon.centerYAnchor.constraint(equalTo: headerGroupMenuView.centerYAnchor),
            headerGroupMenuIcon.widthAnchor.constraint(equalToConstant: 24),
            headerGroupMenuIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
    }


    
    //POST IMAGE
    let postImageUIView = createPostImage()
    
    private func setupImageViews() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageUIView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(postImageView)
        postImageView.addSubview(postImageUIView)

        // Create dynamic height constraint
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 100)
        postImageHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Make the image view fill the entire postImageView container
            postImageUIView.topAnchor.constraint(equalTo: postImageView.topAnchor),
            postImageUIView.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor),
            postImageUIView.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor),
            postImageUIView.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor)
        ])
    }
    
    //POST CAPTION
    let postCaptionUserImageView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postCaptionUserImage = UIImageView()
    
    let postCaptionUserNameView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postCaptionUsernameLabel = UILabel()
    
    let postCaptionTextView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postCaptionLabel = CreateViewStyles.createPostStyleCaptionText()
    
    private func setupCaptionViews() {
        
        //MAIN CONTAINER
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
     
        //Image
        postCaptionUserImageView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionUserImage.translatesAutoresizingMaskIntoConstraints = false
        
        //Username
        postCaptionUserNameView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        Style.styleUserNameText(postCaptionUsernameLabel)
        
        //Post Caption
        postCaptionTextView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Views
        contentView.addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionUserImageView)
        postCaptionUserImageView.addSubview(postCaptionUserImage)
        postCaptionView.addSubview(postCaptionUserNameView)
        postCaptionUserNameView.addSubview(postCaptionUsernameLabel)
        postCaptionView.addSubview(postCaptionTextView)
        postCaptionTextView.addSubview(postCaptionLabel)
        
        // Create dynamic height constraint for the text view
        postCaptionHeightConstraint = postCaptionTextView.heightAnchor.constraint(equalToConstant: 100)
        postCaptionHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            
            // PARENT: caption view
            postCaptionView.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            postCaptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postCaptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Left: User Image profile view (50 width, full height)
            postCaptionUserImageView.topAnchor.constraint(equalTo: postCaptionView.topAnchor),
            postCaptionUserImageView.leadingAnchor.constraint(equalTo: postCaptionView.leadingAnchor),
            postCaptionUserImageView.widthAnchor.constraint(equalToConstant: 50),
            postCaptionUserImageView.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor),
            
            // User image view inside profile view (42x42, 4pt margins)
            postCaptionUserImage.topAnchor.constraint(equalTo: postCaptionUserImageView.topAnchor, constant: 4),
            postCaptionUserImage.leadingAnchor.constraint(equalTo: postCaptionUserImageView.leadingAnchor, constant: 4),
            postCaptionUserImage.trailingAnchor.constraint(equalTo: postCaptionUserImageView.trailingAnchor, constant: -4),
            postCaptionUserImage.heightAnchor.constraint(equalTo: postCaptionUserImage.widthAnchor),
            
            // Top: User info view (28 fixed height, fills remaining horizontal space)
            postCaptionUserNameView.topAnchor.constraint(equalTo: postCaptionView.topAnchor),
            postCaptionUserNameView.leadingAnchor.constraint(equalTo: postCaptionUserImageView.trailingAnchor),
            postCaptionUserNameView.trailingAnchor.constraint(equalTo: postCaptionView.trailingAnchor),
            postCaptionUserNameView.heightAnchor.constraint(equalToConstant: 22),
            
            // Username label inside info view
            postCaptionUsernameLabel.topAnchor.constraint(equalTo: postCaptionUserNameView.topAnchor, constant: 8),
            postCaptionUsernameLabel.leadingAnchor.constraint(equalTo: postCaptionUserNameView.leadingAnchor, constant: 0),
            postCaptionUsernameLabel.trailingAnchor.constraint(equalTo: postCaptionUserNameView.trailingAnchor, constant: -10),
            postCaptionUsernameLabel.bottomAnchor.constraint(equalTo: postCaptionUserNameView.bottomAnchor, constant: -4),
           
            // Bottom: Text view (dynamic height, fills remaining horizontal space)
            postCaptionTextView.topAnchor.constraint(equalTo: postCaptionUserNameView.bottomAnchor),
            postCaptionTextView.leadingAnchor.constraint(equalTo: postCaptionUserImageView.trailingAnchor),
            postCaptionTextView.trailingAnchor.constraint(equalTo: postCaptionView.trailingAnchor),
            postCaptionTextView.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor),
            
            // Caption label fills the text view
            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionTextView.topAnchor, constant: 0),
            postCaptionLabel.leadingAnchor.constraint(equalTo: postCaptionTextView.leadingAnchor, constant: 4),
            postCaptionLabel.trailingAnchor.constraint(equalTo: postCaptionTextView.trailingAnchor, constant: -10),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionTextView.bottomAnchor, constant: -6)
        ])
    }


    
    //POST SOCIALS
    let postSocialLikesView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postSocialLikesIcon = UIImageView()
    let postSocialLikesCount = UILabel()
    let postSocialCommentsView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postSocialCommentsIcon = UIImageView()
    let postSocialCommentsCount = UILabel()
    let postSocialFillView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postSocialBookMarkView = CreateViewStyles.createUIView(backgroundColor: .clear)
   
    private func setupSocialsViews() {
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesView.translatesAutoresizingMaskIntoConstraints = false
        postSocialCommentsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialFillView.translatesAutoresizingMaskIntoConstraints = false
        postSocialBookMarkView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add tap gesture to likes view
        let likesTapGesture = UITapGestureRecognizer(target: self, action: #selector(likesViewTapped))
        postSocialLikesView.addGestureRecognizer(likesTapGesture)
        postSocialLikesView.isUserInteractionEnabled = true
        
        //LIKES: Setup likes icon and count
        postSocialLikesIcon.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesIcon.image = UIImage(named: "like")
        postSocialLikesIcon.contentMode = .scaleAspectFit
        
        postSocialLikesCount.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesCount.text = formatCount(0)
        Style.styleSocialCountText(postSocialLikesCount)
        
        //COMMENTS: Setup comments icon and count
        postSocialCommentsIcon.translatesAutoresizingMaskIntoConstraints = false
        postSocialCommentsIcon.image = UIImage(named: "comment")
        postSocialCommentsIcon.contentMode = .scaleAspectFit
        
        postSocialCommentsCount.translatesAutoresizingMaskIntoConstraints = false
        postSocialCommentsCount.text = formatCount(0)
        Style.styleSocialCountText(postSocialCommentsCount)
        
        //BOOKMARK: Setup bookmark icon
        let postSocialBookMarkIcon = UIImageView()
        postSocialBookMarkIcon.translatesAutoresizingMaskIntoConstraints = false
        postSocialBookMarkIcon.image = UIImage(named: "bookmark")
        postSocialBookMarkIcon.contentMode = .scaleAspectFit
        
        contentView.addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialLikesView)
        postSocialLikesView.addSubview(postSocialLikesIcon)
        postSocialLikesView.addSubview(postSocialLikesCount)
        postSocialsView.addSubview(postSocialCommentsView)
        postSocialCommentsView.addSubview(postSocialCommentsIcon)
        postSocialCommentsView.addSubview(postSocialCommentsCount)
        postSocialsView.addSubview(postSocialFillView)
        postSocialsView.addSubview(postSocialBookMarkView)
        postSocialBookMarkView.addSubview(postSocialBookMarkIcon)

        NSLayoutConstraint.activate([
            postSocialsView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor),
            postSocialsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocialsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postSocialsView.heightAnchor.constraint(equalToConstant: 32),
            
            //LIKES
            // Left: Likes view (60 wide, centered left)
            postSocialLikesView.leadingAnchor.constraint(equalTo: postSocialsView.leadingAnchor, constant: 50),
            postSocialLikesView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialLikesView.widthAnchor.constraint(equalToConstant: 60),
            postSocialLikesView.heightAnchor.constraint(equalToConstant: 30),
            
            // Likes icon (20x20, left side)
            postSocialLikesIcon.leadingAnchor.constraint(equalTo: postSocialLikesView.leadingAnchor, constant: 0),
            postSocialLikesIcon.centerYAnchor.constraint(equalTo: postSocialLikesView.centerYAnchor),
            postSocialLikesIcon.widthAnchor.constraint(equalToConstant: 26),
            postSocialLikesIcon.heightAnchor.constraint(equalToConstant: 26),
            
            // Likes count (right of icon, fixed width)
            postSocialLikesCount.leadingAnchor.constraint(equalTo: postSocialLikesIcon.trailingAnchor, constant: 4),
            postSocialLikesCount.centerYAnchor.constraint(equalTo: postSocialLikesView.centerYAnchor),
            postSocialLikesCount.widthAnchor.constraint(equalToConstant: 32),
            
            //COMMENTS
            // Left: Comments view (60 wide, next to likes)
            postSocialCommentsView.leadingAnchor.constraint(equalTo: postSocialLikesView.trailingAnchor, constant: 0),
            postSocialCommentsView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialCommentsView.widthAnchor.constraint(equalToConstant: 60),
            postSocialCommentsView.heightAnchor.constraint(equalToConstant: 30),
            
            // Comments icon (20x20, left side)
            postSocialCommentsIcon.leadingAnchor.constraint(equalTo: postSocialCommentsView.leadingAnchor, constant: 0),
            postSocialCommentsIcon.centerYAnchor.constraint(equalTo: postSocialCommentsView.centerYAnchor),
            postSocialCommentsIcon.widthAnchor.constraint(equalToConstant: 26),
            postSocialCommentsIcon.heightAnchor.constraint(equalToConstant: 26),
            
            // Comments count (right of icon, fixed width)
            postSocialCommentsCount.leadingAnchor.constraint(equalTo: postSocialCommentsIcon.trailingAnchor, constant: 4),
            postSocialCommentsCount.centerYAnchor.constraint(equalTo: postSocialCommentsView.centerYAnchor),
            postSocialCommentsCount.widthAnchor.constraint(equalToConstant: 32),
        
            //FILL SPACE
            // Middle: Fill view (fills space between comments and bookmark)
            postSocialFillView.leadingAnchor.constraint(equalTo: postSocialCommentsView.trailingAnchor, constant: 8),
            postSocialFillView.trailingAnchor.constraint(equalTo: postSocialBookMarkView.leadingAnchor, constant: -8),
            postSocialFillView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialFillView.heightAnchor.constraint(equalToConstant: 30),
            
            //BOOKMARK
            // Right: Bookmark view (60 wide, centered right)
            postSocialBookMarkView.trailingAnchor.constraint(equalTo: postSocialsView.trailingAnchor, constant: -10),
            postSocialBookMarkView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialBookMarkView.widthAnchor.constraint(equalToConstant: 60),
            postSocialBookMarkView.heightAnchor.constraint(equalToConstant: 30),
            
            // Bookmark icon (26x26, centered in bookmark view)
            postSocialBookMarkIcon.centerXAnchor.constraint(equalTo: postSocialBookMarkView.centerXAnchor),
            postSocialBookMarkIcon.centerYAnchor.constraint(equalTo: postSocialBookMarkView.centerYAnchor),
            postSocialBookMarkIcon.widthAnchor.constraint(equalToConstant: 24),
            postSocialBookMarkIcon.heightAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    
    //DIVIDER
    private func setupDividerViews() {
        postDividerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postDividerView)

        NSLayoutConstraint.activate([
            postDividerView.topAnchor.constraint(equalTo: postSocialsView.bottomAnchor),
            postDividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -16), // Extend beyond contentView to full screen width
            postDividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16), // Extend beyond contentView to full screen width
            postDividerView.heightAnchor.constraint(equalToConstant: 2),
            postDividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

    //SETUP
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeaderViews()
        setupImageViews()
        setupCaptionViews()
        setupSocialsViews()
        setupDividerViews()
        print("HomePostCell")
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //ACTIONS
    @objc private func likesViewTapped() {
        print("like")
    }
    
    
    
    //SETUP: Setup Post on Load
    func updatePost(with post: Post) {
        
        //STEP 1: Get Post Information
        let postID = post.postID
        let groupID = post.groupID ?? 0
        
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = post.postCaption ?? "no caption"
        
        //print("Post ID \(postID) Group ID \(groupID)")
        
        //STEP 2: Calculate and set the image and caption heights
        let postImageHeight = sizeFunctions.calculatePostImageHeight(from: currentImage)
        let postCaptionHeight = sizeFunctions.calculatePostCaptionHeight(from: postCaption)
                
        postImageHeightConstraint?.constant = postImageHeight
        postCaptionHeightConstraint?.constant = postCaptionHeight
        
        //STEP 3: Set the image to the postImageUIView
        postImageUIView.image = currentImage
        
        //STEP 4: Set the caption text
        postCaptionLabel.text = postCaption
        
        //STEP 5: Set username
        let username = post.postFrom ?? "unknown_user"
        postCaptionUsernameLabel.text = "@\(username)"
        
        //STEP 6: Set Post User Image
        let userImage = post.postFromImageData ?? UIImage(named: "background_1") ?? UIImage()
        postCaptionUserImage.image = userImage
        postCaptionUserImage.contentMode = .scaleAspectFill
        postCaptionUserImage.clipsToBounds = true
        postCaptionUserImage.layer.cornerRadius = 21 // Half of 42 for circular image
        
        //STEP 7: Set Header Group Image
        let groupImage = post.groupImageData ?? UIImage(named: "background_1") ?? UIImage()
        headerGroupImage.image = groupImage
        
        //STEP 8: Set Header Group Name
        let groupName = post.groupName ?? "Unknown Group"
        headerGroupNameLabel.text = groupName
        
        //STEP 9: Set Header Group Info (Time Message)
        let timeMessage = post.timeMessage ?? "Just now"
        headerGroupInfoLabel.text = timeMessage
        
        //STEP 10: Set Like Count and Status
        let likeCount = post.simpleLikesArray?.count ?? 0
        postSocialLikesCount.text = formatCount(likeCount)
        
        // Set like image based on user's like status
        let isLiked = post.isLikedByCurrentUser ?? false
        let likeImageName = isLiked ? "liked" : "like"
        postSocialLikesIcon.image = UIImage(named: likeImageName)
        
        //STEP 11: Set Comment Count
        let commentCount = post.commentsArray?.count ?? 0
        postSocialCommentsCount.text = formatCount(commentCount)
       
        // Force layout update
        layoutIfNeeded()
    }
    

}
