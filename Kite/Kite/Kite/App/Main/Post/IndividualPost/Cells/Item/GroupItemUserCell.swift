//
//  GroupItemUserCell.swift
//  Kite
//
//  Created by David Vasquez on 10/21/25.
//

import UIKit


//WISHLIST: Item
class GroupItemUserCell: UITableViewCell {
    
    // Current post reference
    private var currentPost: Post?
    private let spinnerHelper = SpinnerHelper()
    private var customSpinner: UIActivityIndicatorView?
    private var customSpinnerBackground: UIView?
    
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
    let likeItemImageView = UIView()
    let likeItemCountView = UIView()
    
    //UI Elements
    private let productImageView = UIImageView()
    private let itemNameLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemDescriptionTextView = UITextView()
    private let commentTemplate = CommentTemplate()
    private let purchaseButton = UIButton(type: .system)
    private let likeItemImage = UIImageView()
    private let likeItemCountLabel = UILabel()
    
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
        
        // Add like container views
        itemSocialsBarView.addSubview(likeItemImageView)
        itemSocialsBarView.addSubview(likeItemCountView)
        
        likeItemImageView.translatesAutoresizingMaskIntoConstraints = false
        likeItemCountView.translatesAutoresizingMaskIntoConstraints = false
        
        likeItemImageView.backgroundColor = UIColor.systemBlue
        likeItemCountView.backgroundColor = UIColor.systemOrange
        
