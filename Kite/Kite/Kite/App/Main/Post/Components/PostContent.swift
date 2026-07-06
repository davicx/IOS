//
//  PostContent.swift
//  Kite
//
//  Created by David Vasquez on 2/23/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class PostContent: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?

    //UI COMPONENTS
    //MAIN
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    //Left View: User Image
    let leftView = UIView()
    let userProfileImageView = UIImageView()

    //Middle View: Event Info
    let middleView = UIView()
    let eventTitleLabel = UILabel()
    let eventDetailsLabel = UILabel()
    
    private let eventTitlePlaceholder = PlaceholderView(width: 120, height: 14)
    private let eventDetailsPlaceholder = PlaceholderView(width: 72, height: 12)
    
    //Right View: Menu
    let rightView = UIView()
    let menuImageView = UIImageView()

    //Body: Post Image
    let postImageView = UIImageView()
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageZeroHeightConstraint: NSLayoutConstraint?
    
    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupHeaderView()
        setupBodyView()
        setupFooterView()
    }

    //HEADER: Post Info
    private func setupHeaderView() {
        headerView.backgroundColor = Colors.screenBackground

        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 52)
        ])

        //Header Left View: User Image
        leftView.backgroundColor = .clear
        userProfileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 42)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(userProfileImageView)

        //Header Middle View: Event title and details
        middleView.backgroundColor = .clear

        eventTitleLabel.font = Fonts.postEventTitleFont
        eventTitleLabel.textColor = Colors.primaryText
        eventTitleLabel.numberOfLines = 1
        eventTitleLabel.lineBreakMode = .byTruncatingTail
        eventTitleLabel.text = "Garden Party!"

        eventDetailsLabel.font = Fonts.postEventDetailsFont
        eventDetailsLabel.textColor = Colors.postedAtText
        eventDetailsLabel.numberOfLines = 1
        eventDetailsLabel.lineBreakMode = .byTruncatingTail
        eventDetailsLabel.text = "12 Friends and 42 Posts"

        //Header Right View: Menu
        rightView.backgroundColor = .clear
        
        menuImageView.image = UIImage(named: "menu-horizontal")
        menuImageView.contentMode = .scaleAspectFit

        [leftView, middleView, rightView, eventTitleLabel, eventDetailsLabel, menuImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        headerView.addSubview(leftView)
        headerView.addSubview(middleView)
        headerView.addSubview(rightView)
        middleView.addSubview(eventTitleLabel)
        middleView.addSubview(eventDetailsLabel)
        middleView.addSubview(eventTitlePlaceholder)
        middleView.addSubview(eventDetailsPlaceholder)
        rightView.addSubview(menuImageView)

        NSLayoutConstraint.activate([
            
            //LEFT — profile image holder (58×52: 8 + 42pt image + 8)
            leftView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: headerView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            leftView.widthAnchor.constraint(equalToConstant: 58),

            // Profile image — 42pt circle (52 − 5 − 5), inset inside holder
            userProfileImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 8),
            userProfileImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
            userProfileImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            userProfileImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -5),

            //RIGHT — menu
            rightView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            rightView.widthAnchor.constraint(equalToConstant: 36),

            menuImageView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor, constant: -2),
            menuImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
            menuImageView.widthAnchor.constraint(equalToConstant: 22),
            menuImageView.heightAnchor.constraint(equalToConstant: 22),

            //MIDDLE — fills space between left and right, full header height
            middleView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            middleView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            middleView.topAnchor.constraint(equalTo: headerView.topAnchor),
            middleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            // Event title + details — vertically centered as a tight stack
            eventDetailsLabel.topAnchor.constraint(equalTo: middleView.centerYAnchor, constant: 1),
            eventDetailsLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            eventDetailsLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),

            eventTitleLabel.bottomAnchor.constraint(equalTo: eventDetailsLabel.topAnchor, constant: -2),
            eventTitleLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            eventTitleLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),

            eventTitlePlaceholder.leadingAnchor.constraint(equalTo: eventTitleLabel.leadingAnchor),
            eventTitlePlaceholder.centerYAnchor.constraint(equalTo: eventTitleLabel.centerYAnchor),

            eventDetailsPlaceholder.leadingAnchor.constraint(equalTo: eventDetailsLabel.leadingAnchor),
            eventDetailsPlaceholder.centerYAnchor.constraint(equalTo: eventDetailsLabel.centerYAnchor)
        ])
    }

    //BODY: Post Image — full width, height from image aspect ratio (no manual heightForRowAt math)
    private func setupBodyView() {
        bodyView.backgroundColor = .clear
        ImageStyle.postImage(imageView: postImageView)

        addSubview(bodyView)
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.addSubview(postImageView)

        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImageView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])

        updatePostImage(nil)
    }

    //FOOTER: Post Footer (Caption is its own component)
    private func setupFooterView() {
        footerView.backgroundColor = .clear

        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 0),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        updatePostImage(post.postImageData)
        showHeaderPlaceholders()

        guard let username = post.postFrom, !username.isEmpty else {
            print("PostContent: missing postFrom for postID \(post.postID)")
            revealHeaderContent()
            return
        }

        loadUserProfile(username: username)
        revealHeaderContent()
    }

    private func showHeaderPlaceholders() {
        eventTitleLabel.alpha = 0
        eventDetailsLabel.alpha = 0
        eventTitlePlaceholder.show()
        eventDetailsPlaceholder.show()
        middleView.bringSubviewToFront(eventTitlePlaceholder)
        middleView.bringSubviewToFront(eventDetailsPlaceholder)
    }

    private func revealHeaderContent() {
        eventTitlePlaceholder.hide(animated: true)
        eventDetailsPlaceholder.hide(animated: true)

        UIView.animate(withDuration: 0.25) {
            self.eventTitleLabel.alpha = 1
            self.eventDetailsLabel.alpha = 1
        }
    }

    private func updatePostImage(_ image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageZeroHeightConstraint?.isActive = false

        guard let image, image.size.width > 0 else {
            postImageView.image = nil
            imageZeroHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
            imageZeroHeightConstraint?.isActive = true
            return
        }

        postImageView.image = image
        let aspectRatio = image.size.height / image.size.width
        imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
            equalTo: postImageView.widthAnchor,
            multiplier: aspectRatio
        )
        imageAspectRatioConstraint?.isActive = true
    }

    private func loadUserProfile(username: String) {
        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                print("PostContent: failed to load user \(username)")
                return
            }

            guard loadUserName == username else { return }

            print("PostContent: userName=\(user.userName) userImage=\(user.userImage)")

            await MainActor.run {
                guard self.loadUserName == username else { return }
                if let image = user.profileImage {
                    self.userProfileImageView.image = image
                }
            }
        }
    }

}

