//
//  ItemInfo.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


// Wishlist item cell — title / price / details (empty shell for layout). 60% width / 180 tall from parent.
final class ItemInfo: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        ViewStyle.placeholderContent(
            in: self,
            title: "ItemInfo",
            backgroundColor: UIColor.systemYellow.withAlphaComponent(0.35),
            height: 180
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
