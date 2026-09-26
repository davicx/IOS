//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 7/21/25.
//

import UIKit



final class PostContentCell: UITableViewCell {

    /*
    //LOGIC
    private let postDataController = PostDataController.shared
    private var postID: Int?

    //UI COMPONENTS
    private let layout = ItemCellLayout()
    //Post will include
    //Socials
    //Caption
    //Comments will not be here but will be pulled in

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(layout)
        layout.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            layout.topAnchor.constraint(equalTo: contentView.topAnchor),
            layout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            layout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            layout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

   
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated),
            name: .postUpdated,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postID = nil
        layout.resetImageLayout()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //ACTIONS
    func configurePostCell(postID: Int) {
        self.postID = postID
        refreshPostCellUI()
    }

    //FUNCTIONS
    @objc private func purchaseTapped() {
        print("purchase")
    }

    @objc private func likeTapped() {
        guard
            let postID,
            let post = postDataController.getPostByID(postID: postID)
        else { return }

        let groupID = post.groupID ?? 0
        Task { await PostLogic.shared.toggleLike(post: post, groupID: groupID) }
    }

    private func refreshPostCellUI() {
        guard
            let postID,
            let post = postDataController.getPostByID(postID: postID)
        else { return }

        layout.apply(post: post)
    }

    @objc private func handlePostUpdated(_ notification: Notification) {
        guard
            let updatedPostID = notification.object as? Int,
            updatedPostID == postID
        else { return }

        refreshPostCellUI()
    }
    
    */
}


/*

class PostCell: UITableViewCell {

    private let postDataController = PostDataController.shared
    private var postID: Int?
    
    //UI Elements
    private let postImageView = UIImageView()
    private let captionLabel = UILabel()
    private let likeCountLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    
    // Constraints for dynamic image height
    private var imageHeightConstraint: NSLayoutConstraint?
    private var imageAspectRatioConstraint: NSLayoutConstraint?

    //Cell Setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        print("YO DODE PostCell")
        setupViews()
        setupLayout()

        //LISTENER: Post Updated
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated),
            name: .postUpdated,
            object: nil
        )
    }
    
    func configurePostCell(postID: Int) {
        self.postID = postID
        refreshPostCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    //LAYOUT
    private func setupViews() {
        // Post Image View
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = .systemGray6
        
        captionLabel.numberOfLines = 0
        captionLabel.font = .systemFont(ofSize: 16)

        likeCountLabel.font = .systemFont(ofSize: 14)
        likeCountLabel.textColor = .secondaryLabel

        likeButton.setTitle("Like", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        contentView.addSubview(postImageView)
        contentView.addSubview(captionLabel)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(likeButton)
    }

    private func setupLayout() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Post Image - full width, aspect ratio maintained
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Caption - below image
            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Like count
            likeCountLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 12),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            // Like button
            likeButton.centerYAnchor.constraint(equalTo: likeCountLabel.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 12)
        ])
    }


    //ACTIONS
    @objc private func likeTapped() {

        //STEP 1: Get the post that was liked
        if postID == nil {
            return
        }

        let currentPostID = postID!

        let post = postDataController.getPostByID(postID: currentPostID)

        if post == nil {
            return
        }

        let currentPost = post!
        let groupID = currentPost.groupID ?? 0

        //STEP 2: Call my Post Logic class to handle liking a post
        Task {
            await PostLogic.shared.toggleLike(post: currentPost, groupID: groupID)
        }
    }
    
    
    //FUNCTIONS
    private func refreshPostCellUI() {
        
        //STEP 1: Get current Post
        if postID == nil {
            return
        }

        let fetchedPost = postDataController.getPostByID(postID: postID!)

        if fetchedPost == nil {
            return
        }

        let currentPost = fetchedPost!

        //STEP 2: Update the Post Cell UI
        
        // Set post image with aspect ratio constraint
        if let postImage = currentPost.postImageData {
            postImageView.image = postImage
            updateImageAspectRatioConstraint(for: postImage)
        } else {
            // Hide image view or show placeholder if no image
            postImageView.image = nil
            // Set a zero height constraint when there's no image
            updateImageAspectRatioConstraint(for: nil)
        }
        
        captionLabel.text = currentPost.postCaption

        let likeCount = currentPost.postLikesArray?.count ?? 0
        likeCountLabel.text = "\(likeCount) likes"

        if currentPost.isLikedByCurrentUser == true {
            likeButton.setTitle("Liked", for: .normal)
        } else {
            likeButton.setTitle("Like me", for: .normal)
        }
    }
    
    private func updateImageAspectRatioConstraint(for image: UIImage?) {
        // Remove existing constraints
        imageAspectRatioConstraint?.isActive = false
        imageHeightConstraint?.isActive = false
        
        if let image = image {
            // Calculate aspect ratio: height / width
            let aspectRatio = image.size.height / image.size.width
            // Create aspect ratio constraint: image.height = image.width * aspectRatio
            imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
                equalTo: postImageView.widthAnchor,
                multiplier: aspectRatio
            )
            imageAspectRatioConstraint?.isActive = true
        } else {
            // No image - set height to 0
            imageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
            imageHeightConstraint?.isActive = true
        }
    }
    
    @objc private func handlePostUpdated(_ notification: Notification) {
        let updatedPostID = notification.object as? Int
        if updatedPostID == nil {
            return
        }

        if updatedPostID != postID {
            return
        }

        refreshPostCellUI()
    }
}

*/

