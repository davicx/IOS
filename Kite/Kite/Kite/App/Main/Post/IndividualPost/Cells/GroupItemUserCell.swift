//
//  GroupItemUserCell.swift
//  Kite
//
//  Created by David Vasquez on 10/21/25.
//

import UIKit


//WISHLIST: Item
class GroupItemUserCell: UITableViewCell {
    
    //MAIN VIEWS
    let itemView = UIView()
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //purchaseButton.addTarget(self, action: #selector(didTapPurchase), for: .touchUpInside)

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
    
    private func setupMainViews() {
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
    
    
    //ACTIONS
    @objc private func didTapPurchase() {
        print("purchased")
    }


}


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
