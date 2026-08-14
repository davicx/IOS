//
//  ItemPurchased.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit


final class ItemPurchasedBy: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        ViewStyle.placeholderContent(
            in: self,
            title: "ItemPurchasedBy",
            backgroundColor: Colors.itemDetailPlaceholder,
            height: 48
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
