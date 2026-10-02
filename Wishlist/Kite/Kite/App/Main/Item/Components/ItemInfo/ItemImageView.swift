//
//  ItemImageView.swift
//  Kite
//
//  Created by David Vasquez on 9/27/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemImageView: UIView {

    //UI COMPONENTS
    private let productImageView = UIImageView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4 // temp — holder behind the image
        setupViews()
        configure(image: UIImage(named: "chrono"), name: "Secret of Mana")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = Colors.itemDetailPlaceholder
        productImageView.layer.cornerRadius = 12
        if #available(iOS 13.0, *) {
            productImageView.layer.cornerCurve = .continuous
        }
        addSubview(productImageView)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingXS),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingXS),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingXS),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingXS)
        ])
    }

    //FUNCTIONS
    func configure(image: UIImage?, name: String?) {
        productImageView.image = image
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        productImageView.accessibilityLabel = (trimmedName?.isEmpty == false) ? trimmedName : "Item image"
    }
}
