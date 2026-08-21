//
//  IndividualListHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//
// HEIGHT: Designed for 110pt. When used as tableView.tableHeaderView,
// set the header frame height — tableHeaderView does not auto-resize
// from Auto Layout alone.

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS


final class IndividualListHeader: UIView {

    //LAYOUT
    private let headerHeight: CGFloat = 110
    private let imageWidthMultiplier: CGFloat = 0.3
    private let nameRowHeight: CGFloat = 28
    private let descriptionRowHeight: CGFloat = 20
    private let buttonsRowHeight: CGFloat = 30
    private let actionButtonHeight: CGFloat = 28
    private let actionButtonHorizontalInset: CGFloat = 6

    //UI COMPONENTS
    // IndividualListHeader
    // ├── listImageView            ← 30% / 110
    // └── listInfoView             ← 70% / 110
    //     ├── listNameView         ← 28  (top inset matches image)
    //     ├── listDescriptionView  ← 20
    //     ├── listSocialsView      ← commented out for now
    //     └── listButtonsView      ← 30  (bottom inset matches image)

    //Item Image
    private let listImageView = UIView()
    private let listImage = UIImageView()

    //Item Info
    private let listInfoView = UIView()

    private let listNameView = UIView()
    private let listNameLabel = UILabel()

    private let listMenuButton = UIButton(type: .system)

    private let listDescriptionView = UIView()
    private let listDescriptionLabel = UILabel()

    // Socials — hidden for now
    // private let listSocialsView = UIView()
    // private let listSocialsLabel = UILabel()

    private let listButtonsView = UIView()

    private let wishlistInviteFriendsButton = UIButton(type: .system)
    private let wishlistShareListButton = UIButton(type: .system)

    private var groupID: Int?
    private var groupName: String = ""

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear

