//
//  ItemCellLayout.swift
//  Kite
//
//  Created by David Vasquez on 1/27/26.
//

import UIKit


final class ItemCellLayout: UIView {

    //UI COMPONENTS
    //Main Components
    let ItemHeaderView = UIView()
    let ItemBodyView = UIView()
    let ItemFooterView = UIView()
    
    //Header
    //TO DO: Add header subviews (group image, group name, user, etc.)
    
    
    //Body
    let ItemBodyLeftView = UIView()
    let ItemBodyRightView = UIView()
    let ItemBodyLeftImageView = UIView()
    let itemImageView = UIImageView()
    let ItemBodyLeftPurchasedView = UIView()
    let purchaseButton = UIButton(type: .system)
    let itemNameLabel = UILabel()
    let itemPriceLabel = UILabel()
    let itemDescriptionLabel = UILabel()
    let itemLinkLabel = UILabel()
    
    //Footer
    let postCaptionTemplate = PostCaptionTemplate()

    //TEMPORARY: Permission debug (current user, purchased, who can see)
    private let purchasedPermissionDebugView = UIView()
    private let purchasedPermissionDebugLabel = UILabel()

    //LOGIC
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?
    private var isPurchased = false
    private var postID: Int?
    private var isPurchaseInProgress = false
    private let spinnerHelper = SpinnerHelper()
    /// When true, current user created this list: hide purchase button and purchase info. Default true (safe).
    var currentUserOwnsGroup: Bool = true

    private var postDataController: PostDataController { PostDataController.shared }


    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderViews()
        setupBodyViews()
        setupFooterViews()
        setupPurchasedPermissionDebugView()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT
    //Layout: Header
    private func setupHeaderViews() {
        //TO DO: Replace with Style colors for production
        ItemHeaderView.backgroundColor = .systemPink
        ItemHeaderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemHeaderView)

