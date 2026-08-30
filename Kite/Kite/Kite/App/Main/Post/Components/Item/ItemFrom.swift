//
//  ItemFrom.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


// Wishlist item cell — who posted (empty shell for layout).
final class ItemFrom: UIView {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemOrange.withAlphaComponent(0.35)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ItemFrom"
        titleLabel.font = Fonts.semibold14
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