        NSLayoutConstraint.activate([
            // likeItemCountView: Right centered, 8px from right margin, as tall as container, 40 min width, max 60 width
            likeItemCountView.trailingAnchor.constraint(equalTo: itemSocialsBarView.trailingAnchor, constant: -8),
            likeItemCountView.topAnchor.constraint(equalTo: itemSocialsBarView.topAnchor),
            likeItemCountView.bottomAnchor.constraint(equalTo: itemSocialsBarView.bottomAnchor),
            likeItemCountView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            likeItemCountView.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            
            // likeItemImageView: Right centered, touching likeItemCountView, as tall as container, 40 wide
            likeItemImageView.trailingAnchor.constraint(equalTo: likeItemCountView.leadingAnchor),
            likeItemImageView.topAnchor.constraint(equalTo: itemSocialsBarView.topAnchor),
            likeItemImageView.bottomAnchor.constraint(equalTo: itemSocialsBarView.bottomAnchor),
            likeItemImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // Add like image to likeItemImageView
        likeItemImage.image = UIImage(named: "like")
        likeItemImage.contentMode = .scaleAspectFit
        likeItemImage.translatesAutoresizingMaskIntoConstraints = false
        likeItemImageView.addSubview(likeItemImage)
        
        NSLayoutConstraint.activate([
            likeItemImage.centerXAnchor.constraint(equalTo: likeItemImageView.centerXAnchor),
            likeItemImage.centerYAnchor.constraint(equalTo: likeItemImageView.centerYAnchor),
            likeItemImage.widthAnchor.constraint(equalToConstant: 24),
            likeItemImage.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // Make likeItemImageView tappable
        likeItemImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLike))
        likeItemImageView.addGestureRecognizer(tapGesture)
        
        // Add count label to likeItemCountView
        likeItemCountLabel.text = "0"
        likeItemCountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        likeItemCountLabel.textColor = .label
        likeItemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeItemCountView.addSubview(likeItemCountLabel)
        
        NSLayoutConstraint.activate([
            likeItemCountLabel.centerXAnchor.constraint(equalTo: likeItemCountView.centerXAnchor),
            likeItemCountLabel.centerYAnchor.constraint(equalTo: likeItemCountView.centerYAnchor),
            likeItemCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: likeItemCountView.leadingAnchor, constant: 4),
            likeItemCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: likeItemCountView.trailingAnchor, constant: -4)
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
    func configurePost(with post: Post) {
        print("=== IndividualGroupPostCell configurePost ===")
        print("postID: \(post.postID)")
        
        // Store current post reference
        currentPost = post
        
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
        
        itemNameLabel.text = sanitizedText(post.itemName, fallback: fallbackName)
        
        let priceText = sanitizedText(post.itemPrice, fallback: fallbackPrice)
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
        
        itemDescriptionTextView.text = sanitizedText(post.itemDescription, fallback: fallbackDescription)
        
        let userName = sanitizedText(post.postFrom, fallback: "User")
        let commentText = sanitizedText(post.postCaption, fallback: fallbackComment)
        let userImage = post.postFromImageData ?? UIImage(named: "background_1")
        
        commentTemplate.configure(userName: userName, commentText: commentText, image: userImage)
        
        // Update like count and image
        updateLikeUI(with: post)
        
        if let image = post.postImageData {
            productImageView.image = image
        } else {
            productImageView.image = UIImage(named: "background_1") ?? UIImage()
        }
    }
    
    // MARK: - Update Like UI
    private func updateLikeUI(with post: Post) {
        // Update like count
        let likeCount = post.postLikesArray?.count ?? post.simpleLikesArray?.count ?? 0
        likeItemCountLabel.text = "\(likeCount)"
        
        // Update like image based on liked state
        if post.isLikedByCurrentUser == true {
            likeItemImage.image = UIImage(named: "liked")
        } else {
            likeItemImage.image = UIImage(named: "like")
        }
    }
    
    @objc private func didTapPurchase() {
        print("purchased")
    }
    
    @objc private func didTapMenu() {
        print("GroupItemUserCell: menu button tapped")
    }
    
    @objc private func didTapLike() {
        guard let post = currentPost else { return }
        
        // Disable interaction to prevent double-tapping
        likeItemImageView.isUserInteractionEnabled = false
        
        // Get window to show spinner centered on iPhone
        var targetView: UIView = self.contentView
        if let window = self.window {
            targetView = window
        } else if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            targetView = window
        }
        
        showCustomSpinner(in: targetView)
        
        Task {
            let groupID = post.groupID ?? 0
            
            if post.isLikedByCurrentUser == true {
                // Unlike
                if let likeModel = await postLikeFunctions.shared.unlikePost(post: post, groupID: groupID) {
                    PostDataController.shared.unlikePost(postID: post.postID, likeModel: likeModel)
                }
            } else {
                // Like
                if let likeModel = await postLikeFunctions.shared.likePost(post: post, groupID: groupID) {
                    PostDataController.shared.likePost(postID: post.postID, likeModel: likeModel)
                }
            }
            
            DispatchQueue.main.async {
                // Get updated post from PostDataController (single source of truth)
                let updatedPost = PostDataController.shared.getItemByID(postID: post.postID) ?? post
                
                // Update UI with new like state
                self.updateLikeUI(with: updatedPost)
                
                // Update current post reference
                self.currentPost = updatedPost
                
                // Hide spinner and re-enable interaction
                self.hideCustomSpinner()
                self.likeItemImageView.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: - Custom Spinner
    private func showCustomSpinner(in view: UIView) {
        hideCustomSpinner() // Clear any existing spinner
        
        // Create rounded black background box
        let backgroundBox = UIView()
        backgroundBox.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        backgroundBox.layer.cornerRadius = 12
        backgroundBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundBox)
        
        // Create spinner
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        backgroundBox.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            // Background box centered on screen, just bigger than spinner
            backgroundBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundBox.widthAnchor.constraint(equalToConstant: 100),
            backgroundBox.heightAnchor.constraint(equalToConstant: 100),
            
            // Spinner centered in background box
            spinner.centerXAnchor.constraint(equalTo: backgroundBox.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: backgroundBox.centerYAnchor)
        ])
        
        spinner.startAnimating()
        customSpinner = spinner
        customSpinnerBackground = backgroundBox
    }
    
    private func hideCustomSpinner() {
        customSpinner?.stopAnimating()
        customSpinner?.removeFromSuperview()
        customSpinner = nil
        
        customSpinnerBackground?.removeFromSuperview()
        customSpinnerBackground = nil
    }
    
    // MARK: - Menu Setup
    private func setupMenu() {
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [weak self] _ in
            self?.navigateToEditItem()
        }
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            print("GroupItemUserCell: Delete tapped")
        }
        
        let menu = UIMenu(title: "", children: [editAction, deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    // MARK: - Navigation
    private func navigateToEditItem() {
        guard let post = currentPost else {
            print("GroupItemUserCell: No post to edit")
            return
        }
        
        // Find the parent view controller
        guard let viewController = findViewController() else {
            print("GroupItemUserCell: Could not find parent view controller")
            return
        }
        
        // Small delay to allow menu to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Use the same pattern as other view controllers in the app
            let storyboard = UIStoryboard(name: "Post", bundle: nil)
            
            // Verify we can instantiate the view controller
            guard let editItemVC = storyboard.instantiateViewController(withIdentifier: "EditItemVCStoryboardID") as? EditItemViewController else {
                print("GroupItemUserCell: ERROR - Could not instantiate EditItemViewController")
                print("GroupItemUserCell: Storyboard name: Post")
                print("GroupItemUserCell: Storyboard ID: EditItemVCStoryboardID")
                return
            }
            
            editItemVC.currentPost = post
            
            // Verify navigation controller exists
            guard let navController = viewController.navigationController else {
                print("GroupItemUserCell: ERROR - No navigation controller found")
                return
            }
            
            navController.pushViewController(editItemVC, animated: true)
        }
    }
    
    // Helper to find parent view controller
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