        NSLayoutConstraint.activate([
            ItemHeaderView.topAnchor.constraint(equalTo: topAnchor),
            ItemHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemHeaderView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //Layout: Body
    private func setupBodyViews() {
        //TO DO: Replace with Style colors for production
        ItemBodyView.backgroundColor = .clear
        ItemBodyView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemBodyView)

        NSLayoutConstraint.activate([
            ItemBodyView.topAnchor.constraint(equalTo: ItemHeaderView.bottomAnchor),
            ItemBodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemBodyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        ItemBodyView.setContentHuggingPriority(.defaultLow, for: .vertical)

        setupItemBodyLeftView()
        setupItemBodyRightView()
    }
    
    private func setupItemBodyLeftView () {
        ItemBodyView.addSubview(ItemBodyLeftView)
        ItemBodyLeftView.translatesAutoresizingMaskIntoConstraints = false

        // Create these with different colors
        ItemBodyLeftImageView.backgroundColor = .clear
        ItemBodyLeftPurchasedView.backgroundColor = .clear
        ItemBodyLeftView.addSubview(ItemBodyLeftImageView)
        ItemBodyLeftView.addSubview(ItemBodyLeftPurchasedView)
        ItemBodyLeftImageView.translatesAutoresizingMaskIntoConstraints = false
        ItemBodyLeftPurchasedView.translatesAutoresizingMaskIntoConstraints = false

        // Add UIImageView to ItemBodyLeftImageView - as wide as container, height scales proportionally
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        itemImageView.backgroundColor = .clear
        ItemBodyLeftImageView.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false

        // Add purchase button to ItemBodyLeftPurchasedView - 80x36, centered vert and horiz
        purchaseButton.setTitle("Purchase", for: .normal)
        Buttons.styleNotSelectedButton(purchaseButton, width: 80, height: 36)
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        ItemBodyLeftPurchasedView.addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            ItemBodyLeftView.leadingAnchor.constraint(equalTo: ItemBodyView.leadingAnchor),
            ItemBodyLeftView.topAnchor.constraint(equalTo: ItemBodyView.topAnchor),
            ItemBodyLeftView.bottomAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemBodyLeftView.widthAnchor.constraint(equalToConstant: 180),
            ItemBodyLeftView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),

            ItemBodyLeftImageView.topAnchor.constraint(equalTo: ItemBodyLeftView.topAnchor),
            ItemBodyLeftImageView.leadingAnchor.constraint(equalTo: ItemBodyLeftView.leadingAnchor),
            ItemBodyLeftImageView.trailingAnchor.constraint(equalTo: ItemBodyLeftView.trailingAnchor),
            ItemBodyLeftImageView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),

            itemImageView.topAnchor.constraint(equalTo: ItemBodyLeftImageView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: ItemBodyLeftImageView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: ItemBodyLeftImageView.trailingAnchor),

            ItemBodyLeftPurchasedView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            ItemBodyLeftPurchasedView.leadingAnchor.constraint(equalTo: ItemBodyLeftView.leadingAnchor),
            ItemBodyLeftPurchasedView.trailingAnchor.constraint(equalTo: ItemBodyLeftView.trailingAnchor),
            ItemBodyLeftPurchasedView.bottomAnchor.constraint(equalTo: ItemBodyLeftView.bottomAnchor),
            ItemBodyLeftPurchasedView.heightAnchor.constraint(equalToConstant: 60),

            purchaseButton.centerXAnchor.constraint(equalTo: ItemBodyLeftPurchasedView.centerXAnchor),
            purchaseButton.centerYAnchor.constraint(equalTo: ItemBodyLeftPurchasedView.centerYAnchor)
        ])
        updateImageAspectRatioConstraint(for: nil)
    }
    
    private func setupItemBodyRightView () {
        // Move correct code from setupBodyViews() here
        //TO DO: Replace with Style colors for production
        ItemBodyRightView.backgroundColor = .clear
        ItemBodyView.addSubview(ItemBodyRightView)
        ItemBodyRightView.translatesAutoresizingMaskIntoConstraints = false

        Style.styleItemNameLabel(itemNameLabel)
        itemNameLabel.text = "Item Name"

        Style.styleItemPriceLabel(itemPriceLabel)
        itemPriceLabel.text = "$0.00"

        Style.styleItemDescriptionLabel(itemDescriptionLabel)
        itemDescriptionLabel.text = "Item description goes here. Default placeholder text for the item body right view."

        Style.styleItemLinkLabel(itemLinkLabel)
        itemLinkLabel.text = "www.example.com"

        ItemBodyRightView.addSubview(itemNameLabel)
        ItemBodyRightView.addSubview(itemPriceLabel)
        ItemBodyRightView.addSubview(itemDescriptionLabel)
        ItemBodyRightView.addSubview(itemLinkLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLinkLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ItemBodyRightView.leadingAnchor.constraint(equalTo: ItemBodyLeftView.trailingAnchor),
            ItemBodyRightView.trailingAnchor.constraint(equalTo: ItemBodyView.trailingAnchor),
            ItemBodyRightView.topAnchor.constraint(equalTo: ItemBodyView.topAnchor),
            ItemBodyRightView.bottomAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemBodyRightView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),

            itemNameLabel.topAnchor.constraint(equalTo: ItemBodyRightView.topAnchor, constant: 12),
            itemNameLabel.leadingAnchor.constraint(equalTo: ItemBodyRightView.leadingAnchor, constant: 12),
            itemNameLabel.trailingAnchor.constraint(equalTo: ItemBodyRightView.trailingAnchor, constant: -12),

            itemPriceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4),
            itemPriceLabel.leadingAnchor.constraint(equalTo: ItemBodyRightView.leadingAnchor, constant: 12),
            itemPriceLabel.trailingAnchor.constraint(equalTo: ItemBodyRightView.trailingAnchor, constant: -12),

            itemDescriptionLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: 8),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: ItemBodyRightView.leadingAnchor, constant: 12),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: ItemBodyRightView.trailingAnchor, constant: -12),

            itemLinkLabel.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: 8),
            itemLinkLabel.leadingAnchor.constraint(equalTo: ItemBodyRightView.leadingAnchor, constant: 12),
            itemLinkLabel.trailingAnchor.constraint(equalTo: ItemBodyRightView.trailingAnchor, constant: -12),
            itemLinkLabel.bottomAnchor.constraint(lessThanOrEqualTo: ItemBodyRightView.bottomAnchor, constant: -12)
        ])
    }

    //Layout: Footer
    private func setupFooterViews() {
        //TO DO: Replace with Style colors for production
        ItemFooterView.backgroundColor = .clear
        ItemFooterView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemFooterView)

        ItemFooterView.addSubview(postCaptionTemplate)
        postCaptionTemplate.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ItemFooterView.topAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemFooterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemFooterView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56),

            postCaptionTemplate.topAnchor.constraint(equalTo: ItemFooterView.topAnchor),
            postCaptionTemplate.leadingAnchor.constraint(equalTo: ItemFooterView.leadingAnchor),
            postCaptionTemplate.trailingAnchor.constraint(equalTo: ItemFooterView.trailingAnchor),
            postCaptionTemplate.bottomAnchor.constraint(equalTo: ItemFooterView.bottomAnchor)
        ])
        ItemFooterView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    //TEMPORARY: Permission debug view
    private func setupPurchasedPermissionDebugView() {
        purchasedPermissionDebugView.backgroundColor = UIColor.systemGray5
        purchasedPermissionDebugView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(purchasedPermissionDebugView)

        purchasedPermissionDebugLabel.numberOfLines = 0
        purchasedPermissionDebugLabel.font = .systemFont(ofSize: 11)
        purchasedPermissionDebugLabel.textColor = .secondaryLabel
        purchasedPermissionDebugLabel.translatesAutoresizingMaskIntoConstraints = false
        purchasedPermissionDebugView.addSubview(purchasedPermissionDebugLabel)

        NSLayoutConstraint.activate([
            purchasedPermissionDebugView.topAnchor.constraint(equalTo: ItemFooterView.bottomAnchor),
            purchasedPermissionDebugView.leadingAnchor.constraint(equalTo: leadingAnchor),
            purchasedPermissionDebugView.trailingAnchor.constraint(equalTo: trailingAnchor),
            purchasedPermissionDebugView.bottomAnchor.constraint(equalTo: bottomAnchor),

            purchasedPermissionDebugLabel.topAnchor.constraint(equalTo: purchasedPermissionDebugView.topAnchor, constant: 6),
            purchasedPermissionDebugLabel.leadingAnchor.constraint(equalTo: purchasedPermissionDebugView.leadingAnchor, constant: 12),
            purchasedPermissionDebugLabel.trailingAnchor.constraint(equalTo: purchasedPermissionDebugView.trailingAnchor, constant: -12),
            purchasedPermissionDebugLabel.bottomAnchor.constraint(lessThanOrEqualTo: purchasedPermissionDebugView.bottomAnchor, constant: -6)
        ])
    }

    //ACTIONS
    @objc private func purchaseTapped() {
        guard let post = postDataController.getPostByID(postID: postID ?? 0) else { return }
        guard !isPurchaseInProgress else { return }

        let isPurchased = (post.purchased ?? 0) != 0
        if isPurchased {
            // State 1: Already purchased → remove purchase (existing flow)
            isPurchaseInProgress = true
            purchaseButton.isUserInteractionEnabled = false
            spinnerHelper.show(in: self, delay: 0)
            Task {
                let groupID = post.groupID ?? 0
                await PostLogic.shared.removeItem(post: post, groupID: groupID)
                DispatchQueue.main.async { [weak self] in
                    self?.spinnerHelper.hide()
                    self?.purchaseButton.isUserInteractionEnabled = true
                    self?.isPurchaseInProgress = false
                }
            }
            return
        }

        // State 2: Not purchased → present who-can-see sheet
        guard let presentingVC = findViewController() else { return }
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        guard let itemPurchaseVC = storyboard.instantiateViewController(withIdentifier: "ItemPurchaseViewControllerID") as? ItemPurchaseViewController else { return }
        itemPurchaseVC.post = post
        itemPurchaseVC.groupID = post.groupID
        itemPurchaseVC.modalPresentationStyle = .pageSheet
        presentingVC.present(itemPurchaseVC, animated: true)
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let vc = responder as? UIViewController { return vc }
        }
        return nil
    }

    //FUNCTIONS
    func apply(post: Post) {
        self.postID = post.postID
        itemImageView.image = post.postImageData
        updateImageAspectRatioConstraint(for: post.postImageData)

        itemNameLabel.text = post.itemName?.isEmpty == false ? post.itemName : "Item Name"
        itemPriceLabel.text = formatPrice(post.itemPrice)
        itemDescriptionLabel.text = post.itemDescription?.isEmpty == false ? post.itemDescription : "add a description here"
        itemLinkLabel.text = post.itemLink?.isEmpty == false ? post.itemLink : "www.example.com"

        postCaptionTemplate.apply(post: post)

        let purchased = (post.purchased ?? 0) != 0
        updatePurchaseButton(isPurchased: purchased)
        purchaseButton.isHidden = postDataController.currentUserOwnsGroupForDisplay

        //TEMPORARY: Populate permission debug text
        let currentUser = postDataController.currentUser
        let purchasedText = purchased ? "Yes" : "No"
        let viewersList = post.purchasedViewers ?? []
        let viewersText = viewersList.isEmpty ? "[]" : viewersList.joined(separator: ", ")
        purchasedPermissionDebugLabel.text = "Current user: \(currentUser)\nPurchased: \(purchasedText)\nWho can see: \(viewersText)"

        printPurchaseState(post: post, currentUser: currentUser)
    }

    private func printPurchaseState(post: Post, currentUser: String) {
        let currentUserOwnsGroup = postDataController.currentUserOwnsGroupForDisplay
        if currentUserOwnsGroup {
            print("current user created this list so dont show Purchase info or button")
            return
        }
        let purchased = (post.purchased ?? 0) != 0
        if !purchased {
            print("current user did not create this list and item is not purchased (they can purchase)")
            return
        }
        let viewers = post.purchasedViewers ?? []
        let canViewPurchaseInfo = viewers.contains(currentUser)
        if canViewPurchaseInfo {
            print("current user did not create this list and item is purchased and they are allowed to view purchase information")
        } else {
            print("current user did not create this list and item is purchased but they are not allowed to view purchase information")
        }
    }

    private func updatePurchaseButton(isPurchased: Bool) {
        self.isPurchased = isPurchased
        if isPurchased {
            purchaseButton.setTitle("Purchased", for: .normal)
            purchaseButton.setTitleColor(UIColor(hex: "#008300"), for: .normal)
            purchaseButton.layer.borderColor = UIColor(hex: "#008300").cgColor
        } else {
            purchaseButton.setTitle("Purchase", for: .normal)
            purchaseButton.setTitleColor(UIColor(hex: "#343434"), for: .normal)
            purchaseButton.layer.borderColor = UIColor(hex: "#C7C7C7").cgColor
        }
    }

    private func updateImageAspectRatioConstraint(for image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageHeightConstraint?.isActive = false

        if let image = image {
            let aspectRatio = image.size.height / image.size.width
            imageAspectRatioConstraint = itemImageView.heightAnchor.constraint(
                equalTo: itemImageView.widthAnchor,
                multiplier: aspectRatio
            )
            imageAspectRatioConstraint?.priority = .defaultHigh
            imageAspectRatioConstraint?.isActive = true
        } else {
            imageHeightConstraint = itemImageView.heightAnchor.constraint(equalToConstant: 0)
            imageHeightConstraint?.isActive = true
        }
    }
    
    func resetImageLayout() {
        imageAspectRatioConstraint?.isActive = false
        imageHeightConstraint?.isActive = false
        imageAspectRatioConstraint = nil
        imageHeightConstraint = nil
        itemImageView.image = nil
        updateImageAspectRatioConstraint(for: nil)
        postID = nil
        isPurchaseInProgress = false
        updatePurchaseButton(isPurchased: false)
        purchaseButton.isHidden = true
        itemNameLabel.text = "Item Name"
        itemPriceLabel.text = "$0.00"
        itemDescriptionLabel.text = "Item description goes here. Default placeholder text for the item body right view."
        itemLinkLabel.text = "www.example.com"
        postCaptionTemplate.setPlaceholder()
    }

}



