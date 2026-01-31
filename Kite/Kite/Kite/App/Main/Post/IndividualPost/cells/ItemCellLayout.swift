//
//  ItemCellLayout.swift
//  Kite
//
//  Created by David Vasquez on 1/27/26.
//

import UIKit


final class ItemCellLayout: UIView {

    //UI COMPONENTS
    let ItemHeaderView = UIView()
    let ItemBodyView = UIView()
    let ItemBodyLeftView = UIView()
    let ItemBodyRightView = UIView()
    let ItemFooterView = UIView()
    let purchaseButton = UIButton(type: .system)

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
        
        
        //BUTTON
        var config = UIButton.Configuration.filled()
        config.title = "Purchase"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium

        purchaseButton.configuration = config
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)

        // ⚠️ handler MUST come AFTER configuration is set
        purchaseButton.configurationUpdateHandler = { button in
            guard var config = button.configuration else { return }

            if button.state.contains(.highlighted) {
                config.baseBackgroundColor = .systemBlue.withAlphaComponent(0.6)
            } else {
                config.baseBackgroundColor = .systemBlue
            }

            button.configuration = config
        }

        ItemBodyLeftView.addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            purchaseButton.centerXAnchor.constraint(equalTo: ItemBodyLeftView.centerXAnchor),
            purchaseButton.centerYAnchor.constraint(equalTo: ItemBodyLeftView.centerYAnchor),
            purchaseButton.widthAnchor.constraint(equalToConstant: 80),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40)
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

    func apply(image: UIImage?) {}
    
    @objc private func purchaseTapped() {
        print("purchase")
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
