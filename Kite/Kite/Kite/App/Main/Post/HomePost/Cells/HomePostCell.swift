//
//  HomePostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/26/25.
//

import UIKit


class HomePostCell: UITableViewCell {
    

    //MAIN VIEWS
    let postHeaderView = CreateViewStyles.createUIView(backgroundColor: .systemPink)
    let postImageView = CreateViewStyles.createUIView(backgroundColor: .white)
    let postCaptionView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postSocialsView = CreateViewStyles.createUIView(backgroundColor: .systemPurple)
    let postSocialLikesView = CreateViewStyles.createUIView(backgroundColor: .systemRed)
    let postSocialLikesIcon = UIImageView()
    let postSocialLikesCount = UILabel()
    let postSocialCommentsView = CreateViewStyles.createUIView(backgroundColor: .systemBlue)
    let postSocialFillView = CreateViewStyles.createUIView(backgroundColor: .systemGreen)
    let postSocialBookMarkView = CreateViewStyles.createUIView(backgroundColor: .systemOrange)
    let postDividerView = CreateViewStyles.createUIView(backgroundColor: .lightGray)
    
    // Add height constraint for dynamic sizing
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    
    //CHILD VIEWS
    //Post Image
    let postImageUIView = createPostImage()
    
    //Post Caption
    let postCaptionUserImageView = CreateViewStyles.createUIView(backgroundColor: .systemYellow)
    let postCaptionUserImage = UIImageView()
    
    let postCaptionUserNameView = CreateViewStyles.createUIView(backgroundColor: .blue)
    let postCaptionUsernameLabel = UILabel()
    
    let postCaptionTextView = CreateViewStyles.createUIView(backgroundColor: .clear)
    let postCaptionLabel = CreateViewStyles.createPostStyleCaptionText()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeaderViews()
        setupImageViews()
        setupCaptionViews()
        setupSocialsViews()
        setupDividerViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderViews() {
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postHeaderView)

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

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
    