/*
// BACKUP: PostContent before PlaceholderView demo (username / posted-at loading bars)

final class PostContent: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?

    //UI COMPONENTS
    //MAIN
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    //Left View: User Image
    let leftView = UIView()
    let userProfileImageView = UIImageView()

    //Middle View: User Name and Post Info
    let middleView = UIView()
    let userNameLabel = UILabel()
    let postedAtLabel = UILabel()
    
    //Right View: Menu
    let rightView = UIView()
    let menuImageView = UIImageView()

    //Body: Post Image
    let postImageView = UIImageView()
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageZeroHeightConstraint: NSLayoutConstraint?
    
    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupHeaderView()
        setupBodyView()
        setupFooterView()
    }

    //HEADER: Post Info
    private func setupHeaderView() {
        headerView.backgroundColor = Colors.screenBackground

        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 52)
        ])

        //Header Left View: User Image
        leftView.backgroundColor = .clear
        userProfileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 42)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(userProfileImageView)

        //Header Middle View: User Name and Post Info
        middleView.backgroundColor = .clear

        userNameLabel.font = Fonts.userName
        userNameLabel.textColor = Colors.primaryText
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail

        postedAtLabel.font = Fonts.postedAt
        postedAtLabel.textColor = Colors.postedAtText
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail

        //Header Right View: Menu
        rightView.backgroundColor = .clear
        
        menuImageView.image = UIImage(named: "menu-horizontal")
        menuImageView.contentMode = .scaleAspectFit

        [leftView, middleView, rightView, userNameLabel, postedAtLabel, menuImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        headerView.addSubview(leftView)
        headerView.addSubview(middleView)
        headerView.addSubview(rightView)
        middleView.addSubview(userNameLabel)
        middleView.addSubview(postedAtLabel)
        rightView.addSubview(menuImageView)

        NSLayoutConstraint.activate([
            
            //LEFT — profile image holder (58×52: 8 + 42pt image + 8)
            leftView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: headerView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            leftView.widthAnchor.constraint(equalToConstant: 58),

            // Profile image — 42pt circle (52 − 5 − 5), inset inside holder
            userProfileImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 8),
            userProfileImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
            userProfileImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            userProfileImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -5),

            //RIGHT — menu
            rightView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            rightView.widthAnchor.constraint(equalToConstant: 36),

            menuImageView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor, constant: -2),
            menuImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
            menuImageView.widthAnchor.constraint(equalToConstant: 22),
            menuImageView.heightAnchor.constraint(equalToConstant: 22),

            //MIDDLE — fills space between left and right, full header height
            middleView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            middleView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            middleView.topAnchor.constraint(equalTo: headerView.topAnchor),
            middleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            // Username + posted at — vertically centered as a tight stack (Instagram-style)
            postedAtLabel.topAnchor.constraint(equalTo: middleView.centerYAnchor, constant: 1),
            postedAtLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            postedAtLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),

            userNameLabel.bottomAnchor.constraint(equalTo: postedAtLabel.topAnchor, constant: -2),
            userNameLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        ])
    }

    //BODY: Post Image — full width, height from image aspect ratio (no manual heightForRowAt math)
    private func setupBodyView() {
        bodyView.backgroundColor = .clear
        ImageStyle.postImage(imageView: postImageView)

        addSubview(bodyView)
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.addSubview(postImageView)

        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImageView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])

        updatePostImage(nil)
    }

    //FOOTER: Post Footer (Caption is its own component)
    private func setupFooterView() {
        footerView.backgroundColor = .clear

        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 0),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postedAtLabel.text = post.timeMessage ?? ""
        updatePostImage(post.postImageData)

        guard let username = post.postFrom, !username.isEmpty else {
            userNameLabel.text = ""
            print("PostContent: missing postFrom for postID \(post.postID)")
            return
        }

        userNameLabel.text = username
        loadUserProfile(username: username)
    }

    private func updatePostImage(_ image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageZeroHeightConstraint?.isActive = false

        guard let image, image.size.width > 0 else {
            postImageView.image = nil
            imageZeroHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
            imageZeroHeightConstraint?.isActive = true
            return
        }

        postImageView.image = image
        let aspectRatio = image.size.height / image.size.width
        imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
            equalTo: postImageView.widthAnchor,
            multiplier: aspectRatio
        )
        imageAspectRatioConstraint?.isActive = true
    }

    private func loadUserProfile(username: String) {
        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                print("PostContent: failed to load user \(username)")
                return
            }

            guard loadUserName == username else { return }

            print("PostContent: userName=\(user.userName) userImage=\(user.userImage)")

            await MainActor.run {
                guard self.loadUserName == username else { return }
                self.userNameLabel.text = user.userName
                if let image = user.profileImage {
                    self.userProfileImageView.image = image
                }
            }
        }
    }

}
*/