/*
@objc private func handlePostUpdated(_ notification: Notification) {

    // 1. Make sure the notification contains a post ID
    if notification.object == nil {
        return
    }

    let updatedPostID = notification.object as? Int
    if updatedPostID == nil {
        return
    }

    // 2. Make sure this update is for MY post
    if updatedPostID != postID {
        return
    }

    // 3. Update the UI
    refreshUI()
}

*/

/*
@objc private func likeTapped() {

    // 1. Make sure this cell has a postID
    if postID == nil {
        return
    }

    let currentPostID = postID!

    // 2. Fetch the post from the data controller
    let post = postDataController.getPostByID(postID: currentPostID)

    // 3. Make sure the post exists
    if post == nil {
        return
    }

    let currentPost = post!

    // 4. Get groupID (use 0 as default if missing)
    let groupID = currentPost.groupID ?? 0

    // 5. Call PostLogic to toggle like (async)
    Task {
        await PostLogic.shared.toggleLike(post: currentPost, groupID: groupID)
    }
}
*/

/*
private func refreshUI() {
    guard
        let postID = postID,
        let post = postDataController.getPostByID(postID: postID)
    else { return }

    captionLabel.text = post.postCaption

    let likeCount = post.postLikesArray?.count ?? 0
    likeCountLabel.text = "\(likeCount) likes"

    let isLiked = post.isLikedByCurrentUser ?? false
    likeButton.setTitle(isLiked ? "Liked" : "Like me", for: .normal)
}
*/



/*
@objc private func handlePostUpdated(_ notification: Notification) {
    guard
        let updatedPostID = notification.object as? Int,
        updatedPostID == postID
    else { return }

    refreshUI()
}
*/


/*
@objc private func likeTapped() {
    guard
        let postID = postID,
        let post = postDataController.getPostByID(postID: postID)
    else { return }

    let groupID = post.groupID ?? 0
    
    // Use PostLogic to handle API call and data controller update
    Task {
        await PostLogic.shared.toggleLike(post: post, groupID: groupID)
    }
}
*/


 
//WORKING AND DESIGN LOOKS OK
/*
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
    
    //ITEM SETUP: Actual Item Information (Post with postType == "item")
    func updateItem(with post: Post) {
        
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
        
        postCaptionHeightConstraint?.constant = captionHeight
        postCaptionLabel.text = postCaption
        
        postSocialsLabel.text = "Post Like Count: \(post.simpleLikesArray?.count ?? 0)"
        
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
*/
//Kite
/*
class PostCell: UITableViewCell {

    private let postDataController = PostDataController.shared

    private let captionLabel = UILabel()
    private let likeCountLabel = UILabel()
    private let likeButton = UIButton(type: .system)

    private var postID: Int?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        captionLabel.numberOfLines = 0
        captionLabel.font = .systemFont(ofSize: 16)

        likeCountLabel.font = .systemFont(ofSize: 14)
        likeCountLabel.textColor = .secondaryLabel

        likeButton.setTitle("Like", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        contentView.addSubview(captionLabel)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(likeButton)
    }

    private func setupLayout() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Caption
            captionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Like count
            likeCountLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 12),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            // Like button
            likeButton.centerYAnchor.constraint(equalTo: likeCountLabel.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 12)
        ])
    }

    func configure(postID: Int) {
        self.postID = postID

        guard let post = postDataController.getPostByID(postID: postID) else {
            captionLabel.text = "Post not found"
            likeCountLabel.text = "0 likes"
            return
        }

        captionLabel.text = post.postCaption

        let likeCount = post.postLikesArray?.count ?? 0
        likeCountLabel.text = "\(likeCount) likes"
    }

    @objc private func likeTapped() {
        print("like")
    }
}
*/
//SIMPLE 1
/*
class PostCell: UITableViewCell {

    let postIDLabel = Elements.postIDLabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(postIDLabel)

        NSLayoutConstraint.activate([
            postIDLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postIDLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(postID: Int) {
        print("configure: PostCell")
        postIDLabel.text = "Post ID: \(postID)"
    }
}
*/






//WORKING
//HOME FEED: Kite
