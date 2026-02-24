//
//  CommentCellLayout.swift
//  Kite
//
//  Created by David Vasquez on 1/20/26.
//

import UIKit



final class CommentCellLayout: UIView {

    //LOGIC
    //CHAT: no PostDataController / IDs here (layout is UI-only)

    //UI COMPONENTS
    //Layout: Main Containers
    private let mainUserImageView = UIView()
    private let mainCommentView = UIView()

    private let userNameView = UIView()
    private let contentViewContainer = UIView()
    private let socialsView = UIView()

    //Layout: UI Elements
    let profileImageView = UIImageView()
    let commentLabel = UILabel()
    let usernameLabel = UILabel()
    let timeLabel = UILabel()
    let menuButton = UIButton(type: .system)

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUserImageArea()
        setupCommentArea()
        setupUsernameArea()
        setupContentArea()
        setupSocialsArea()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //CHAT: If you ever use storyboard/xib, you’d call the setup methods here too.
        //CHAT: /**/
    }

    //LAYOUT

    //MAIN CONTAINERS
    private func setupUserImageArea() {
        mainUserImageView.translatesAutoresizingMaskIntoConstraints = false
        mainUserImageView.backgroundColor = .clear

        addSubview(mainUserImageView)

        // Setup profile image view
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 24 // Half of 52 for circular image
        profileImageView.image = UIImage(named: "background_1")

        mainUserImageView.addSubview(profileImageView)

        NSLayoutConstraint.activate([
            mainUserImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainUserImageView.topAnchor.constraint(equalTo: topAnchor),
            mainUserImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainUserImageView.widthAnchor.constraint(equalToConstant: 68),

            // Profile image: 48x48, 4px from top, centered horizontally
            profileImageView.topAnchor.constraint(equalTo: mainUserImageView.topAnchor, constant: 4),
            profileImageView.centerXAnchor.constraint(equalTo: mainUserImageView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupCommentArea() {
        mainCommentView.translatesAutoresizingMaskIntoConstraints = false
        mainCommentView.backgroundColor = .clear

        addSubview(mainCommentView)

        NSLayoutConstraint.activate([
            mainCommentView.leadingAnchor.constraint(equalTo: mainUserImageView.trailingAnchor),
            mainCommentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCommentView.topAnchor.constraint(equalTo: topAnchor),
            mainCommentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //SUB VIEWS
    //Header: Contains Username, Time, and Menu
    private func setupUsernameArea() {
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.backgroundColor = .clear

        mainCommentView.addSubview(userNameView)

        // Setup horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Setup username label
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = Style.usernameFont
        usernameLabel.textColor = Style.usernameFontColor
        usernameLabel.textAlignment = .left
        usernameLabel.text = "Username"
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        // Lower priority - can expand/compress to make room for time and menu
        usernameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        usernameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // Setup time label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = Style.timeFont
        timeLabel.textColor = Style.timeFontColor
        timeLabel.textAlignment = .left
        timeLabel.text = "2h"
        timeLabel.numberOfLines = 1
        // High priority - always stays small (max 3 chars), don't compress
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        // Setup menu button
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-dots-gray"), for: .normal)
        menuButton.tintColor = .systemGray
        menuButton.backgroundColor = .systemRed.withAlphaComponent(0.3) // Temporary color for visibility
        // High priority - always keep its width, don't compress
        menuButton.setContentHuggingPriority(.required, for: .horizontal)
        menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        // Create spacer view to push menu to the right
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // Add labels, spacer, and button to stack view
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(menuButton)

        // Set custom spacing: small gap between username and time (4px = ~1-2 spaces)
        stackView.setCustomSpacing(4, after: usernameLabel)
        // Spacer will automatically expand to fill space between time and menu

        userNameView.addSubview(stackView)

        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: mainCommentView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 28),

            // Stack view: full width with padding
            stackView.topAnchor.constraint(equalTo: userNameView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),

            // Username label: min width only (max width handled by content priorities)
            usernameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            // Time label: min/max width to prevent overflow (max 3 chars)
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            timeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40),

            // Menu button: 40px area width, height matches identityView (28px)
            menuButton.widthAnchor.constraint(equalToConstant: 40),
            menuButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    //Body: Contains the comment caption
    private func setupContentArea() {
        contentViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentViewContainer.backgroundColor = .clear

        mainCommentView.addSubview(contentViewContainer)

        // Setup comment label
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.font = Style.mainTextFont
        commentLabel.textColor = Style.mainTextFontColor
        commentLabel.numberOfLines = 0
        commentLabel.text = "This is a sample comment text that will be replaced with actual comment data."

        contentViewContainer.addSubview(commentLabel)

        NSLayoutConstraint.activate([
            contentViewContainer.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            contentViewContainer.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            contentViewContainer.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            contentViewContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 12), // Minimum height

            // Comment label: 8px padding on all sides
            commentLabel.topAnchor.constraint(equalTo: contentViewContainer.topAnchor, constant: 0),
            commentLabel.leadingAnchor.constraint(equalTo: contentViewContainer.leadingAnchor, constant: 0),
            commentLabel.trailingAnchor.constraint(equalTo: contentViewContainer.trailingAnchor, constant: -4),
            commentLabel.bottomAnchor.constraint(equalTo: contentViewContainer.bottomAnchor, constant: 2)
        ])
    }

    //Footer: Contains the Like Button and Count
    private func setupSocialsArea() {
        socialsView.translatesAutoresizingMaskIntoConstraints = false
        socialsView.backgroundColor = .systemPink

        mainCommentView.addSubview(socialsView)

        NSLayoutConstraint.activate([
            socialsView.topAnchor.constraint(equalTo: contentViewContainer.bottomAnchor),
            socialsView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            socialsView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            socialsView.heightAnchor.constraint(equalToConstant: 24),
            socialsView.bottomAnchor.constraint(equalTo: mainCommentView.bottomAnchor)
        ])
    }

    //ACTIONS

    //FUNCTIONS
}

/*
final class CommentCellLayout: UIView {

    //UI COMPONENTS
    //Layout: Main Containers
    let mainUserImageView = UIView()
    let mainCommentView = UIView()

    let userNameView = UIView()
    let contentViewContainer = UIView()
    let socialsView = UIView()

    //Layout: UI Elements
    let profileImageView = UIImageView()
    let commentLabel = UILabel()
    let usernameLabel = UILabel()
    let timeLabel = UILabel()
    let menuButton = UIButton(type: .system)

    //LOGIC

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserImageArea()
        setupCommentArea()
        setupUsernameArea()
        setupContentArea()
        setupSocialsArea()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //LAYOUT
    //MAIN CONTAINERS
    private func setupUserImageArea() {
        mainUserImageView.translatesAutoresizingMaskIntoConstraints = false
        mainUserImageView.backgroundColor = .clear

        addSubview(mainUserImageView)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 24
        profileImageView.image = UIImage(named: "background_1")

        mainUserImageView.addSubview(profileImageView)

        NSLayoutConstraint.activate([
            mainUserImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainUserImageView.topAnchor.constraint(equalTo: topAnchor),
            mainUserImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainUserImageView.widthAnchor.constraint(equalToConstant: 68),

            profileImageView.topAnchor.constraint(equalTo: mainUserImageView.topAnchor, constant: 4),
            profileImageView.centerXAnchor.constraint(equalTo: mainUserImageView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupCommentArea() {
        mainCommentView.translatesAutoresizingMaskIntoConstraints = false
        mainCommentView.backgroundColor = .clear

        addSubview(mainCommentView)

        NSLayoutConstraint.activate([
            mainCommentView.leadingAnchor.constraint(equalTo: mainUserImageView.trailingAnchor),
            mainCommentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCommentView.topAnchor.constraint(equalTo: topAnchor),
            mainCommentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //SUB VIEWS
    private func setupUsernameArea() {
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.backgroundColor = .clear
        mainCommentView.addSubview(userNameView)

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = Style.usernameFont
        usernameLabel.textColor = Style.usernameFontColor
        usernameLabel.textAlignment = .left
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        usernameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = Style.timeFont
        timeLabel.textColor = Style.timeFontColor
        timeLabel.textAlignment = .left
        timeLabel.numberOfLines = 1
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-dots-gray"), for: .normal)
        menuButton.tintColor = .systemGray
        menuButton.backgroundColor = .systemRed.withAlphaComponent(0.3)
        menuButton.setContentHuggingPriority(.required, for: .horizontal)
        menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(menuButton)
        stackView.setCustomSpacing(4, after: usernameLabel)

        userNameView.addSubview(stackView)

        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: mainCommentView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 28),

            stackView.topAnchor.constraint(equalTo: userNameView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),

            usernameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            timeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40),

            menuButton.widthAnchor.constraint(equalToConstant: 40),
            menuButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupContentArea() {
        contentViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentViewContainer.backgroundColor = .clear
        mainCommentView.addSubview(contentViewContainer)

        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.font = Style.mainTextFont
        commentLabel.textColor = Style.mainTextFontColor
        commentLabel.numberOfLines = 0

        contentViewContainer.addSubview(commentLabel)

        NSLayoutConstraint.activate([
            contentViewContainer.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            contentViewContainer.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            contentViewContainer.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            contentViewContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 12),

            commentLabel.topAnchor.constraint(equalTo: contentViewContainer.topAnchor, constant: 0),
            commentLabel.leadingAnchor.constraint(equalTo: contentViewContainer.leadingAnchor, constant: 0),
            commentLabel.trailingAnchor.constraint(equalTo: contentViewContainer.trailingAnchor, constant: -4),
            commentLabel.bottomAnchor.constraint(equalTo: contentViewContainer.bottomAnchor, constant: 2)
        ])
    }

    private func setupSocialsArea() {
        socialsView.translatesAutoresizingMaskIntoConstraints = false
        socialsView.backgroundColor = .systemPink
        mainCommentView.addSubview(socialsView)

        NSLayoutConstraint.activate([
            socialsView.topAnchor.constraint(equalTo: contentViewContainer.bottomAnchor),
            socialsView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            socialsView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            socialsView.heightAnchor.constraint(equalToConstant: 24),
            socialsView.bottomAnchor.constraint(equalTo: mainCommentView.bottomAnchor)
        ])
    }

    //ACTIONS

    //FUNCTIONS
    func apply(usernameText: String, timeText: String, commentText: String) {
        usernameLabel.text = usernameText
        timeLabel.text = timeText
        commentLabel.text = commentText
    }
}

*/
/*
final class CommentCellLayout: UIView {

    //UI COMPONENTS
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let timeLabel = UILabel()
    let menuButton = UIButton(type: .system)
    let commentLabel = UILabel()

    
    //LOGIC
    private let mainUserImageView = UIView()
    private let mainCommentView = UIView()
    private let userNameView = UIView()
    private let contentViewContainer = UIView()
    private let socialsView = UIView()
    private let stackView = UIStackView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT
    private func setupViews() {
        // Profile image
        profileImageView.backgroundColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 24
        profileImageView.image = UIImage(named: "background_1")
        
        // Username label
        usernameLabel.font = Style.usernameFont
        usernameLabel.textColor = Style.usernameFontColor
        usernameLabel.textAlignment = .left
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        usernameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Time label
        timeLabel.font = Style.timeFont
        timeLabel.textColor = Style.timeFontColor
        timeLabel.textAlignment = .left
        timeLabel.numberOfLines = 1
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Menu button
        menuButton.setImage(UIImage(named: "menu-dots-gray"), for: .normal)
        menuButton.tintColor = .systemGray
        menuButton.setContentHuggingPriority(.required, for: .horizontal)
        menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Comment label
        commentLabel.font = Style.mainTextFont
        commentLabel.textColor = Style.mainTextFontColor
        commentLabel.numberOfLines = 0
        
        // Add container views
        mainUserImageView.backgroundColor = .clear
        mainCommentView.backgroundColor = .clear
        userNameView.backgroundColor = .clear
        contentViewContainer.backgroundColor = .clear
        socialsView.backgroundColor = .systemPink
        
        addSubview(mainUserImageView)
        addSubview(mainCommentView)
        mainCommentView.addSubview(userNameView)
        mainCommentView.addSubview(contentViewContainer)
        mainCommentView.addSubview(socialsView)
        mainUserImageView.addSubview(profileImageView)
        
        // Setup username area with stack view
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(menuButton)
        stackView.setCustomSpacing(4, after: usernameLabel)
        
        userNameView.addSubview(stackView)
        contentViewContainer.addSubview(commentLabel)
    }

    private func setupLayout() {
        mainUserImageView.translatesAutoresizingMaskIntoConstraints = false
        mainCommentView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        contentViewContainer.translatesAutoresizingMaskIntoConstraints = false
        socialsView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Main containers
            mainUserImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainUserImageView.topAnchor.constraint(equalTo: topAnchor),
            mainUserImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainUserImageView.widthAnchor.constraint(equalToConstant: 68),
            
            mainCommentView.leadingAnchor.constraint(equalTo: mainUserImageView.trailingAnchor),
            mainCommentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCommentView.topAnchor.constraint(equalTo: topAnchor),
            mainCommentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Profile image
            profileImageView.topAnchor.constraint(equalTo: mainUserImageView.topAnchor, constant: 4),
            profileImageView.centerXAnchor.constraint(equalTo: mainUserImageView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            
            // Username area
            userNameView.topAnchor.constraint(equalTo: mainCommentView.topAnchor),
            userNameView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 28),
            
            // Stack view inside userNameView
            stackView.topAnchor.constraint(equalTo: userNameView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor),
            
            usernameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            timeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            timeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            menuButton.widthAnchor.constraint(equalToConstant: 40),
            menuButton.heightAnchor.constraint(equalToConstant: 28),
            
            // Content area
            contentViewContainer.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            contentViewContainer.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            contentViewContainer.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            contentViewContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 12),
            
            commentLabel.topAnchor.constraint(equalTo: contentViewContainer.topAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: contentViewContainer.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: contentViewContainer.trailingAnchor, constant: -4),
            commentLabel.bottomAnchor.constraint(equalTo: contentViewContainer.bottomAnchor, constant: 2),
            
            // Socials area
            socialsView.topAnchor.constraint(equalTo: contentViewContainer.bottomAnchor),
            socialsView.leadingAnchor.constraint(equalTo: mainCommentView.leadingAnchor),
            socialsView.trailingAnchor.constraint(equalTo: mainCommentView.trailingAnchor),
            socialsView.heightAnchor.constraint(equalToConstant: 24),
            socialsView.bottomAnchor.constraint(equalTo: mainCommentView.bottomAnchor)
        ])
    }

    //ACTIONS
    
    //FUNCTIONS
    func apply(username: String, time: String, commentCaption: String, profileImage: UIImage?) {
        usernameLabel.text = username
        timeLabel.text = time
        commentLabel.text = commentCaption
        
        if let profileImage = profileImage {
            profileImageView.image = profileImage
        } else {
            profileImageView.image = UIImage(named: "background_1")
        }
    }
}
*/
