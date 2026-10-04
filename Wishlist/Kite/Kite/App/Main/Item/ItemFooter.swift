//
//  ItemFooter.swift
//  Kite
//
//  Created by David Vasquez on 10/4/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemFooter: UIView {

    //UI COMPONENTS
    private let itemSocials = ItemSocials()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        itemSocials.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemSocials)

        NSLayoutConstraint.activate([
            itemSocials.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingS),
            itemSocials.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            itemSocials.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            itemSocials.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemSocials.configure(with: post)
    }
}
