//
//  LoadableImageView.swift
//  Kite
//
//  Image-specific wrapper around `LoadingPlaceholderView`: `imageView` lives in
//  `contentContainer`. For labels/text alone, use `LoadingPlaceholderView` directly.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


/*

/// **LOADING:** gray holder · **LOADED:** `imageView` image.
final class LoadableImageView: LoadingPlaceholderView {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        showLoading()
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentContainer.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor)
        ])
    }

    override func cornerRadiusDidChange() {
        imageView.layer.cornerRadius = cornerRadius
    }

    override func showLoading() {
        super.showLoading()
        imageView.isHidden = true
    }

    override func showContent() {
        super.showContent()
        imageView.isHidden = false
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
        if image != nil {
            showContent()
        } else {
            showLoading()
        }
    }
}
 */
