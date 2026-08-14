//
//  ItemInfo.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS


final class ItemInfo: UIView {

    //LOGIC
    private var postID: Int?

    //UI COMPONENTS
    // mainItemContentView          ← whole card
    // ├── itemImageView            ← left
    // └── itemInfoView             ← right text column
    private let mainItemContentView = UIView()
    private let itemImageView = UIImageView()
    private let itemInfoView = UIView()
    private let itemNameView = UILabel()
    private let menuButton = UIButton(type: .system)
    private let itemPriceView = UILabel()
    private let itemDescriptionView = UILabel()

    //LAYOUT
    private let contentHeight: CGFloat = 180
    private let imageWidthMultiplier: CGFloat = 0.4

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = Colors.itemDetailBackground

        setupMainItemContentView()
        setupItemImage()
        setupItemInfoView()

        setupItemMenu()
        setupItemName()
        setupItemPrice()
        setupItemDescription()
    }

    private func setupMainItemContentView() {
        mainItemContentView.translatesAutoresizingMaskIntoConstraints = false
        mainItemContentView.backgroundColor = Colors.itemDetailContent
        mainItemContentView.layer.borderWidth = 1
        mainItemContentView.layer.borderColor = Colors.itemDetailDivider.cgColor
        addSubview(mainItemContentView)

        NSLayoutConstraint.activate([
            mainItemContentView.topAnchor.constraint(equalTo: topAnchor),
            mainItemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainItemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainItemContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainItemContentView.heightAnchor.constraint(equalToConstant: contentHeight)
        ])
    }

    private func setupItemImage() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        itemImageView.backgroundColor = Colors.itemDetailPlaceholder
        mainItemContentView.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: mainItemContentView.topAnchor, constant: Layout.spacingM),
            itemImageView.leadingAnchor.constraint(equalTo: mainItemContentView.leadingAnchor, constant: Layout.spacingM),
            itemImageView.bottomAnchor.constraint(equalTo: mainItemContentView.bottomAnchor, constant: -Layout.spacingM),
            itemImageView.widthAnchor.constraint(
                equalTo: mainItemContentView.widthAnchor,
                multiplier: imageWidthMultiplier
            )
        ])
    }

    private func setupItemInfoView() {
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView.backgroundColor = .clear
        mainItemContentView.addSubview(itemInfoView)

        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: mainItemContentView.topAnchor, constant: Layout.spacingM),
            itemInfoView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: Layout.spacingM),
            itemInfoView.trailingAnchor.constraint(equalTo: mainItemContentView.trailingAnchor, constant: -Layout.spacingM),
            itemInfoView.bottomAnchor.constraint(equalTo: mainItemContentView.bottomAnchor, constant: -Layout.spacingM)
        ])
    }

    private func setupItemMenu() {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        menuButton.tintColor = .black
        itemInfoView.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: itemInfoView.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            menuButton.heightAnchor.constraint(equalToConstant: Layout.touchTargetSize)
        ])

        setupMenu()
    }

    private func setupItemName() {
        itemNameView.translatesAutoresizingMaskIntoConstraints = false
        itemNameView.font = Fonts.itemNameFont
        itemNameView.textColor = Colors.primaryText
        itemNameView.numberOfLines = 2
        itemNameView.lineBreakMode = .byTruncatingTail
        itemNameView.setContentHuggingPriority(.required, for: .vertical)
        itemNameView.setContentCompressionResistancePriority(.required, for: .vertical)
        itemNameView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        itemNameView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        itemInfoView.addSubview(itemNameView)

        NSLayoutConstraint.activate([
            itemNameView.topAnchor.constraint(equalTo: itemInfoView.topAnchor),
            itemNameView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor),
            itemNameView.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -Layout.spacingS)
        ])
    }

    private func setupItemPrice() {
        itemPriceView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceView.font = Fonts.itemPriceFont
        itemPriceView.textColor = Colors.primaryText
        itemPriceView.numberOfLines = 1
        itemPriceView.lineBreakMode = .byTruncatingTail
        itemPriceView.setContentHuggingPriority(.required, for: .vertical)
        itemPriceView.setContentCompressionResistancePriority(.required, for: .vertical)
        itemInfoView.addSubview(itemPriceView)

        NSLayoutConstraint.activate([
            itemPriceView.topAnchor.constraint(equalTo: itemNameView.bottomAnchor, constant: Layout.spacingXS),
            itemPriceView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor),
            itemPriceView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor)
        ])
    }

    private func setupItemDescription() {
        itemDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionView.font = Fonts.itemDescriptionFont
        itemDescriptionView.textColor = Colors.secondaryText
        itemDescriptionView.numberOfLines = 6
        itemDescriptionView.lineBreakMode = .byTruncatingTail
        itemDescriptionView.setContentHuggingPriority(.required, for: .vertical)
        itemDescriptionView.setContentCompressionResistancePriority(.required, for: .vertical)
        itemInfoView.addSubview(itemDescriptionView)

        // Intrinsic height keeps text top-aligned; leftover space stays in itemInfoView.
        NSLayoutConstraint.activate([
            itemDescriptionView.topAnchor.constraint(equalTo: itemPriceView.bottomAnchor, constant: Layout.spacingS),
            itemDescriptionView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor),
            itemDescriptionView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor),
            itemDescriptionView.bottomAnchor.constraint(lessThanOrEqualTo: itemInfoView.bottomAnchor)
        ])
    }

    private func setupMenu() {
        let editAction = UIAction(
            title: "Edit",
            image: UIImage(systemName: "pencil")
        ) { [weak self] _ in
            self?.editItem()
        }

        let deleteAction = UIAction(
            title: "Delete",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.deleteItem()
        }

        menuButton.menu = UIMenu(children: [editAction, deleteAction])
        menuButton.showsMenuAsPrimaryAction = true
    }

    //ACTIONS
    private func editItem() {
        print("Edit Item: \(postID ?? 0)")
    }

    private func deleteItem() {
        print("Delete Item: \(postID ?? 0)")
    }

    //FUNCTIONS
    func configure(with post: Post) {
        postID = post.postID

        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemNameView.text = (name?.isEmpty == false) ? name : "Untitled"

        let price = post.itemPrice?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemPriceView.text = (price?.isEmpty == false) ? price : nil

        let description = post.itemDescription?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemDescriptionView.text = (description?.isEmpty == false) ? description : nil

        if let image = post.postImageData, image.size.width > 0 {
            itemImageView.image = image
        } else {
            itemImageView.image = nil
        }
    }
}
