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
    //private let pageCounter = UILabel()
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
        backgroundColor = Colors.screenBackground
        setupImageView()
    }

    private func setupImageView() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = .clear
        addSubview(postImageView)

        // pageCounter.font = DesignStyleTemp.pageCounterFont
        // pageCounter.textColor = .white
        // pageCounter.textAlignment = .center
        // pageCounter.backgroundColor = DesignStyleTemp.pageCounterBackground
        // pageCounter.layer.cornerRadius = DesignStyleTemp.pageCounterHeight / 2
        // pageCounter.clipsToBounds = true
        // pageCounter.text = "  1/4  "
        // pageCounter.translatesAutoresizingMaskIntoConstraints = false
        // addSubview(pageCounter)

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: bottomAnchor)

            // pageCounter.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: DesignStyleTemp.pageCounterTop),
            // pageCounter.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: -DesignStyleTemp.pageCounterTrailing),
            // pageCounter.heightAnchor.constraint(equalToConstant: DesignStyleTemp.pageCounterHeight)
        ])
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
            imageZeroHeightConstraint = heightAnchor.constraint(equalToConstant: 0)
            imageZeroHeightConstraint?.isActive = true
            return
        }

        postImageView.image = image
        let aspectRatio = image.size.height / image.size.width
        imageAspectRatioConstraint = heightAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: aspectRatio
        )
        imageAspectRatioConstraint?.isActive = true
    }
}