    private func setupCaptionViews() {
        
        //MAIN CONTAINER
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
     
        //Image
        postCaptionUserImageView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionUserImage.translatesAutoresizingMaskIntoConstraints = false
        
        //Username
        postCaptionUserNameView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        postCaptionUsernameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        postCaptionUsernameLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // Light gray like Instagram
        postCaptionUsernameLabel.backgroundColor = .clear
        
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
            postCaptionUsernameLabel.topAnchor.constraint(equalTo: postCaptionUserNameView.topAnchor, constant: 0),
            postCaptionUsernameLabel.leadingAnchor.constraint(equalTo: postCaptionUserNameView.leadingAnchor, constant: 4),
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

    private func setupSocialsViews() {
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesView.translatesAutoresizingMaskIntoConstraints = false
        postSocialCommentsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialFillView.translatesAutoresizingMaskIntoConstraints = false
        postSocialBookMarkView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup likes icon and count
        postSocialLikesIcon.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesIcon.image = UIImage(named: "like")
        postSocialLikesIcon.contentMode = .scaleAspectFit
        
        postSocialLikesCount.translatesAutoresizingMaskIntoConstraints = false
        postSocialLikesCount.text = formatLikeCount(20000)
        postSocialLikesCount.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        postSocialLikesCount.textColor = .black
        postSocialLikesCount.backgroundColor = .clear
        postSocialLikesCount.textAlignment = .left
        
        contentView.addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialLikesView)
        postSocialLikesView.addSubview(postSocialLikesIcon)
        postSocialLikesView.addSubview(postSocialLikesCount)
        postSocialsView.addSubview(postSocialCommentsView)
        postSocialsView.addSubview(postSocialFillView)
        postSocialsView.addSubview(postSocialBookMarkView)

        NSLayoutConstraint.activate([
            postSocialsView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor),
            postSocialsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocialsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postSocialsView.heightAnchor.constraint(equalToConstant: 32),
            
            // Left: Likes view (60 wide, centered left)
            postSocialLikesView.leadingAnchor.constraint(equalTo: postSocialsView.leadingAnchor, constant: 10),
            postSocialLikesView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialLikesView.widthAnchor.constraint(equalToConstant: 60),
            postSocialLikesView.heightAnchor.constraint(equalToConstant: 30),
            
            // Likes icon (20x20, left side)
            postSocialLikesIcon.leadingAnchor.constraint(equalTo: postSocialLikesView.leadingAnchor, constant: 4),
            postSocialLikesIcon.centerYAnchor.constraint(equalTo: postSocialLikesView.centerYAnchor),
            postSocialLikesIcon.widthAnchor.constraint(equalToConstant: 20),
            postSocialLikesIcon.heightAnchor.constraint(equalToConstant: 20),
            
            // Likes count (right of icon, fixed width)
            postSocialLikesCount.leadingAnchor.constraint(equalTo: postSocialLikesIcon.trailingAnchor, constant: 4),
            postSocialLikesCount.centerYAnchor.constraint(equalTo: postSocialLikesView.centerYAnchor),
            postSocialLikesCount.widthAnchor.constraint(equalToConstant: 32),
            
            // Left: Comments view (60 wide, next to likes)
            postSocialCommentsView.leadingAnchor.constraint(equalTo: postSocialLikesView.trailingAnchor, constant: 8),
            postSocialCommentsView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialCommentsView.widthAnchor.constraint(equalToConstant: 60),
            postSocialCommentsView.heightAnchor.constraint(equalToConstant: 30),
            
            // Right: Bookmark view (60 wide, centered right)
            postSocialBookMarkView.trailingAnchor.constraint(equalTo: postSocialsView.trailingAnchor, constant: -10),
            postSocialBookMarkView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialBookMarkView.widthAnchor.constraint(equalToConstant: 60),
            postSocialBookMarkView.heightAnchor.constraint(equalToConstant: 30),
            
            // Middle: Fill view (fills space between comments and bookmark)
            postSocialFillView.leadingAnchor.constraint(equalTo: postSocialCommentsView.trailingAnchor, constant: 8),
            postSocialFillView.trailingAnchor.constraint(equalTo: postSocialBookMarkView.leadingAnchor, constant: -8),
            postSocialFillView.centerYAnchor.constraint(equalTo: postSocialsView.centerYAnchor),
            postSocialFillView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    

    private func setupDividerViews() {
        postDividerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postDividerView)

        NSLayoutConstraint.activate([
            postDividerView.topAnchor.constraint(equalTo: postSocialsView.bottomAnchor),
            postDividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postDividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postDividerView.heightAnchor.constraint(equalToConstant: 2),
            postDividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func updatePost(with post: Post) {
        
        //STEP 1: Get Post Information
        let postID = post.postID
        let groupID = post.groupID ?? 0
        
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = post.postCaption ?? "no caption"
        
        print("Post ID \(postID) Group ID \(groupID)")
        
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
       
        // Force layout update
        layoutIfNeeded()
    }
    
    // Helper function to format like counts
    private func formatLikeCount(_ count: Int) -> String {
        if count >= 1000000 {
            return String(format: "%.1fM", Double(count) / 1000000.0)
        } else if count >= 1000 {
            return String(format: "%.1fK", Double(count) / 1000.0)
        } else {
            return "\(count)"
        }
    }
}



/*
//Home Feed Post Cell
class HomePostCell: UITableViewCell {
    
    //POST HEADER: Post Information
    //POST BODY: Post Image and Caption
    //POST FOOTER: Post Socials
    
    
    let postHeaderView = PostHeaderLayout()
    let bodyView = CreateViewStyles.createBodyView()
    let footerView = CreateViewStyles.createFooterView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTemporaryViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePost(with post: Post) {
        postHeaderView.configure(with: post)
    }

    private func setupTemporaryViews() {
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(postHeaderView)
        contentView.addSubview(bodyView)
        contentView.addSubview(footerView)

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 52),

            bodyView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 200),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),

            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

*/




/*
//Home Feed Post Cell
class PostCell: UITableViewCell {
    let headerView = CreateViewStyles.createHeaderView()
    let bodyView = CreateViewStyles.createBodyView()
    let footerView = CreateViewStyles.createFooterView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTemporaryViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //CELL SETUP
    func updatePost(with post: Post) {
        let postCaption = post.postCaption ?? "no caption"
        print(postCaption)
        /*
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
         */
    }

    private func setupTemporaryViews() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(headerView)
        contentView.addSubview(bodyView)
        contentView.addSubview(footerView)

        NSLayoutConstraint.activate([
            // Header - 200
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),

            // Body - 400
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 200),

            // Footer - 200
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),

            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        //MENU
        headerView.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            menuButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        setupMenu()
         

    }
    
    //MENU
    private func setupMenu() {
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
            print("Edit tapped")
        }

        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            print("Delete tapped")
        }

        let menu = UIMenu(title: "", children: [editAction, deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true // Show menu on tap (not long-press)
    }

    
    //UI ELEMENTS
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu-horizontal")
        button.setImage(image, for: .normal)
        button.tintColor = .black // Optional: Adjust based on your UI
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

}