/*
final class ItemCellLayout: UIView {

    //UI COMPONENTS
    let ItemHeaderView = UIView()
    let ItemBodyView = UIView()
    let ItemBodyLeftView = UIView()
    let ItemBodyRightView = UIView()
    let ItemFooterView = UIView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderViews()
        setupBodyViews()
        setupFooterViews()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT: Header
    private func setupHeaderViews() {
        ItemHeaderView.backgroundColor = .systemPink
        ItemHeaderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemHeaderView)

        NSLayoutConstraint.activate([
            ItemHeaderView.topAnchor.constraint(equalTo: topAnchor),
            ItemHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemHeaderView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //LAYOUT: Body
    private func setupBodyViews() {
        ItemBodyView.backgroundColor = .systemGray6
        ItemBodyView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemBodyView)

        NSLayoutConstraint.activate([
            ItemBodyView.topAnchor.constraint(equalTo: ItemHeaderView.bottomAnchor),
            ItemBodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemBodyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        ItemBodyView.setContentHuggingPriority(.defaultLow, for: .vertical)

        //ItemBodyLeftView.backgroundColor = .systemBlue
        ItemBodyRightView.backgroundColor = .systemTeal
        ItemBodyView.addSubview(ItemBodyLeftView)
        ItemBodyView.addSubview(ItemBodyRightView)

        ItemBodyLeftView.translatesAutoresizingMaskIntoConstraints = false
        ItemBodyRightView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ItemBodyLeftView.leadingAnchor.constraint(equalTo: ItemBodyView.leadingAnchor),
            ItemBodyLeftView.topAnchor.constraint(equalTo: ItemBodyView.topAnchor),
            ItemBodyLeftView.bottomAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemBodyLeftView.widthAnchor.constraint(equalToConstant: 200),
            ItemBodyLeftView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),

            ItemBodyRightView.leadingAnchor.constraint(equalTo: ItemBodyLeftView.trailingAnchor),
            ItemBodyRightView.trailingAnchor.constraint(equalTo: ItemBodyView.trailingAnchor),
            ItemBodyRightView.topAnchor.constraint(equalTo: ItemBodyView.topAnchor),
            ItemBodyRightView.bottomAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemBodyRightView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220)
        ])
    }

    //LAYOUT: Footer
    private func setupFooterViews() {
        ItemFooterView.backgroundColor = .systemPurple
        ItemFooterView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ItemFooterView)

        NSLayoutConstraint.activate([
            ItemFooterView.topAnchor.constraint(equalTo: ItemBodyView.bottomAnchor),
            ItemFooterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ItemFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ItemFooterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ItemFooterView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
        ItemFooterView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    //FUNCTIONS
    func apply(image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        if let image = image {
            itemPostImageView.image = image
            let aspectRatio = image.size.height / image.size.width
            imageAspectRatioConstraint = itemPostImageView.heightAnchor.constraint(
                equalTo: itemPostImageView.widthAnchor,
                multiplier: aspectRatio
            )
            imageAspectRatioConstraint?.priority = .defaultHigh
        } else {
            itemPostImageView.image = nil
            imageAspectRatioConstraint = itemPostImageView.heightAnchor.constraint(equalToConstant: 0)
        }
        imageAspectRatioConstraint?.isActive = true
    }

    private static func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            color.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
        }
    }
}



*/


