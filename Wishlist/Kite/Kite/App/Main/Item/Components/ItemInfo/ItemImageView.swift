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
    private let titleLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.28)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        titleLabel.text = "ItemImageView"
        titleLabel.font = Fonts.semibold16
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    //FUNCTIONS
    func configure(image: UIImage?, name: String?) {
    }
}
