//
//  ItemImage.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

// Left column of ItemBody — product image in a rounded well (aspect fit).
final class ItemImage: UIView {

    //LOGIC
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var imageSquareHeightConstraint: NSLayoutConstraint?

    //UI COMPONENTS
    private let imageWellView = UIView()
    private let productImageView = UIImageView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        setupImageWell()
        setupProductImage()
        activateLayout()
    }

    //LAYOUT and UI
    private func setupImageWell() {
        imageWellView.translatesAutoresizingMaskIntoConstraints = false
        imageWellView.backgroundColor = Colors.itemDetailPlaceholder
        imageWellView.layer.cornerRadius = 10
        imageWellView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            imageWellView.layer.cornerCurve = .continuous
        }
        addSubview(imageWellView)
    }

    private func setupProductImage() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .clear
        imageWellView.addSubview(productImageView)
    }

    private func activateLayout() {
        let inset = Layout.spacingM
        let columnGap = Layout.spacingS
        // Was spacingXS (4); expand image ~2pt/side while keeping a small well margin.
        let imageInset: CGFloat = 2
        let topInset = inset - 6

        NSLayoutConstraint.activate([
            imageWellView.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            imageWellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            imageWellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -columnGap),
            bottomAnchor.constraint(equalTo: imageWellView.bottomAnchor, constant: inset),

            productImageView.topAnchor.constraint(equalTo: imageWellView.topAnchor, constant: imageInset),
            productImageView.leadingAnchor.constraint(equalTo: imageWellView.leadingAnchor, constant: imageInset),
            productImageView.trailingAnchor.constraint(equalTo: imageWellView.trailingAnchor, constant: -imageInset),
            productImageView.bottomAnchor.constraint(equalTo: imageWellView.bottomAnchor, constant: -imageInset)
        ])

        updateImageHeight(for: nil)
    }

    //FUNCTIONS
    func configure(with post: Post) {
        if let image = post.postImageData, image.size.width > 0 {
            productImageView.image = image
            updateImageHeight(for: image)
        } else {
            productImageView.image = nil
            updateImageHeight(for: nil)
        }
    }

    private func updateImageHeight(for image: UIImage?) {
        imageAspectRatioConstraint?.isActive = false
        imageSquareHeightConstraint?.isActive = false

        if let image, image.size.width > 0 {
            let aspectRatio = image.size.height / image.size.width
            imageAspectRatioConstraint = imageWellView.heightAnchor.constraint(
                equalTo: imageWellView.widthAnchor,
                multiplier: aspectRatio
            )
            imageAspectRatioConstraint?.isActive = true
        } else {
            imageSquareHeightConstraint = imageWellView.heightAnchor.constraint(
                equalTo: imageWellView.widthAnchor,
                multiplier: 1
            )
            imageSquareHeightConstraint?.isActive = true
        }
    }
}
