//
//  EditItem.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


// Wishlist item cell — menu / edit (empty shell for layout). Width 40; height follows row.
final class EditItem: UIView {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemPurple.withAlphaComponent(0.35)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Edit"
        titleLabel.font = Fonts.semibold14
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