*/

/*
class HomePostCell: UITableViewCell {
    
    //Post User
    let postUserView = createPostUserView()
    let postFromLabel = createPostUserName()
    
    //Post Image
    let postImageView = createPostImageView()
    let postImage = createPostImage()
    
    //Post Socials
    let postSocialsView = createPostSocialsView()
    let postSocialsLabel = createPostSocialsText()
    
    //Post Caption
    let postCaptionView = createPostCaptionView()
    let postCaptionLabel = createPostCaptionText()
    
    //Post Divider
    let postDividerView = createPostDividerView()
    
    //Heights for Dynamic Content
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        //POST: User View
        postUserView.translatesAutoresizingMaskIntoConstraints = false
        postFromLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postUserView)
        postUserView.addSubview(postFromLabel)
        
        //POST: Post Image
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postImageView)
        postImageView.addSubview(postImage)
        
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true
        
        //POST: Post Socials
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialsLabel)
        
        //POST: Post Caption
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionLabel)
        
        postCaptionHeightConstraint = postCaptionView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        //POST: Divider
        postDividerView.translatesAutoresizingMaskIntoConstraints = false
   
        addSubview(postDividerView)
        
        NSLayoutConstraint.activate([
            
            //Post User View
            postUserView.topAnchor.constraint(equalTo: topAnchor),
            postUserView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postUserView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postUserView.heightAnchor.constraint(equalToConstant: 40),
   
            postFromLabel.topAnchor.constraint(equalTo: postUserView.topAnchor, constant: 0),
            postFromLabel.leftAnchor.constraint(equalTo: postUserView.leftAnchor, constant: 0),
            postFromLabel.rightAnchor.constraint(equalTo: postUserView.rightAnchor, constant: -0),
            postFromLabel.bottomAnchor.constraint(equalTo: postUserView.bottomAnchor, constant: -0),
            
            //Post Image View
            postImageView.topAnchor.constraint(equalTo: postUserView.bottomAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImage.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            postImage.leftAnchor.constraint(equalTo: postImageView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: postImageView.rightAnchor, constant: -0),
            postImage.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -0),
            
            //Post Socials View
            postSocialsView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 0),
            postSocialsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postSocialsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postSocialsView.heightAnchor.constraint(equalToConstant: 40),
           
            postSocialsLabel.topAnchor.constraint(equalTo: postSocialsView.topAnchor, constant: 0),
            postSocialsLabel.leftAnchor.constraint(equalTo: postSocialsView.leftAnchor, constant: 0),
            postSocialsLabel.rightAnchor.constraint(equalTo: postSocialsView.rightAnchor, constant: -0),
            postSocialsLabel.bottomAnchor.constraint(equalTo: postSocialsView.bottomAnchor, constant: -0),
            
            //Post Caption View
            postCaptionView.topAnchor.constraint(equalTo: postSocialsLabel.bottomAnchor, constant: 0),
            postCaptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postCaptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionView.topAnchor, constant: 0),
            postCaptionLabel.leftAnchor.constraint(equalTo: postCaptionView.leftAnchor, constant: 0),
            postCaptionLabel.rightAnchor.constraint(equalTo: postCaptionView.rightAnchor, constant: -0),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: -0),
            
            //Post Divider View
            postDividerView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: 0),
            postDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postDividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postDividerView.heightAnchor.constraint(equalToConstant: 5),
            
            //Chat Maybe
            //postDividerView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
        
    }
    
    //CELL SETUP
    func updatePost(with post: Post) {
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




//POST: Post User
func createPostUserView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemRed
    
    return view

}

func createPostUserName() -> UILabel {
    let label = UILabel()
    label.text = "Garden Party"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .white
    
    return label
}


//POST: Post Image
func createInstagramStyleCaptionText() -> UILabel {
    let label = UILabel()
    label.text = ""
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0) // Instagram-like gray
    label.backgroundColor = .clear
    
    return label
}

func createPostImageView() -> UIView {
    let view = UIView()
    view.backgroundColor = .lightGray
    
    return view

}

func createPostImage() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}

//POST: Post Socials
func createPostSocialsView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

}

func createPostSocialsText() -> UILabel {
    let label = UILabel()
    label.text = "SOCIALS: Post User"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .blue
    
    return label
}

//POST: Post Caption
func createPostCaptionView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

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

//POST: Post Divider
func createPostDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemRed
    
    return view
}


func createHeaderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
}

func createBodyView() -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
}

func createFooterView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view
}
 
 */










