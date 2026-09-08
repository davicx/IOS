//
//  ProfileInfoFriendsCard.swift
//  Kite
//
//  Created by David Vasquez on 7/13/26.
//

import UIKit

class ProfileInfoFriendsCard: UIView {

    private let countLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // backgroundColor = UIColor.systemGreen.withAlphaComponent(0.25)
        isUserInteractionEnabled = true

        countLabel.font = Fonts.userInfoCountFont
        countLabel.textColor = Colors.userInfoCountTextColor
        countLabel.textAlignment = .center
        countLabel.text = "0"
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.font = Fonts.userInfoDescriptionFont
        descriptionLabel.textColor = Colors.userInfoDescriptionTextColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Friends"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(countLabel)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -12),
            countLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -1),

            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -12),
            descriptionLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 1)
        ])
    }

    func configure(count: Int) {
        countLabel.text = count >= 0 ? "\(count)" : "0"
    }
}
