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
    private let postHeader = PostHeader()
    private let postImage = PostImage()
    //private let postCaption = PostCaption()
    private let postSocials = PostSocials()
    private let postDivider = MainDivider()


    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.feedBackground
        contentView.backgroundColor = .clear
   
        setupPost()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Kite
    private func setupPost() {
        [postHeader, postImage, postSocials, postDivider].forEach {
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

            postSocials.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
            postDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        // postCaption.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
        // postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        // postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        // postCaption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        // [postHeader, postImage, postCaption, postSocials, mainDivider].forEach {
        //     $0.translatesAutoresizingMaskIntoConstraints = false
        //     contentView.addSubview($0)
        // }
        // NSLayoutConstraint.activate([
        //     postHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
        //     postHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     postHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //     postImage.topAnchor.constraint(equalTo: postHeader.bottomAnchor),
        //     postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //     postCaption.topAnchor.constraint(equalTo: postImage.bottomAnchor),
        //     postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //     postSocials.topAnchor.constraint(equalTo: postCaption.bottomAnchor),
        //     postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //     mainDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
        //     mainDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     mainDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //     mainDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        // ])
    }

    
  

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let vc = responder as? UIViewController { return vc }
        }
        return nil
    }

    //Configure socials with post so like count (and later like action) use live data.
    func configure(postID: Int) {
        if let post = PostDataController.shared.getPostByID(postID: postID) {
            postHeader.configure(with: post)
            postImage.configure(with: post)
            postSocials.configure(postID: postID)
            //postCaption.configure(with: post)
        }
    }

    func updatePost(with post: Post) {
        postHeader.configure(with: post)
        postImage.configure(with: post)
        postSocials.configure(postID: post.postID)
        //postCaption.configure(with: post)
    }

}

