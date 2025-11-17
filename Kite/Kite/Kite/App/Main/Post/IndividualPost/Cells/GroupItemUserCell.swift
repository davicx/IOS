//
//  GroupItemUserCell.swift
//  Kite
//
//  Created by David Vasquez on 10/21/25.
//

import UIKit


//WISHLIST: Item
class GroupItemUserCell: UITableViewCell {
    
    // MAIN VIEWS
    let itemView = UIView()
    
    // LEVEL 1
    let itemInfoView = UIView() 
    let itemSocialsView = UIView()
    let itemSocialsBarView = UIView()
    
    // LEVEL 2
    let itemImageHolderView = UIView()
    let itemNamePriceDescriptionHolderView = UIView()
    let editItemView = UIView()
    
    //UI Elements
    private let productImageView = UIImageView()
    private let itemNameLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemDescriptionTextView = UITextView()
    private let commentTemplate = CommentTemplate()
    private let purchaseButton = UIButton(type: .system)
    
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu-horizontal")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItemView()
        setupItemInfoView()
        setupMenu()
        setupItemSocialsView()
        setupItemInfoTextAndImage()
        setupPurchaseButton()
        setupCommentTextView()
        setupItemSocialsBarView()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: - Setup Item View
    private func setupItemView() {
        contentView.backgroundColor = .white
        contentView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.backgroundColor = UIColor.itemBackgroundColor
        itemView.layer.borderColor = UIColor.white.cgColor
        itemView.layer.borderWidth = 4
        itemView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Setup Item Info View
    private func setupItemInfoView() {
        itemView.addSubview(itemInfoView)
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        itemInfoView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 8),
            itemInfoView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            itemInfoView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            itemInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 140)
        ])
        
        setupItemInfoSubviews()
    }
    
    
    // MARK: - Setup Item Info Subviews
    private func setupItemInfoSubviews() {
        itemInfoView.addSubview(itemImageHolderView)
        itemInfoView.addSubview(itemNamePriceDescriptionHolderView)
        itemInfoView.addSubview(editItemView)
        editItemView.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        
        itemImageHolderView.translatesAutoresizingMaskIntoConstraints = false
        itemNamePriceDescriptionHolderView.translatesAutoresizingMaskIntoConstraints = false
        editItemView.translatesAutoresizingMaskIntoConstraints = false
        
        itemImageHolderView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
        itemNamePriceDescriptionHolderView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        editItemView.backgroundColor = .red
        
        itemImageHolderView.layer.cornerRadius = 8
        itemNamePriceDescriptionHolderView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            itemImageHolderView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor, constant: 8),
            itemImageHolderView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 8),
            itemImageHolderView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -8),
            itemImageHolderView.widthAnchor.constraint(equalToConstant: 120),
            
            editItemView.leadingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.leadingAnchor),
            editItemView.trailingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.trailingAnchor),
            editItemView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 8),
            editItemView.heightAnchor.constraint(equalToConstant: 24),
            
            itemNamePriceDescriptionHolderView.leadingAnchor.constraint(equalTo: itemImageHolderView.trailingAnchor, constant: 8),
            itemNamePriceDescriptionHolderView.topAnchor.constraint(equalTo: editItemView.bottomAnchor),
            itemNamePriceDescriptionHolderView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor, constant: -8),
            itemNamePriceDescriptionHolderView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: editItemView.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 22),
            menuButton.heightAnchor.constraint(equalToConstant: 22),
            menuButton.trailingAnchor.constraint(equalTo: editItemView.trailingAnchor, constant: -8)
        ])
    }
    
    
    // MARK: - Setup Item Socials View
    private func setupItemSocialsView() {
        itemView.addSubview(itemSocialsView)
        itemSocialsView.translatesAutoresizingMaskIntoConstraints = false
        itemSocialsView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
        itemSocialsView.layer.cornerRadius = 8

        NSLayoutConstraint.activate([
            itemSocialsView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: 8),
            itemSocialsView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            itemSocialsView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Setup Item Socials Bar View
    private func setupItemSocialsBarView() {
        itemView.addSubview(itemSocialsBarView)
        itemSocialsBarView.translatesAutoresizingMaskIntoConstraints = false
        itemSocialsBarView.backgroundColor = UIColor.systemPink
        itemSocialsBarView.layer.cornerRadius = 8

        NSLayoutConstraint.activate([
            itemSocialsBarView.topAnchor.constraint(equalTo: itemSocialsView.bottomAnchor, constant: 8),
            itemSocialsBarView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            itemSocialsBarView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            itemSocialsBarView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -8),
            itemSocialsBarView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    // MARK: - Setup Item Info Text And Image
    private func setupItemInfoTextAndImage() {
        // --- IMAGE ---
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit   // keeps proportions
        productImageView.clipsToBounds = true
        productImageView.image = UIImage(named: "background_1") ?? UIImage()
        itemImageHolderView.addSubview(productImageView)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: itemImageHolderView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: itemImageHolderView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: itemImageHolderView.trailingAnchor),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: itemImageHolderView.bottomAnchor),
            productImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 80) // max height
        ])
        
        // --- LABELS ---
        itemNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        itemNameLabel.textColor = .label
        itemNameLabel.text = "Item Name"

        itemPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        itemPriceLabel.textColor = .secondaryLabel
        itemPriceLabel.text = "Item Price"

        itemDescriptionTextView.font = UIFont.systemFont(ofSize: 14)
        itemDescriptionTextView.textColor = .darkGray
        itemDescriptionTextView.isScrollEnabled = false  // auto-expand
        itemDescriptionTextView.layer.cornerRadius = 6
        itemDescriptionTextView.layer.borderWidth = 1
        itemDescriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        itemDescriptionTextView.text = "Item Description"

        // --- STACK VIEW ---
        let infoStack = UIStackView(arrangedSubviews: [itemNameLabel, itemPriceLabel, itemDescriptionTextView])
        infoStack.axis = .vertical
        infoStack.spacing = 8
        infoStack.alignment = .leading
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        itemNamePriceDescriptionHolderView.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.topAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.trailingAnchor, constant: -8),
            infoStack.bottomAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.bottomAnchor, constant: -8)
        ])
    }

    
    // MARK: - Setup Purchase Button
    private func setupPurchaseButton() {
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .systemBlue
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.layer.cornerRadius = 6
        purchaseButton.addTarget(self, action: #selector(didTapPurchase), for: .touchUpInside)
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        itemSocialsView.addSubview(purchaseButton)
        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: itemSocialsView.topAnchor, constant: 8),
            purchaseButton.leadingAnchor.constraint(equalTo: itemSocialsView.leadingAnchor, constant: 8),
            purchaseButton.trailingAnchor.constraint(equalTo: itemSocialsView.trailingAnchor, constant: -8),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup Comment Text View
    private func setupCommentTextView() {
        commentTemplate.translatesAutoresizingMaskIntoConstraints = false
        
        itemSocialsView.addSubview(commentTemplate)
        NSLayoutConstraint.activate([
            commentTemplate.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: 8),
            commentTemplate.leadingAnchor.constraint(equalTo: itemSocialsView.leadingAnchor, constant: 8),
            commentTemplate.trailingAnchor.constraint(equalTo: itemSocialsView.trailingAnchor, constant: -8),
            commentTemplate.bottomAnchor.constraint(equalTo: itemSocialsView.bottomAnchor, constant: -8)
        ])
    }


    // MARK: - Configure
    func configurePost(with item: Item) {
        print("=== IndividualGroupPostCell configurePost ===")
        print("postID: \(item.postID)")
        
        func sanitizedText(_ value: String?, fallback: String) -> String {
            guard let raw = value?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !raw.isEmpty else {
                return fallback
            }
            
            let lowered = raw.lowercased()
            if lowered == "empty" || lowered == "nil" || lowered == "null" {
                return fallback
            }
            
            return raw
        }
        
        let fallbackName = "Item Name"
        let fallbackPrice = "Item Price"
        let fallbackDescription = "Item Description"
        let fallbackComment = "Comment"
        
        itemNameLabel.text = sanitizedText(item.itemName, fallback: fallbackName)
        
        let priceText = sanitizedText(item.itemPrice, fallback: fallbackPrice)
        if priceText == fallbackPrice {
            itemPriceLabel.text = priceText
        } else if let numericPrice = Double(priceText) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            itemPriceLabel.text = formatter.string(from: NSNumber(value: numericPrice)) ?? priceText
        } else {
            itemPriceLabel.text = priceText
        }
        
        itemDescriptionTextView.text = sanitizedText(item.itemDescription, fallback: fallbackDescription)
        
        let userName = sanitizedText(item.postFrom, fallback: "User")
        let commentText = sanitizedText(item.postCaption, fallback: fallbackComment)
        let userImage = item.postFromImageData ?? UIImage(named: "background_1")
        
        commentTemplate.configure(userName: userName, commentText: commentText, image: userImage)
        
        if let image = item.postImageData {
            productImageView.image = image
        } else {
            productImageView.image = UIImage(named: "background_1") ?? UIImage()
        }
    }
    
    @objc private func didTapPurchase() {
        print("purchased")
    }
    
    @objc private func didTapMenu() {
        print("GroupItemUserCell: menu button tapped")
    }
    
    // MARK: - Menu Setup
    private func setupMenu() {
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
            print("GroupItemUserCell: Edit tapped")
        }
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            print("GroupItemUserCell: Delete tapped")
        }
        
        let menu = UIMenu(title: "", children: [editAction, deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
}

//WISHLIST: Item
/*
class GroupItemUserCell: UITableViewCell {
    
    //MAIN VIEWS
    let itemView = UIView()
    
    //LEVEL 1: itemView contains these children
    let itemInfoView = UIView()
    let itemSocialsView = UIView()
    
    //LEVEL 2: itemInfoView: Contains these
    let itemImageHolderView = UIView()
    let itemNamePriceDescriptionHolderView = UIView()
    
    //LEVEL 3: itemNamePriceDescriptionHolderView: Contains these text labels Item, Name and Price
    //Create text labels and image here
    
    //LEVEL 2: itemSocialsView contains these
    //Create text labels here

    
    //MAIN: Called from IndividualGroupUserViewController
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItemView()
        setupItemInfoView()
        setupItemSocialsView()
        setupItemInfoTextAndImage()
        setupItemSocialsText()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Main Item View
    private func setupItemView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.backgroundColor = UIColor.itemBackgroundColor
        itemView.layer.borderColor = UIColor.white.cgColor
        itemView.layer.borderWidth = 4
        itemView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    
    // MARK: - Setup Item Info View
    private func setupItemInfoView() {
        itemView.addSubview(itemInfoView)
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        itemInfoView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 8),
            itemInfoView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            itemInfoView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            itemInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 140)
        ])
        
        setupItemInfoSubviews()
    }
    
    // MARK: - Setup Item Info Subviews
    private func setupItemInfoSubviews() {
        itemInfoView.addSubview(itemImageHolderView)
        itemInfoView.addSubview(itemNamePriceDescriptionHolderView)
        
        itemImageHolderView.translatesAutoresizingMaskIntoConstraints = false
        itemNamePriceDescriptionHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        // Example background colors to help visualize
        itemImageHolderView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
        itemNamePriceDescriptionHolderView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        
        itemImageHolderView.layer.cornerRadius = 8
        itemNamePriceDescriptionHolderView.layer.cornerRadius = 8
        
        // Constraints
        NSLayoutConstraint.activate([
            // itemImageHolderView (left side)
            itemImageHolderView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor, constant: 8),
            itemImageHolderView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 8),
            itemImageHolderView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -8),
            itemImageHolderView.widthAnchor.constraint(equalToConstant: 120),
            itemImageHolderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            // itemNamePriceDescriptionHolderView (right side)
            itemNamePriceDescriptionHolderView.leadingAnchor.constraint(equalTo: itemImageHolderView.trailingAnchor, constant: 8),
            itemNamePriceDescriptionHolderView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 8),
            itemNamePriceDescriptionHolderView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor, constant: -8),
            itemNamePriceDescriptionHolderView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -8),
            itemNamePriceDescriptionHolderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    
    // MARK: - Setup Item Socials View
    private func setupItemSocialsView() {
        itemView.addSubview(itemSocialsView)
        itemSocialsView.translatesAutoresizingMaskIntoConstraints = false
        itemSocialsView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
        itemSocialsView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            itemSocialsView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: 8),
            itemSocialsView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            itemSocialsView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            itemSocialsView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -8),
            itemSocialsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 140)
        ])
    }
    

    // MARK: - Setup Item Info Text And Image
    private func setupItemInfoTextAndImage() {
        // --- IMAGE ---
        let itemImageView = UIImageView()
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.backgroundColor = .systemGray5
        itemImageHolderView.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: itemImageHolderView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: itemImageHolderView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: itemImageHolderView.trailingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: itemImageHolderView.bottomAnchor)
        ])

        // --- NAME ---
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.text = "Name"
        itemNamePriceDescriptionHolderView.addSubview(nameLabel)

        // --- PRICE ---
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        priceLabel.textColor = .secondaryLabel
        priceLabel.text = "$0.00"
        itemNamePriceDescriptionHolderView.addSubview(priceLabel)

        // --- DESCRIPTION ---
        let descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.textColor = .darkGray
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.layer.cornerRadius = 6
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.text = "Description"
        itemNamePriceDescriptionHolderView.addSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 40),

            descriptionTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            descriptionTextView.leadingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: itemNamePriceDescriptionHolderView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: itemNamePriceDescriptionHolderView.bottomAnchor),
            descriptionTextView.heightAnchor.constraint(lessThanOrEqualToConstant: 80)
        ])
    }

    // MARK: - Setup Item Socials Text
    private func setupItemSocialsText() {
        // PURCHASE button
        let purchaseButton = UIButton(type: .system)
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .systemBlue
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.layer.cornerRadius = 6
        purchaseButton.addTarget(self, action: #selector(didTapPurchase), for: .touchUpInside)
        itemSocialsView.addSubview(purchaseButton)
        
        // COMMENT field
        let commentTextView = UITextView()
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.font = UIFont.systemFont(ofSize: 14)
        commentTextView.textColor = .darkGray
        commentTextView.isScrollEnabled = true
        commentTextView.layer.cornerRadius = 6
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.systemGray4.cgColor
        commentTextView.text = "Comment"
        itemSocialsView.addSubview(commentTextView)
        
        // SOCIALS placeholder view
        let socialsBarView = UIView()
        socialsBarView.translatesAutoresizingMaskIntoConstraints = false
        socialsBarView.backgroundColor = UIColor.systemGray6
        itemSocialsView.addSubview(socialsBarView)
        
        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: itemSocialsView.topAnchor, constant: 8),
            purchaseButton.leadingAnchor.constraint(equalTo: itemSocialsView.leadingAnchor, constant: 8),
            purchaseButton.trailingAnchor.constraint(equalTo: itemSocialsView.trailingAnchor, constant: -8),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40),
            
            commentTextView.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: 8),
            commentTextView.leadingAnchor.constraint(equalTo: itemSocialsView.leadingAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: itemSocialsView.trailingAnchor, constant: -8),
            commentTextView.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            socialsBarView.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 8),
            socialsBarView.leadingAnchor.constraint(equalTo: itemSocialsView.leadingAnchor, constant: 8),
            socialsBarView.trailingAnchor.constraint(equalTo: itemSocialsView.trailingAnchor, constant: -8),
            socialsBarView.heightAnchor.constraint(equalToConstant: 40),
            socialsBarView.bottomAnchor.constraint(equalTo: itemSocialsView.bottomAnchor, constant: -8)
        ])
    }

    private func setupItemSocialsBarView() {
    }
    
    // MARK: - Configure
    func configurePost(with item: Item) {
        print("=== IndividualGroupPostCell configurePost ===")
        print("postID: \(item.postID)")
        print("groupID: \(item.groupID)")
        print("postCaption: \(item.postCaption ?? "nil")")
        print("fileURL: \(item.fileUrl ?? "nil")")
        print("item_name: \(item.itemName ?? "nil")")
    }
    @objc private func didTapPurchase() {
        print("purchased")
    }
}

*/
//let itemPurchaseHolderView = UIView()
//let itemCommentHolderView = UIView()
//let itemSocialsHolderView = UIView()
//let itemNameHolderView = UIView()
//let itemPriceHolderView = UIView()
//let itemDescriptionHolderView = UIView()

//WISHLIST: Item
/*
class GroupItemUserCell: UITableViewCell {
    
    //MAIN VIEWS
    let itemView = UIView()
    
    //itemView contains these children
    let itemInfoView = UIView()
    let itemSocialsView = UIView()
    
    //itemInfoView: Contains these
    let itemImageHolderView = UIView()
    let itemNameHolderView = UIView()
    let itemPriceHolderView = UIView()
    let itemDescriptionHolderView = UIView()
    
    //itemSocialsView contains these below
    let itemPurchaseHolderView = UIView()
    let itemCommentHolderView = UIView()
    let itemSocialsHolderView = UIView()
    
    

    //MAIN: Called from IndividualGroupUserViewController
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItemView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //purchaseButton.addTarget(self, action: #selector(didTapPurchase), for: .touchUpInside)

    }

    
    //VIEWS: UI and Layout
    //View: Item Holder View (Holds all other UI Elements)
    private func setupItemView() {
        // Set cell background to white
        contentView.backgroundColor = .white
        
        // Add itemView with white border and itemBackgroundColor
        contentView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.backgroundColor = UIColor.itemBackgroundColor
        itemView.layer.borderColor = UIColor.white.cgColor
        itemView.layer.borderWidth = 4
        itemView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemView.heightAnchor.constraint(greaterThanOrEqualToConstant: 280),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    //View: Item Holder View (Holds all other UI Elements)
    private func setupItemImageHolderViewView() {
        
    }
    
    


    
    //CELL SETUP
    func configurePost(with item: Item) {
        // Print item information
        print("=== IndividualGroupPostCell configurePost ===")
        print("=== Item Information ===")
        print("postID: \(item.postID)")
        print("groupID: \(item.groupID)")
        print("postCaption: \(item.postCaption ?? "nil")")
        print("fileURL: \(item.fileUrl ?? "nil")")
        print("item_name: \(item.itemName ?? "nil")")
        print("========================")
        
        // Set the item image (already downloaded by addPostImageToItemsArray)
        //productImageView.image = item.postImageData ?? UIImage(named: "background_1")
    }

    
    //ACTIONS
    @objc private func didTapPurchase() {
        print("purchased")
    }


}

*/

//APPENDIX
/*
let itemInfoView = componentFunctions.createUIView(backgroundColor: UIColor.systemBlue)
let itemPurchasedView = componentFunctions.createUIView(backgroundColor: UIColor.systemGreen)
let itemStoresView = componentFunctions.createUIView(backgroundColor: UIColor.systemOrange)
let itemCaptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemPurple)
let dividerView = componentFunctions.createUIView(backgroundColor: UIColor.black)

// Subviews
let itemImageView = componentFunctions.createUIView(backgroundColor: UIColor.systemPink)
let itemDescriptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemTeal)

// Add these new UI elements
private let productImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .lightGray // placeholder background
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
}()

private let purchaseButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Purchase Me", for: .normal)
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    return button
}()
 */


/*
// Setup Entry Point
private func setupPostViews() {
    setupItemInfoViews()
    setupItemPurchasedViews()
    setupItemStoreViews()
    setupItemCaptionViews()
    setupDividerView()
}
 */


/*
//VIEW: Item Info
private func setupItemInfoViews() {
    contentView.addSubview(itemInfoView)
    itemInfoView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        itemInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
        itemInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        itemInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        itemInfoView.heightAnchor.constraint(equalToConstant: 240)
    ])
    
    // Add subviews inside itemInfoView
    itemInfoView.addSubview(itemImageView)
    itemInfoView.addSubview(itemDescriptionView)
    
    itemImageView.translatesAutoresizingMaskIntoConstraints = false
    itemDescriptionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        // itemImageView: fixed width, left, vertically centered
        itemImageView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor, constant: 12),
        itemImageView.centerYAnchor.constraint(equalTo: itemInfoView.centerYAnchor),
        itemImageView.widthAnchor.constraint(equalToConstant: 160),
        itemImageView.heightAnchor.constraint(equalTo: itemInfoView.heightAnchor, multiplier: 0.8),
        
        // itemDescriptionView: fills remaining space
        itemDescriptionView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 12),
        itemDescriptionView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -12),
        itemDescriptionView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
        itemDescriptionView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor, constant: -12)
    ])
    
    //Item Image and Button
    itemImageView.addSubview(productImageView)
    itemImageView.addSubview(purchaseButton)

    // Product image constraints
    NSLayoutConstraint.activate([
        productImageView.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 8),
        productImageView.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
        productImageView.widthAnchor.constraint(equalToConstant: 160),
        productImageView.heightAnchor.constraint(equalToConstant: 120),
        
        // Button below image
        purchaseButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
        purchaseButton.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
        purchaseButton.widthAnchor.constraint(equalToConstant: 140),
        purchaseButton.heightAnchor.constraint(equalToConstant: 40),
        purchaseButton.bottomAnchor.constraint(lessThanOrEqualTo: itemImageView.bottomAnchor, constant: -8)
    ])

}


//VIEW: Item Purchased Info
private func setupItemPurchasedViews() {
    contentView.addSubview(itemPurchasedView)
    itemPurchasedView.translatesAutoresizingMaskIntoConstraints = false
    
    // Add temporary label to distinguish user cell
    let userLabel = UILabel()
    userLabel.text = "Current User"
    userLabel.font = UIFont.boldSystemFont(ofSize: 16)
    userLabel.textColor = .white
    userLabel.textAlignment = .center
    userLabel.translatesAutoresizingMaskIntoConstraints = false
    itemPurchasedView.addSubview(userLabel)
    
    NSLayoutConstraint.activate([
        itemPurchasedView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor),
        itemPurchasedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        itemPurchasedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        itemPurchasedView.heightAnchor.constraint(equalToConstant: 40),
        
        // Label constraints
        userLabel.centerXAnchor.constraint(equalTo: itemPurchasedView.centerXAnchor),
        userLabel.centerYAnchor.constraint(equalTo: itemPurchasedView.centerYAnchor)
    ])
}


//VIEW: Item Store Links
private func setupItemStoreViews() {
    contentView.addSubview(itemStoresView)
    itemStoresView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        itemStoresView.topAnchor.constraint(equalTo: itemPurchasedView.bottomAnchor),
        itemStoresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        itemStoresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        itemStoresView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
    ])
}


//VIEW: Caption
private func setupItemCaptionViews() {
    contentView.addSubview(itemCaptionView)
    itemCaptionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        itemCaptionView.topAnchor.constraint(equalTo: itemStoresView.bottomAnchor),
        itemCaptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        itemCaptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        itemCaptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
    ])
}
*/


/*
//VIEW: Divider
private func setupDividerView() {
    contentView.addSubview(dividerView)
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        dividerView.topAnchor.constraint(equalTo: itemCaptionView.bottomAnchor),
        dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        dividerView.heightAnchor.constraint(equalToConstant: 2),
        dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
}

*/



/*
 
 //WISHLIST: Item
 class GroupItemUserCell: UITableViewCell {
     
     //MAIN VIEWS
     let itemView = UIView()
     let itemInfoView = componentFunctions.createUIView(backgroundColor: UIColor.systemBlue)
     let itemPurchasedView = componentFunctions.createUIView(backgroundColor: UIColor.systemGreen)
     let itemStoresView = componentFunctions.createUIView(backgroundColor: UIColor.systemOrange)
     let itemCaptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemPurple)
     let dividerView = componentFunctions.createUIView(backgroundColor: UIColor.black)
     
     // Subviews
     let itemImageView = componentFunctions.createUIView(backgroundColor: UIColor.systemPink)
     let itemDescriptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemTeal)
     
     // Add these new UI elements
     private let productImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.backgroundColor = .lightGray // placeholder background
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         return imageView
     }()

     private let purchaseButton: UIButton = {
         let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Purchase Me", for: .normal)
         button.backgroundColor = .systemBlue
         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 8
         return button
     }()


     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupPostViews()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
         purchaseButton.addTarget(self, action: #selector(didTapPurchase), for: .touchUpInside)

     }

     //CELL SETUP
     func configurePost(with item: Item) {
         // Print item information
         print("=== IndividualGroupPostCell configurePost ===")
         print("=== Item Information ===")
         print("postID: \(item.postID)")
         print("groupID: \(item.groupID)")
         print("postCaption: \(item.postCaption ?? "nil")")
         print("fileURL: \(item.fileUrl ?? "nil")")
         print("item_name: \(item.itemName ?? "nil")")
         print("========================")
         
         // Set the item image (already downloaded by addPostImageToItemsArray)
         productImageView.image = item.postImageData ?? UIImage(named: "background_1")
     }
     
   
     // Setup Entry Point
     private func setupPostViews() {
         setupItemInfoViews()
         setupItemPurchasedViews()
         setupItemStoreViews()
         setupItemCaptionViews()
         setupDividerView()
     }
     
     
     //VIEW: Item Info
     private func setupItemInfoViews() {
         contentView.addSubview(itemInfoView)
         itemInfoView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             itemInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
             itemInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             itemInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             itemInfoView.heightAnchor.constraint(equalToConstant: 240)
         ])
         
         // Add subviews inside itemInfoView
         itemInfoView.addSubview(itemImageView)
         itemInfoView.addSubview(itemDescriptionView)
         
         itemImageView.translatesAutoresizingMaskIntoConstraints = false
         itemDescriptionView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             // itemImageView: fixed width, left, vertically centered
             itemImageView.leadingAnchor.constraint(equalTo: itemInfoView.leadingAnchor, constant: 12),
             itemImageView.centerYAnchor.constraint(equalTo: itemInfoView.centerYAnchor),
             itemImageView.widthAnchor.constraint(equalToConstant: 160),
             itemImageView.heightAnchor.constraint(equalTo: itemInfoView.heightAnchor, multiplier: 0.8),
             
             // itemDescriptionView: fills remaining space
             itemDescriptionView.topAnchor.constraint(equalTo: itemInfoView.topAnchor, constant: 12),
             itemDescriptionView.bottomAnchor.constraint(equalTo: itemInfoView.bottomAnchor, constant: -12),
             itemDescriptionView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
             itemDescriptionView.trailingAnchor.constraint(equalTo: itemInfoView.trailingAnchor, constant: -12)
         ])
         
         //Item Image and Button
         itemImageView.addSubview(productImageView)
         itemImageView.addSubview(purchaseButton)

         // Product image constraints
         NSLayoutConstraint.activate([
             productImageView.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 8),
             productImageView.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
             productImageView.widthAnchor.constraint(equalToConstant: 160),
             productImageView.heightAnchor.constraint(equalToConstant: 120),
             
             // Button below image
             purchaseButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
             purchaseButton.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
             purchaseButton.widthAnchor.constraint(equalToConstant: 140),
             purchaseButton.heightAnchor.constraint(equalToConstant: 40),
             purchaseButton.bottomAnchor.constraint(lessThanOrEqualTo: itemImageView.bottomAnchor, constant: -8)
         ])

     }
     
     
     //VIEW: Item Purchased Info
     private func setupItemPurchasedViews() {
         contentView.addSubview(itemPurchasedView)
         itemPurchasedView.translatesAutoresizingMaskIntoConstraints = false
         
         // Add temporary label to distinguish user cell
         let userLabel = UILabel()
         userLabel.text = "Current User"
         userLabel.font = UIFont.boldSystemFont(ofSize: 16)
         userLabel.textColor = .white
         userLabel.textAlignment = .center
         userLabel.translatesAutoresizingMaskIntoConstraints = false
         itemPurchasedView.addSubview(userLabel)
         
         NSLayoutConstraint.activate([
             itemPurchasedView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor),
             itemPurchasedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             itemPurchasedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             itemPurchasedView.heightAnchor.constraint(equalToConstant: 40),
             
             // Label constraints
             userLabel.centerXAnchor.constraint(equalTo: itemPurchasedView.centerXAnchor),
             userLabel.centerYAnchor.constraint(equalTo: itemPurchasedView.centerYAnchor)
         ])
     }
     
     
     //VIEW: Item Store Links
     private func setupItemStoreViews() {
         contentView.addSubview(itemStoresView)
         itemStoresView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             itemStoresView.topAnchor.constraint(equalTo: itemPurchasedView.bottomAnchor),
             itemStoresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             itemStoresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             itemStoresView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
         ])
     }
     
     
     //VIEW: Caption
     private func setupItemCaptionViews() {
         contentView.addSubview(itemCaptionView)
         itemCaptionView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             itemCaptionView.topAnchor.constraint(equalTo: itemStoresView.bottomAnchor),
             itemCaptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             itemCaptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             itemCaptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
         ])
     }
     
     
     //VIEW: Divider
     private func setupDividerView() {
         contentView.addSubview(dividerView)
         dividerView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             dividerView.topAnchor.constraint(equalTo: itemCaptionView.bottomAnchor),
             dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             dividerView.heightAnchor.constraint(equalToConstant: 2),
             dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ])
     }
     
     //ACTIONS
     @objc private func didTapPurchase() {
         print("purchased")
     }


 }

 */