        setupListImageView()
        setupListInfoView()
        setupListNameView()
        setupListDescriptionView()
        // setupListSocialsView()
        setupListButtonsView()
    }

    private func setupListImageView() {
        listImageView.translatesAutoresizingMaskIntoConstraints = false
        listImageView.backgroundColor = .clear
        listImageView.clipsToBounds = true
        addSubview(listImageView)

        listImage.translatesAutoresizingMaskIntoConstraints = false
        listImage.contentMode = .scaleAspectFill
        listImage.clipsToBounds = true
        listImage.layer.cornerRadius = 8
        listImage.image = UIImage(named: "background_1")
        listImageView.addSubview(listImage)

        NSLayoutConstraint.activate([
            listImageView.topAnchor.constraint(equalTo: topAnchor),
            listImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listImageView.heightAnchor.constraint(equalToConstant: headerHeight),
            listImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: imageWidthMultiplier),

            listImage.topAnchor.constraint(equalTo: listImageView.topAnchor, constant: Layout.spacingM),
            listImage.leadingAnchor.constraint(equalTo: listImageView.leadingAnchor, constant: Layout.spacingM),
            listImage.trailingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: -Layout.spacingM),
            listImage.bottomAnchor.constraint(equalTo: listImageView.bottomAnchor, constant: -Layout.spacingM)
        ])
    }

    private func setupListInfoView() {
        listInfoView.translatesAutoresizingMaskIntoConstraints = false
        listInfoView.backgroundColor = .clear
        addSubview(listInfoView)

        NSLayoutConstraint.activate([
            listInfoView.topAnchor.constraint(equalTo: topAnchor),
            listInfoView.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor),
            listInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listInfoView.heightAnchor.constraint(equalToConstant: headerHeight)
        ])
    }

    private func setupListNameView() {
        listNameView.translatesAutoresizingMaskIntoConstraints = false
        listNameView.backgroundColor = .clear
        listInfoView.addSubview(listNameView)

        listNameLabel.translatesAutoresizingMaskIntoConstraints = false
        listNameLabel.font = Fonts.listNameFont
        listNameLabel.textColor = Colors.primaryText
        listNameLabel.numberOfLines = 1
        listNameLabel.lineBreakMode = .byTruncatingTail
        listNameView.addSubview(listNameLabel)

        listMenuButton.translatesAutoresizingMaskIntoConstraints = false
        listMenuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        listMenuButton.tintColor = Colors.primaryText
        listMenuButton.imageView?.contentMode = .scaleAspectFit
        setupListMenu()
        listNameView.addSubview(listMenuButton)

        // Top inset matches image content so name sits lower and aligns with the image.
        NSLayoutConstraint.activate([
            listNameView.topAnchor.constraint(equalTo: listInfoView.topAnchor, constant: Layout.spacingM),
            listNameView.leadingAnchor.constraint(equalTo: listInfoView.leadingAnchor),
            listNameView.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor),
            listNameView.heightAnchor.constraint(equalToConstant: nameRowHeight),

            listMenuButton.trailingAnchor.constraint(equalTo: listNameView.trailingAnchor, constant: -Layout.spacingXS),
            listMenuButton.centerYAnchor.constraint(equalTo: listNameView.centerYAnchor),
            listMenuButton.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            listMenuButton.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            listNameLabel.leadingAnchor.constraint(equalTo: listNameView.leadingAnchor, constant: Layout.spacingXS),
            listNameLabel.trailingAnchor.constraint(equalTo: listMenuButton.leadingAnchor, constant: -Layout.spacingS),
            listNameLabel.centerYAnchor.constraint(equalTo: listNameView.centerYAnchor)
        ])
    }

    private func setupListDescriptionView() {
        listDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        listDescriptionView.backgroundColor = .clear
        listInfoView.addSubview(listDescriptionView)

        listDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        listDescriptionLabel.font = Fonts.listDescriptionFont
        listDescriptionLabel.textColor = Colors.darkSecondaryText
        listDescriptionLabel.numberOfLines = 1
        listDescriptionLabel.lineBreakMode = .byTruncatingTail
        listDescriptionView.addSubview(listDescriptionLabel)

        NSLayoutConstraint.activate([
            listDescriptionView.topAnchor.constraint(equalTo: listNameView.bottomAnchor),
            listDescriptionView.leadingAnchor.constraint(equalTo: listInfoView.leadingAnchor),
            listDescriptionView.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor),
            listDescriptionView.heightAnchor.constraint(equalToConstant: descriptionRowHeight),

            listDescriptionLabel.leadingAnchor.constraint(equalTo: listDescriptionView.leadingAnchor, constant: Layout.spacingXS),
            listDescriptionLabel.trailingAnchor.constraint(equalTo: listDescriptionView.trailingAnchor, constant: -Layout.spacingXS),
            listDescriptionLabel.centerYAnchor.constraint(equalTo: listDescriptionView.centerYAnchor)
        ])
    }

    /*
    private func setupListSocialsView() {
        listSocialsView.translatesAutoresizingMaskIntoConstraints = false
        listSocialsView.backgroundColor = .clear
        listInfoView.addSubview(listSocialsView)

        listSocialsLabel.translatesAutoresizingMaskIntoConstraints = false
        listSocialsLabel.font = Fonts.listDescriptionFont
        listSocialsLabel.textColor = Colors.darkSecondaryText
        listSocialsLabel.numberOfLines = 1
        listSocialsLabel.lineBreakMode = .byTruncatingTail
        listSocialsView.addSubview(listSocialsLabel)

        NSLayoutConstraint.activate([
            listSocialsView.topAnchor.constraint(equalTo: listDescriptionView.bottomAnchor),
            listSocialsView.leadingAnchor.constraint(equalTo: listInfoView.leadingAnchor),
            listSocialsView.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor),
            listSocialsView.heightAnchor.constraint(equalToConstant: 24),

            listSocialsLabel.leadingAnchor.constraint(equalTo: listSocialsView.leadingAnchor, constant: Layout.spacingXS),
            listSocialsLabel.trailingAnchor.constraint(equalTo: listSocialsView.trailingAnchor, constant: -Layout.spacingXS),
            listSocialsLabel.centerYAnchor.constraint(equalTo: listSocialsView.centerYAnchor)
        ])
    }
    */

    private func setupListButtonsView() {
        listButtonsView.translatesAutoresizingMaskIntoConstraints = false
        listButtonsView.backgroundColor = .clear
        listInfoView.addSubview(listButtonsView)

        // Bottom inset matches image; keeps description→buttons gap similar to old socials spacing.
        NSLayoutConstraint.activate([
            listButtonsView.leadingAnchor.constraint(equalTo: listInfoView.leadingAnchor),
            listButtonsView.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor),
            listButtonsView.bottomAnchor.constraint(equalTo: listInfoView.bottomAnchor, constant: -Layout.spacingM),
            listButtonsView.heightAnchor.constraint(equalToConstant: buttonsRowHeight)
        ])

        setupWishlistInviteFriendsButton()
        setupWishlistShareListButton()
    }

    private func setupWishlistInviteFriendsButton() {
        wishlistInviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        wishlistInviteFriendsButton.setTitle("Invite Friends", for: .normal)
        wishlistInviteFriendsButton.setImage(UIImage(systemName: "person.2"), for: .normal)
        wishlistInviteFriendsButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        Buttons.wishlistInviteFriendsButtonStyle(button: wishlistInviteFriendsButton)
        wishlistInviteFriendsButton.addTarget(self, action: #selector(didTapInviteFriends), for: .touchUpInside)
        listButtonsView.addSubview(wishlistInviteFriendsButton)
    }

    private func setupWishlistShareListButton() {
        wishlistShareListButton.translatesAutoresizingMaskIntoConstraints = false
        wishlistShareListButton.setTitle("Share List", for: .normal)
        wishlistShareListButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        wishlistShareListButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        Buttons.wishlistShareListButtonStyle(button: wishlistShareListButton)
        wishlistShareListButton.addTarget(self, action: #selector(didTapShareList), for: .touchUpInside)
        listButtonsView.addSubview(wishlistShareListButton)

        NSLayoutConstraint.activate([
            wishlistInviteFriendsButton.leadingAnchor.constraint(equalTo: listButtonsView.leadingAnchor, constant: actionButtonHorizontalInset),
            wishlistInviteFriendsButton.centerYAnchor.constraint(equalTo: listButtonsView.centerYAnchor),
            wishlistInviteFriendsButton.heightAnchor.constraint(equalToConstant: actionButtonHeight),

            wishlistShareListButton.leadingAnchor.constraint(equalTo: wishlistInviteFriendsButton.trailingAnchor, constant: Layout.spacingS),
            wishlistShareListButton.trailingAnchor.constraint(equalTo: listButtonsView.trailingAnchor, constant: -actionButtonHorizontalInset),
            wishlistShareListButton.centerYAnchor.constraint(equalTo: listButtonsView.centerYAnchor),
            wishlistShareListButton.heightAnchor.constraint(equalToConstant: actionButtonHeight),
            wishlistShareListButton.widthAnchor.constraint(equalTo: wishlistInviteFriendsButton.widthAnchor)
        ])
    }

    private func setupListMenu() {
        let editAction = UIAction(
            title: "Edit",
            image: UIImage(systemName: "pencil")
        ) { [weak self] _ in
            self?.editList()
        }

        let deleteAction = UIAction(
            title: "Delete",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.confirmDeleteList()
        }

        listMenuButton.menu = UIMenu(children: [editAction, deleteAction])
        listMenuButton.showsMenuAsPrimaryAction = true
    }

    //ACTIONS
    private func editList() {
        print("Edit List: \(groupID ?? 0)")
    }

    private func confirmDeleteList() {
        guard let viewController = findViewController() else { return }

        let listLabel = groupName.isEmpty ? "this list" : "\"\(groupName)\""
        let alert = UIAlertController(
            title: "Delete List?",
            message: "Are you sure you want to delete \(listLabel)? This cannot be undone.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteList()
        })

        // Let the menu dismiss before presenting the alert.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewController.present(alert, animated: true)
        }
    }

    private func deleteList() {
        guard let groupID else {
            print("Delete List: missing groupID")
            return
        }

        print("Delete List: \(groupID)")
        // No delete-group API yet — remove locally and leave the screen.
        GroupDataController.shared.removeGroup(groupID: groupID)
        findViewController()?.navigationController?.popViewController(animated: true)
    }

    @objc private func didTapInviteFriends() {
        print("Invite Friends")
    }

    @objc private func didTapShareList() {
        print("Share List")
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

    //FUNCTIONS
    func configure(with group: GroupModel, itemCount: Int) {
        groupID = group.groupID
        groupName = group.groupName
        listNameLabel.text = group.groupName

        let description = group.groupDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        listDescriptionLabel.text = description.isEmpty ? nil : description

        // Socials — hidden for now
        // let friendCount = group.activeGroupMembers.count
        // listSocialsLabel.text = "\(itemCount) Items \(friendCount) Friends"
        _ = itemCount
    }
}
