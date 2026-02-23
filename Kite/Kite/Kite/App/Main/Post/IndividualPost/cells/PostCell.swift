//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/22/26.
//

import UIKit


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
}
