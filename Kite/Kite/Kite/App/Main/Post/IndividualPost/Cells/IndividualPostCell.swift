//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//

import UIKit


//WISHLIST: Item 
class IndividualPostCell: UITableViewCell {
    
    //MAIN VIEWS
    let itemView = UIView()
    let dividerView = UIView()
    
    // New views with different colors for layout testing
    let itemInfoView = componentFunctions.createUIView(backgroundColor: UIColor.systemBlue)
    let itemPurchasedView = componentFunctions.createUIView(backgroundColor: UIColor.systemGreen)
    let itemStoresView = componentFunctions.createUIView(backgroundColor: UIColor.systemOrange)
    let itemCaptionView = componentFunctions.createUIView(backgroundColor: UIColor.systemPurple)
    let itemDividerView = componentFunctions.createUIView(backgroundColor: UIColor.systemRed)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //CELL SETUP
    func configurePost(with post: Post) {

    }
    
    //VIEW: Item Info
    private func setupPostViews() {
        // Add all views to contentView
        contentView.addSubview(itemInfoView)
        contentView.addSubview(itemPurchasedView)
        contentView.addSubview(itemStoresView)
        contentView.addSubview(itemCaptionView)
        contentView.addSubview(itemDividerView)
        contentView.addSubview(dividerView)
        
        // Configure all views
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        itemPurchasedView.translatesAutoresizingMaskIntoConstraints = false
        itemStoresView.translatesAutoresizingMaskIntoConstraints = false
        itemCaptionView.translatesAutoresizingMaskIntoConstraints = false
        itemDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure DividerView
        dividerView.backgroundColor = .black
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // itemInfoView - 320 tall, blue
            itemInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemInfoView.heightAnchor.constraint(equalToConstant: 180),
            
            // itemPurchasedView - 60 tall, green
            itemPurchasedView.topAnchor.constraint(equalTo: itemInfoView.bottomAnchor),
            itemPurchasedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemPurchasedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemPurchasedView.heightAnchor.constraint(equalToConstant: 60),
            
            // itemStoresView - Dynamic height, default 40, orange
            itemStoresView.topAnchor.constraint(equalTo: itemPurchasedView.bottomAnchor),
            itemStoresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemStoresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemStoresView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            // itemCaptionView - Dynamic height, default 60, purple
            itemCaptionView.topAnchor.constraint(equalTo: itemStoresView.bottomAnchor),
            itemCaptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemCaptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemCaptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            // itemDividerView - 2 tall, red
            itemDividerView.topAnchor.constraint(equalTo: itemCaptionView.bottomAnchor),
            itemDividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemDividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemDividerView.heightAnchor.constraint(equalToConstant: 2),
   
            // DividerView constraints
            dividerView.topAnchor.constraint(equalTo: itemDividerView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    //VIEW: Item Purchased Info
    //VIEW: Item Store Links
    //VIEW: Caption
    //VIEW: Divider
    
    
}




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
