//
//  PostCaptionTemplate.swift
//  Kite
//
//  Created by David Vasquez on 2/1/26.
//

import UIKit


final class PostCaptionTemplate: UIView {

    //UI COMPONENTS
    let postCaptionLeftArea = UIImageView() //80 wide
    let postCaptionMiddleArea = UIImageView() //Fill middle 
    let postCaptionRightArea = UIImageView() //26 wide
  
    //Left Components
    let profileImageView = UIImageView()
    
    //Middle Components
    let userInfoArea = UIView()
    let postFromLabel = UILabel()
    let timeMessageLabel = UILabel()
    let userCaptionArea = UIView()
    let userCaptionLabel = UILabel()

    //Right Components
    let menuIconView = UIImageView()

    //LOGIC
    private let postDataController = PostDataController.shared
    private var postID: Int?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeftViews()
        setupRightViews()
        setupMiddleViews()

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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //LAYOUT — full width of parent; user image round, 12 from top, centered, 60×60
    //Left: User Image
    private func setupLeftViews() {
        postCaptionLeftArea.backgroundColor = .clear
        postCaptionLeftArea.contentMode = .scaleAspectFill
        postCaptionLeftArea.clipsToBounds = true

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 24
        profileImageView.backgroundColor = .clear

        addSubview(postCaptionLeftArea)
        postCaptionLeftArea.addSubview(profileImageView)
        postCaptionLeftArea.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postCaptionLeftArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            postCaptionLeftArea.topAnchor.constraint(equalTo: topAnchor),
            postCaptionLeftArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            postCaptionLeftArea.widthAnchor.constraint(equalToConstant: 64),
            postCaptionLeftArea.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),

            profileImageView.topAnchor.constraint(equalTo: postCaptionLeftArea.topAnchor, constant: 8),
            profileImageView.centerXAnchor.constraint(equalTo: postCaptionLeftArea.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    //Middle: userInfoArea on top (22pt) — postFrom 0 from left, timeMessage 8pt after; userCaptionArea expands below
    private func setupMiddleViews() {
        postCaptionMiddleArea.backgroundColor = .clear
        postCaptionMiddleArea.contentMode = .scaleAspectFit

        userInfoArea.backgroundColor = .clear
        userCaptionArea.backgroundColor = .clear

        Style.styleUsernameText(postFromLabel)
        postFromLabel.text = "Username"
        Style.styleTimeText(timeMessageLabel)
        timeMessageLabel.text = "now"

        userCaptionLabel.numberOfLines = 0
        userCaptionLabel.text = "Caption text"
        userCaptionLabel.font = .systemFont(ofSize: 15)

        addSubview(postCaptionMiddleArea)
        postCaptionMiddleArea.addSubview(userInfoArea)
        userInfoArea.addSubview(postFromLabel)
        userInfoArea.addSubview(timeMessageLabel)
        postCaptionMiddleArea.addSubview(userCaptionArea)
        userCaptionArea.addSubview(userCaptionLabel)

        postCaptionMiddleArea.translatesAutoresizingMaskIntoConstraints = false
        userInfoArea.translatesAutoresizingMaskIntoConstraints = false
        postFromLabel.translatesAutoresizingMaskIntoConstraints = false
        timeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        userCaptionArea.translatesAutoresizingMaskIntoConstraints = false
        userCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postCaptionMiddleArea.leadingAnchor.constraint(equalTo: postCaptionLeftArea.trailingAnchor),
            postCaptionMiddleArea.trailingAnchor.constraint(equalTo: postCaptionRightArea.leadingAnchor),
            postCaptionMiddleArea.topAnchor.constraint(equalTo: topAnchor),
            postCaptionMiddleArea.bottomAnchor.constraint(equalTo: bottomAnchor),

            userInfoArea.topAnchor.constraint(equalTo: postCaptionMiddleArea.topAnchor),
            userInfoArea.leadingAnchor.constraint(equalTo: postCaptionMiddleArea.leadingAnchor),
            userInfoArea.trailingAnchor.constraint(equalTo: postCaptionMiddleArea.trailingAnchor),
            userInfoArea.heightAnchor.constraint(equalToConstant: 22),

            postFromLabel.leadingAnchor.constraint(equalTo: userInfoArea.leadingAnchor),
            postFromLabel.centerYAnchor.constraint(equalTo: userInfoArea.centerYAnchor),

            timeMessageLabel.leadingAnchor.constraint(equalTo: postFromLabel.trailingAnchor, constant: 8),
            timeMessageLabel.centerYAnchor.constraint(equalTo: userInfoArea.centerYAnchor),

            userCaptionArea.topAnchor.constraint(equalTo: userInfoArea.bottomAnchor),
            userCaptionArea.leadingAnchor.constraint(equalTo: postCaptionMiddleArea.leadingAnchor),
            userCaptionArea.trailingAnchor.constraint(equalTo: postCaptionMiddleArea.trailingAnchor),
            userCaptionArea.bottomAnchor.constraint(equalTo: postCaptionMiddleArea.bottomAnchor),

            userCaptionLabel.topAnchor.constraint(equalTo: userCaptionArea.topAnchor),
            userCaptionLabel.leadingAnchor.constraint(equalTo: userCaptionArea.leadingAnchor),
            userCaptionLabel.trailingAnchor.constraint(equalTo: userCaptionArea.trailingAnchor)
        ])
        userCaptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        userCaptionArea.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    //Right: Menu for edit
    private func setupRightViews() {
        postCaptionRightArea.backgroundColor = .clear
        postCaptionRightArea.contentMode = .scaleAspectFit

        menuIconView.image = UIImage(named: "menu-horizontal")
        menuIconView.contentMode = .scaleAspectFit
        menuIconView.tintColor = .label

        addSubview(postCaptionRightArea)
        postCaptionRightArea.addSubview(menuIconView)
        postCaptionRightArea.translatesAutoresizingMaskIntoConstraints = false
        menuIconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postCaptionRightArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            postCaptionRightArea.topAnchor.constraint(equalTo: topAnchor),
            postCaptionRightArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            postCaptionRightArea.widthAnchor.constraint(equalToConstant: 26),

            menuIconView.centerXAnchor.constraint(equalTo: postCaptionRightArea.centerXAnchor),
            menuIconView.topAnchor.constraint(equalTo: postCaptionRightArea.topAnchor, constant: 4),
            menuIconView.widthAnchor.constraint(equalToConstant: 20),
            menuIconView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    //ACTIONS
    @objc private func handlePostUpdated(_ notification: Notification) {
        guard let updatedPostID = notification.object as? Int,
              updatedPostID == postID else { return }
        refreshUI()
    }

    //FUNCTIONS — two apply methods: full post or postID (fetches then applies)
    func apply(postID: Int) {
        self.postID = postID
        refreshUI()
    }

    func apply(post: Post) {
        self.postID = post.postID
        profileImageView.image = post.postFromImageData ?? UIImage(named: "background_1")
        postFromLabel.text = post.postFrom ?? "Username"
        timeMessageLabel.text = post.timeMessage ?? "now"
        userCaptionLabel.text = post.postCaption?.isEmpty == false ? post.postCaption : nil
    }

    func setPlaceholder() {
        postFromLabel.text = "Username"
        timeMessageLabel.text = "now"
        userCaptionLabel.text = "Post caption goes here. Default text for reusable PostCaptionTemplate."
    }

    private func refreshUI() {
        guard let postID,
              let post = postDataController.getPostByID(postID: postID) else { return }
        apply(post: post)
    }
}
