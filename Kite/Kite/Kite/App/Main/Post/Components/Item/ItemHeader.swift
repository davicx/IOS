//
//  ItemHeader.swift
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

// Wishlist post header — owns ItemFrom + EditItem layout.
final class ItemHeader: UIView {

    //UI COMPONENTS
    private let itemFrom = ItemFrom()
    private let editItem = EditItem()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    // [ ItemFrom | EditItem ]
    private func setupViews() {
        [itemFrom, editItem].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        // ItemFrom owns natural height; EditItem stays on the trailing side.
        // Bottom pin preserves current visual; ItemFrom can still grow later.
        NSLayoutConstraint.activate([
            itemFrom.topAnchor.constraint(equalTo: topAnchor),
            itemFrom.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemFrom.bottomAnchor.constraint(equalTo: bottomAnchor),

            editItem.topAnchor.constraint(equalTo: topAnchor),
            editItem.leadingAnchor.constraint(equalTo: itemFrom.trailingAnchor),
            editItem.trailingAnchor.constraint(equalTo: trailingAnchor),
            editItem.bottomAnchor.constraint(equalTo: itemFrom.bottomAnchor)
        ])
    }
}
