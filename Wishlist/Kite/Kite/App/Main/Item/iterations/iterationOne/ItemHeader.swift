// Backup of the live Item card before the Option C spacing pass.
// Commented out so this copy is not compiled.

/*
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
    private var post: Post?
    private let avatarSize: CGFloat = 40

    //UI COMPONENTS
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postedAtLabel = UILabel()
    private let textStack = UIStackView()
    private let menuButton = UIButton(type: .system)

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
        setupMenu()
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

        usernameLabel.font = Fonts.semibold14
        usernameLabel.textColor = Colors.primaryText
        usernameLabel.numberOfLines = 1
        usernameLabel.lineBreakMode = .byTruncatingTail
        postedAtLabel.font = Fonts.postedAtFont
        postedAtLabel.textColor = Colors.secondaryText
        postedAtLabel.numberOfLines = 1

        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 0
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(usernameLabel)
        textStack.addArrangedSubview(postedAtLabel)
        addSubview(textStack)

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        menuButton.tintColor = Colors.primaryText
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        menuButton.accessibilityLabel = "More"
        addSubview(menuButton)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            profileImageView.heightAnchor.constraint(equalToConstant: avatarSize),

            textStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            textStack.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -Layout.spacingS),
            textStack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingXS),
            menuButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 44),
            menuButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupMenu() {
        let editAction = UIAction(
            title: "Edit",
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

        menuButton.menu = UIMenu(children: [editAction, deleteAction])
        menuButton.showsMenuAsPrimaryAction = true
    }

    //ACTIONS
    private func editTapped() {
        print("edit")
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

    //FUNCTIONS
    func prepareForReuse() {
        loadUserName = nil
        post = nil
        usernameLabel.text = nil
        postedAtLabel.text = nil
        profileImageView.image = UIImage(named: "background_1")
    }

    func configure(with post: Post) {
        self.post = post
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

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let viewController = next as? UIViewController {
                return viewController
            }
            responder = next
        }
        return nil
    }
}

*/
