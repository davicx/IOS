//
//  ItemCell.swift
//  Kite
//
//  Created by David Vasquez on 4/5/26.
//

import UIKit

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemCell: UITableViewCell {

    //UI COMPONENTS
    private let postContent = PostContent()
    private let postCaption = PostCaption()
    private let postSocials = PostSocials()

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [postContent, postCaption, postSocials].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            postContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            postContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postCaption.topAnchor.constraint(equalTo: postContent.bottomAnchor),
            postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postSocials.topAnchor.constraint(equalTo: postCaption.bottomAnchor),
            postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postSocials.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configure socials with post so like count (and later like action) use live data.
    func configure(postID: Int) {
        postSocials.configure(postID: postID)

        if let post = PostDataController.shared.getPostByID(postID: postID) {
            postContent.configure(with: post)
        }
    }

    func updatePost(with post: Post) {
        postSocials.configure(postID: post.postID)
        postContent.configure(with: post)
    }

    func updateItem(with post: Post) {
        postSocials.configure(postID: post.postID)
        postContent.configure(with: post)
    }
}