/*
 //
 //  PostContent.swift
 //  Kite
 //
 //  Created by David Vasquez on 2/23/26.
 //

 import UIKit


 //LOGIC
 //UI COMPONENTS
 //MANAGE VIEWS
 //LAYOUT and UI
 //ACTIONS
 //FUNCTIONS


 final class PostContent: UIView {

     //LOGIC
     private var usersDataController: UsersDataController { UsersDataController.shared }
     private var loadUserName: String?

     //UI COMPONENTS
     //MAIN
     let headerView = UIView()
     let bodyView = UIView()
     let footerView = UIView()

     //Left View: User Image
     let leftView = UIView()
     let userProfileImageView = UIImageView()

     //Middle View: User Name and Post Info
     let middleView = UIView()
     let userNameLabel = UILabel()
     let postedAtLabel = UILabel()
     
     //Right View: Menu
     let rightView = UIView()
     let menuImageView = UIImageView()
     
     //MANAGE VIEWS
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         setupViews()

     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setupViews() {
         setupHeaderView()
         setupBodyView()
         setupFooterView()
     }

     //HEADER: Post Info
     private func setupHeaderView() {
         headerView.backgroundColor = Colors.screenBackground

         addSubview(headerView)
         headerView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             headerView.topAnchor.constraint(equalTo: topAnchor),
             headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
             headerView.heightAnchor.constraint(equalToConstant: 52)
         ])

         //Header Left View: User Image
         leftView.backgroundColor = .clear
         userProfileImageView.image = UIImage(named: "background_1")
         ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 42)
         userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
         leftView.addSubview(userProfileImageView)

         //Header Middle View: User Name and Post Info
         middleView.backgroundColor = .clear

         userNameLabel.font = Fonts.userName
         userNameLabel.textColor = Colors.primaryText
         userNameLabel.numberOfLines = 1
         userNameLabel.lineBreakMode = .byTruncatingTail

         postedAtLabel.font = Fonts.postedAt
         postedAtLabel.textColor = Colors.postedAtText
         postedAtLabel.numberOfLines = 1
         postedAtLabel.lineBreakMode = .byTruncatingTail

         //Header Right View: Menu
         rightView.backgroundColor = .clear
         
         menuImageView.image = UIImage(named: "menu-horizontal")
         menuImageView.contentMode = .scaleAspectFit

         [leftView, middleView, rightView, userNameLabel, postedAtLabel, menuImageView].forEach {
             $0.translatesAutoresizingMaskIntoConstraints = false
         }

         headerView.addSubview(leftView)
         headerView.addSubview(middleView)
         headerView.addSubview(rightView)
         middleView.addSubview(userNameLabel)
         middleView.addSubview(postedAtLabel)
         rightView.addSubview(menuImageView)

         NSLayoutConstraint.activate([
             
             //LEFT — profile image holder (58×52: 8 + 42pt image + 8)
             leftView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
             leftView.topAnchor.constraint(equalTo: headerView.topAnchor),
             leftView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
             leftView.widthAnchor.constraint(equalToConstant: 58),

             // Profile image — 42pt circle (52 − 5 − 5), inset inside holder
             userProfileImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 8),
             userProfileImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
             userProfileImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
             userProfileImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -5),

             //RIGHT — menu
             rightView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
             rightView.topAnchor.constraint(equalTo: headerView.topAnchor),
             rightView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
             rightView.widthAnchor.constraint(equalToConstant: 36),

             menuImageView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor, constant: -2),
             menuImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
             menuImageView.widthAnchor.constraint(equalToConstant: 22),
             menuImageView.heightAnchor.constraint(equalToConstant: 22),

             //MIDDLE — fills space between left and right, full header height
             middleView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
             middleView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
             middleView.topAnchor.constraint(equalTo: headerView.topAnchor),
             middleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

             // Username + posted at — vertically centered as a tight stack (Instagram-style)
             postedAtLabel.topAnchor.constraint(equalTo: middleView.centerYAnchor, constant: 1),
             postedAtLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
             postedAtLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),

             userNameLabel.bottomAnchor.constraint(equalTo: postedAtLabel.topAnchor, constant: -2),
             userNameLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
             userNameLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
         ])
     }

     //HEADER: Post Image
     private func setupBodyView() {
         bodyView.backgroundColor = .clear

         addSubview(bodyView)
         bodyView.translatesAutoresizingMaskIntoConstraints = false

         addPlaceholderLabel("Body", to: bodyView)

         NSLayoutConstraint.activate([
             bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
             bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
             bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
             bodyView.heightAnchor.constraint(equalToConstant: 100)
         ])
     }

     //HEADER: Post Footer (Caption is its own component)
     private func setupFooterView() {
         footerView.backgroundColor = .clear

         addSubview(footerView)
         footerView.translatesAutoresizingMaskIntoConstraints = false

         addPlaceholderLabel("Footer", to: footerView)

         NSLayoutConstraint.activate([
             footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
             footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
             footerView.heightAnchor.constraint(equalToConstant: 20),
             footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
     }

     //FUNCTIONS
     func configure(with post: Post) {
         postedAtLabel.text = post.timeMessage ?? ""

         guard let username = post.postFrom, !username.isEmpty else {
             userNameLabel.text = ""
             print("PostContent: missing postFrom for postID \(post.postID)")
             return
         }

         userNameLabel.text = username
         loadUserProfile(username: username)
     }

     private func loadUserProfile(username: String) {
         loadUserName = username

         Task {
             guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                 print("PostContent: failed to load user \(username)")
                 return
             }

             guard loadUserName == username else { return }

             print("PostContent: userName=\(user.userName) userImage=\(user.userImage)")

             await MainActor.run {
                 guard self.loadUserName == username else { return }
                 self.userNameLabel.text = user.userName
                 if let image = user.profileImage {
                     self.userProfileImageView.image = image
                 }
             }
         }
     }

     
     //TEMP
     private func addPlaceholderLabel(_ text: String, to view: UIView) {
         let label = UILabel()
         label.text = text
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.textColor = .label
         label.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(label)

         NSLayoutConstraint.activate([
             label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
     }

 }
 
 */
