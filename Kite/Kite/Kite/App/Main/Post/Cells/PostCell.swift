//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/22/26.
//

import UIKit

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class PostCell: UITableViewCell {

    //UI COMPONENTS
    //Kite
    //private let postHeader = PostHeader()
    //private let postImage = PostImage()
    //private let postCaption = PostCaption()
    //private let postSocials = PostSocials()
    //private let mainDivider = MainDivider()
    
    //Wishlist
    private let itemHeader = ItemHeader()
    private let itemBody = ItemBody()
    private let postSocials = PostSocials()
    private let mainDivider = MainDivider()


    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Kite
        //setupPost()

        //Wishlist
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Kite
    /*
    private func setupPost() {
        [postHeader, postImage, postCaption, postSocials, mainDivider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            postHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            postHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.topAnchor.constraint(equalTo: postHeader.bottomAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postCaption.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postSocials.topAnchor.constraint(equalTo: postCaption.bottomAnchor),
            postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
            mainDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    */

    //Wishlist
    // ItemHeader
    // ItemBody
    // PostSocials
    // MainDivider
    private func setupItem() {
        [itemHeader, itemBody, postSocials, mainDivider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            itemHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postSocials.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
            postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            mainDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
            mainDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    //Configure socials with post so like count (and later like action) use live data.
    func configure(postID: Int) {
        postSocials.configure(postID: postID)
    }

    func updatePost(with post: Post) {
        postSocials.configure(postID: post.postID)
    }

    func updateItem(with post: Post) {
        postSocials.configure(postID: post.postID)
    }
}





/*
final class PostCell: UITableViewCell {

    
    
    //LOGIC
    private let postDataController = PostDataController.shared
    private var postID: Int?

    //UI COMPONENTS
    private let layout = ItemCellLayout()
    //Post will include
    //Socials
    //Caption
    //Comments will not be here but will be pulled in

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(layout)
        layout.translatesAutoresizingMaskIntoConstraints = false


    override func prepareForReuse() {
        super.prepareForReuse()
        postID = nil
        layout.resetImageLayout()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //ACTIONS
    func configurePostCell(postID: Int) {
        self.postID = postID
        refreshPostCellUI()
    }

    //FUNCTIONS
    @objc private func purchaseTapped() {
        print("purchase")
    }

    @objc private func likeTapped() {
        guard
            let postID,
            let post = postDataController.getPostByID(postID: postID)
        else { return }

        let groupID = post.groupID ?? 0
        Task { await PostLogic.shared.toggleLike(post: post, groupID: groupID) }
    }

    private func refreshPostCellUI() {
        guard
            let postID,
            let post = postDataController.getPostByID(postID: postID)
        else { return }

        layout.apply(post: post)
    }

    @objc private func handlePostUpdated(_ notification: Notification) {
        guard
            let updatedPostID = notification.object as? Int,
            updatedPostID == postID
        else { return }

        refreshPostCellUI()
    }
     
     
        NSLayoutConstraint.activate([
            layout.topAnchor.constraint(equalTo: contentView.topAnchor),
            layout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            layout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            layout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

   
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated),
            name: .postUpdated,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
