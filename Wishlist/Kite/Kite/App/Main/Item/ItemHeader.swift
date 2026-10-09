//
//  ItemHeader.swift
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

final class ItemHeader: UIView {

    //UI COMPONENTS
    private let itemInfo = ItemInfo()

    var onPurchaseTapped: ((Post, PurchaseButtonState) -> Void)? {
        get { itemInfo.onPurchaseTapped }
        set { itemInfo.onPurchaseTapped = newValue }
    }

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
        itemInfo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemInfo)

        NSLayoutConstraint.activate([
            itemInfo.topAnchor.constraint(equalTo: topAnchor),
            itemInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemInfo.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemInfo.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemInfo.configure(with: post)
    }
}
