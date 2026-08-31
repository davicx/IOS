//
//  ItemBody.swift
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

// Wishlist post body — owns ItemImage + ItemInfo layout.
final class ItemBody: UIView {

    //UI COMPONENTS
    private let itemImage = ItemImage()
    private let itemInfo = ItemInfo()

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
    // [ ItemImage | ItemInfo ]
    private func setupViews() {
        [itemImage, itemInfo].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            itemImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            itemInfo.topAnchor.constraint(equalTo: topAnchor),
            itemInfo.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor),
            itemInfo.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemInfo.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemInfo.configure(with: post)
    }
}
