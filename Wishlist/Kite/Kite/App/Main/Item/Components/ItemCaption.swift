//
//  ItemCaption.swift
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

final class ItemCaption: UIView {

    //UI COMPONENTS
    private let titleLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemOrange.withAlphaComponent(0.28)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        titleLabel.text = "ItemCaption"
        titleLabel.font = Fonts.semibold16
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingL),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingL)
        ])
    }
}
