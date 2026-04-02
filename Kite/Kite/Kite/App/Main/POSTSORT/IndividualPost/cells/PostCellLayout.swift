//
//  PostCellLayout.swift
//  Kite
//
//  Created by David Vasquez on 1/20/26.
//

import UIKit


final class PostCellLayout: UIView {

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
