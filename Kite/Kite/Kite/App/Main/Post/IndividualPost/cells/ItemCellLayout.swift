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
    //TO DO: Add footer subviews (purchase button, like button, etc.)
    

    //LOGIC
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?
    private var isPurchased = false


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

        setupItemBodyLeftView()
        setupItemBodyRightView()
    }
    
    private func setupItemBodyLeftView () {
        ItemBodyView.addSubview(ItemBodyLeftView)
        ItemBodyLeftView.translatesAutoresizingMaskIntoConstraints = false

        // Create these with different colors
        ItemBodyLeftImageView.backgroundColor = .systemBlue
        ItemBodyLeftPurchasedView.backgroundColor = .systemOrange
        ItemBodyLeftView.addSubview(ItemBodyLeftImageView)
        ItemBodyLeftView.addSubview(ItemBodyLeftPurchasedView)
        ItemBodyLeftImageView.translatesAutoresizingMaskIntoConstraints = false
        ItemBodyLeftPurchasedView.translatesAutoresizingMaskIntoConstraints = false

        // Add UIImageView to ItemBodyLeftImageView - as wide as container, height scales proportionally
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        itemImageView.backgroundColor = .systemGray6
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
        ItemBodyRightView.backgroundColor = .systemTeal
        ItemBodyView.addSubview(ItemBodyRightView)
        ItemBodyRightView.translatesAutoresizingMaskIntoConstraints = false

        // Name: 2 lines, tail truncation
        itemNameLabel.text = "Item Name"
        itemNameLabel.font = Style.itemNameFont
        itemNameLabel.textColor = .label
        itemNameLabel.numberOfLines = 2
        itemNameLabel.lineBreakMode = .byTruncatingTail

        // Price: 1 line, tail truncation
        itemPriceLabel.text = "$0.00"
        itemPriceLabel.font = Style.itemPriceFont
        itemPriceLabel.textColor = .secondaryLabel
        itemPriceLabel.numberOfLines = 1
        itemPriceLabel.lineBreakMode = .byTruncatingTail

        // Description: 5 lines, tail truncation, text shrinks down to ~75% (min ~10.5pt)
        itemDescriptionLabel.text = "Item description goes here. Default placeholder text for the item body right view."
        itemDescriptionLabel.font = Style.itemDescriptionFont
        itemDescriptionLabel.textColor = .secondaryLabel
        itemDescriptionLabel.numberOfLines = 5
        itemDescriptionLabel.lineBreakMode = .byTruncatingTail
        itemDescriptionLabel.adjustsFontSizeToFitWidth = true
        itemDescriptionLabel.minimumScaleFactor = 0.75
        itemDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        // Link: 1 line, middle truncation
        itemLinkLabel.text = "www.example.com"
        itemLinkLabel.font = Style.itemLinkFont
        itemLinkLabel.textColor = .systemBlue
        itemLinkLabel.numberOfLines = 1
        itemLinkLabel.lineBreakMode = .byTruncatingMiddle

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

    //ACTIONS
    @objc private func purchaseTapped() {
        isPurchased.toggle()
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

    //FUNCTIONS
    func apply(image: UIImage?) {
        itemImageView.image = image
        updateImageAspectRatioConstraint(for: image)
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
        isPurchased = false
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.setTitleColor(UIColor(hex: "#343434"), for: .normal)
        purchaseButton.layer.borderColor = UIColor(hex: "#C7C7C7").cgColor
        itemNameLabel.text = "Item Name"
        itemPriceLabel.text = "$0.00"
        itemDescriptionLabel.text = "Item description goes here. Default placeholder text for the item body right view."
        itemLinkLabel.text = "www.example.com"
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
