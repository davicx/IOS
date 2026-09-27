//
//  PostImage.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class PostImage: UIView {

    //UI COMPONENTS
    let postImageView = UIImageView()
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageZeroHeightConstraint: NSLayoutConstraint?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        setupImageView()
    }

    private func setupImageView() {
        ImageStyle.postImage(imageView: postImageView)

        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        updatePostImage(nil)
    }

    //FUNCTIONS
    func configure(with post: Post) {
        updatePostImage(post.postImageData)
    }

    private func updatePostImage(_ image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageZeroHeightConstraint?.isActive = false

        guard let image, image.size.width > 0 else {
            postImageView.image = nil
            imageZeroHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
            imageZeroHeightConstraint?.isActive = true
            return
        }

        postImageView.image = image
        let aspectRatio = image.size.height / image.size.width
        imageAspectRatioConstraint = postImageView.heightAnchor.constraint(
            equalTo: postImageView.widthAnchor,
            multiplier: aspectRatio
        )
        imageAspectRatioConstraint?.isActive = true
    }
}