/*
final class ItemCellLayout: UIView {
    
    //UI COMPONENTS
    let itemImageView = UIView()
    let itemInfoView = UIView()
    let itemSocialsView = UIView()
    
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
        itemImageView.backgroundColor = .blue
        itemInfoView.backgroundColor = .systemPink
        addSubview(itemImageView)
        addSubview(itemInfoView)
    }
    
    private func setupLayout() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemSocialsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Left Item Image View - 200px wide, centered vertically, min height 220px
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 200),
            itemImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),
            
            // Right Item Info View - fills remaining space, centered vertically, min height 220px
            itemInfoView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemInfoView.topAnchor.constraint(equalTo: topAnchor),
            itemInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),
            
        ])
    }
}

*/
/*
final class ItemCellLayout: UIView {

    //UI COMPONENTS
    let postImageView = UIImageView()
    let captionLabel = UILabel()
    let likeCountLabel = UILabel()
    let likeButton = UIButton(type: .system)

    //LOGIC
    private var imageHeightConstraint: NSLayoutConstraint?
    private var imageAspectRatioConstraint: NSLayoutConstraint?

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
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = .systemGray6

        captionLabel.numberOfLines = 0
        captionLabel.font = .systemFont(ofSize: 16)

        likeCountLabel.font = .systemFont(ofSize: 14)
        likeCountLabel.textColor = .secondaryLabel

        likeButton.setTitle("Like", for: .normal)

        addSubview(postImageView)
        addSubview(captionLabel)
        addSubview(likeCountLabel)
        addSubview(likeButton)
    }

    private func setupLayout() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            likeCountLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 12),
            likeCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likeCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            likeButton.centerYAnchor.constraint(equalTo: likeCountLabel.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 12)
        ])
    }

    //ACTIONS
    
    //FUNCTIONS
    func apply(postCaption: String, likeCountText: String, isLiked: Bool, image: UIImage?) {
        captionLabel.text = postCaption
        likeCountLabel.text = likeCountText
        likeButton.setTitle(isLiked ? "Liked" : "Like", for: .normal)

        if let image = image {
            postImageView.image = image
            updateImageAspectRatioConstraint(for: image)
        } else {
            postImageView.image = nil
            updateImageAspectRatioConstraint(for: nil)
        }
    }

    private func updateImageAspectRatioConstraint(for image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageHeightConstraint?.isActive = false

        if let image = image {
            let aspectRatio = image.size.height / image.size.width
            imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
                equalTo: postImageView.widthAnchor,
                multiplier: aspectRatio
            )
            imageAspectRatioConstraint?.isActive = true
        } else {
            imageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
            imageHeightConstraint?.isActive = true
        }
    }
}

*/
