//
//  ItemHeader.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemHeader: UIView {

    //LOGIC
    private var usersDataController: UsersDataController { UsersDataController.shared }
    private var loadUserName: String?
    private let avatarSize: CGFloat = 40

    //UI COMPONENTS
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postedAtLabel = UILabel()
    private let authorRow = UIStackView()
    private let overflowMenu = ItemOverflowMenu()
    private var authorToMenu: NSLayoutConstraint!
    private var authorToEdge: NSLayoutConstraint!
    let authorColumn = UILayoutGuide()
    var avatarBottomAnchor: NSLayoutYAxisAnchor { profileImageView.bottomAnchor }

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        profileImageView.image = UIImage(named: "background_1")
        ImageStyle.userProfileImage(imageView: profileImageView, diameter: avatarSize)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)

        usernameLabel.font = Fonts.postUsernameFont
        usernameLabel.textColor = Colors.primaryText
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        usernameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        usernameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.secondaryText
        postedAtLabel.numberOfLines = 1
        postedAtLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        postedAtLabel.setContentHuggingPriority(.required, for: .horizontal)

        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        authorRow.axis = .horizontal
        authorRow.alignment = .center
        authorRow.spacing = Layout.spacingS
        authorRow.translatesAutoresizingMaskIntoConstraints = false
        authorRow.addArrangedSubview(usernameLabel)
        authorRow.addArrangedSubview(postedAtLabel)
        authorRow.addArrangedSubview(spacer)
        addSubview(authorRow)

        addSubview(overflowMenu.button)
        addLayoutGuide(authorColumn)

        authorToMenu = authorRow.trailingAnchor.constraint(equalTo: overflowMenu.button.leadingAnchor)
        authorToEdge = authorRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL)
        let menuHeight = overflowMenu.button.heightAnchor.constraint(equalToConstant: 44)
        menuHeight.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            profileImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            profileImageView.heightAnchor.constraint(equalToConstant: avatarSize),

            authorRow.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Layout.spacingM),
            authorToMenu,
            authorRow.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            authorRow.bottomAnchor.constraint(equalTo: bottomAnchor),

            authorColumn.leadingAnchor.constraint(equalTo: authorRow.leadingAnchor),
            authorColumn.trailingAnchor.constraint(equalTo: authorRow.trailingAnchor),
            authorColumn.topAnchor.constraint(equalTo: authorRow.topAnchor),
            authorColumn.bottomAnchor.constraint(equalTo: authorRow.bottomAnchor),

            overflowMenu.button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingXS),
            overflowMenu.button.topAnchor.constraint(equalTo: topAnchor),
            overflowMenu.button.widthAnchor.constraint(equalToConstant: 44),
            menuHeight
        ])
    }

    func setMenuHidden(_ hidden: Bool) {
        overflowMenu.button.isHidden = hidden
        if hidden {
            authorToMenu.isActive = false
            authorToEdge.isActive = true
        } else {
            authorToEdge.isActive = false
            authorToMenu.isActive = true
        }
    }

    //FUNCTIONS
    func prepareForReuse() {
        loadUserName = nil
        overflowMenu.prepareForReuse()
        setMenuHidden(false)
        usernameLabel.text = nil
        postedAtLabel.text = nil
        profileImageView.image = UIImage(named: "background_1")
    }

    func configure(with post: Post) {
        overflowMenu.configure(with: post)
        postedAtLabel.text = post.timeMessage ?? "now"

        guard let username = post.postFrom, !username.isEmpty else {
            usernameLabel.text = nil
            loadUserName = nil
            profileImageView.image = UIImage(named: "background_1")
            return
        }

        usernameLabel.text = username
        loadUserProfile(username: username)
    }

    private func loadUserProfile(username: String) {
        loadUserName = username

        Task {
            guard let user = await usersDataController.getOrFetchUserWithImage(username: username) else {
                return
            }

            guard loadUserName == username else { return }

            await MainActor.run {
                guard self.loadUserName == username else { return }
                if let image = user.profileImage {
                    self.profileImageView.image = image
                }
            }
        }
    }

}

// Edit, delete, and hide for one post. The button is placed by the view that owns it.
final class ItemOverflowMenu {

    let button = UIButton(type: .system)
    private var post: Post?

    init() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        button.tintColor = Colors.primaryText
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        button.accessibilityLabel = "More"
        button.showsMenuAsPrimaryAction = true
        updateMenu()
    }

    func prepareForReuse() {
        post = nil
        updateMenu()
    }

    func configure(with post: Post) {
        self.post = post
        updateMenu()
    }

    private func updateMenu() {
        let currentUser = PostDataController.shared.currentUser
        let owner = post?.postFrom ?? ""
        let isOwner = !owner.isEmpty && owner.caseInsensitiveCompare(currentUser) == .orderedSame

        if isOwner {
            let editAction = UIAction(
                title: "Edit Item",
                image: UIImage(systemName: "pencil")
            ) { [weak self] _ in
                self?.editTapped()
            }
            let deleteAction = UIAction(
                title: "Delete",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { [weak self] _ in
                self?.confirmDelete()
            }
            button.menu = UIMenu(children: [editAction, deleteAction])
        } else {
            let hideAction = UIAction(
                title: "Hide",
                image: UIImage(systemName: "eye.slash")
            ) { _ in }
            button.menu = UIMenu(children: [hideAction])
        }
    }

    private func editTapped() {
        guard let post, let viewController = findViewController() else { return }
        let editor = EditItemViewController()
        editor.currentPost = post
        let navigation = UINavigationController(rootViewController: editor)
        navigation.modalPresentationStyle = .fullScreen
        viewController.present(navigation, animated: true)
    }

    private func confirmDelete() {
        guard let viewController = findViewController() else { return }

        let name = post?.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemName = (name?.isEmpty == false) ? name! : (post?.postCaption ?? "")
        let label = itemName.isEmpty ? "this item" : "\"\(itemName)\""
        let alert = UIAlertController(
            title: "Delete Item?",
            message: "Are you sure you want to delete \(label)? This cannot be undone.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteItem()
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewController.present(alert, animated: true)
        }
    }

    private func deleteItem() {
        guard let postID = post?.postID else {
            print("Delete Item: missing postID")
            return
        }

        Task {
            let success = await PostLogic.shared.deletePost(postID: postID)
            await MainActor.run {
                if !success {
                    self.showDeleteFailedAlert()
                }
            }
        }
    }

    private func showDeleteFailedAlert() {
        guard let viewController = findViewController() else { return }
        let alert = UIAlertController(
            title: "Couldn’t delete item",
            message: "Something went wrong. Please try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = button
        while let next = responder?.next {
            if let viewController = next as? UIViewController {
                return viewController
            }
            responder = next
        }
        return nil
    }
}
