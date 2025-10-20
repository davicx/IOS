//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//

import UIKit


//WISHLIST: Item
class IndividualGroupPostCell: UITableViewCell {
    
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
    //SO HERE WE NEED TO USE POST
    // func configurePost(with post: Post) {
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
        
        NSLayoutConstraint.activate([
            itemPurchasedView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor),
            itemPurchasedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemPurchasedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemPurchasedView.heightAnchor.constraint(equalToConstant: 40)
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




//KITE: Post
/*
protocol PostCellDelegate: AnyObject {
    func didTapLikePostButton(in cell: IndividualPostCell)
}


//Single Post: This is a post you click on and are viewing a Single Post
class IndividualPostCell: UITableViewCell {
    weak var delegate: PostCellDelegate?

    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let likeStackView = UIStackView()
    let dividerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostViews()
        setupButtonTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //ACTIONS
    func setupButtonTarget() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    @objc private func likeButtonTapped() {
        delegate?.didTapLikePostButton(in: self)
    }

    //CELL SETUP
    func configurePost(with post: Post) {
        postImage.image = post.postImageData ?? UIImage(named: Constants.Image.fallbackPostImage)
        postCaptionLabel.text = post.postCaption
        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"

        let imageName = post.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    
        stopLoading()

    }    
    
    //FUNCTIONS
    func startLoading() {
        likeButton.isEnabled = false
    }

    func stopLoading() {
        likeButton.isEnabled = true
    }
    
    //STYLE
    private func setupPostViews() {
        contentView.addSubview(postImage)
        contentView.addSubview(postCaptionLabel)
        contentView.addSubview(likeStackView)
        contentView.addSubview(dividerView)

        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false

        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.font = .systemFont(ofSize: 16)
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.font = .systemFont(ofSize: 18)
        likeCountLabel.textAlignment = .center

        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        likeStackView.axis = .horizontal
        likeStackView.distribution = .fillEqually
        likeStackView.spacing = 8
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.addArrangedSubview(likeCountLabel)
        likeStackView.addArrangedSubview(likeButton)
        likeStackView.addArrangedSubview(activityIndicator)

        dividerView.backgroundColor = .blue
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //postImage.heightAnchor.constraint(equalToConstant: 400),

            postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),

            likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
            likeStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            likeStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            likeStackView.heightAnchor.constraint(equalToConstant: 40),

            dividerView.topAnchor.constraint(equalTo: likeStackView.bottomAnchor, constant: 8),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

}

*/


//APPENDIX

/*
class IndividualPostCell: UITableViewCell {
    
    //MAIN VIEWS
    let itemView = UIView()
    let itemInfoView = componentFunctions.createUIView(backgroundColor: UIColor.systemBlue)
    let itemPurchasedView = componentFunctions.createUIView(backgroundColor: UIColor.systemGreen)
    let itemStoresView = componentFunctions.createUIView(backgroundColor: UIColor.systemOrange)
    let itemCaptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemPurple)
    let dividerView = componentFunctions.createUIView(backgroundColor: UIColor.black)
    
    //Subviews
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //CELL SETUP - This method is commented out to avoid conflicts
    /*
    func configurePost(with post: Post) {
        // posts
    }
    
    
    //MARK: - Setup Entry Point
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
    }
    
    
    //VIEW: Item Purchased Info
    private func setupItemPurchasedViews() {
        contentView.addSubview(itemPurchasedView)
        itemPurchasedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemPurchasedView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor),
            itemPurchasedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemPurchasedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemPurchasedView.heightAnchor.constraint(equalToConstant: 40)
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
}

*/
    
    //VIEW: Item Purchased Info
    //VIEW: Item Store Links
    //VIEW: Caption
    //VIEW: Divider
    

