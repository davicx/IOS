//
//  ItemImage.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


// Wishlist item cell — product image (empty shell for layout). 40% width / 180 tall from parent.
final class ItemImage: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        ViewStyle.placeholderContent(
            in: self,
            title: "ItemImage",
            backgroundColor: UIColor.systemBlue.withAlphaComponent(0.35),
            height: 180
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
