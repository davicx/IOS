//
//  ItemBody.swift
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

final class ItemBody: UIView {

    //UI COMPONENTS
    private let itemInfo = ItemInfo()
    private let itemCaption = ItemCaption()

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
        [itemInfo, itemCaption].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            itemInfo.topAnchor.constraint(equalTo: topAnchor),
            itemInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            itemInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),

            itemCaption.topAnchor.constraint(equalTo: itemInfo.bottomAnchor, constant: Layout.spacingM),
            itemCaption.leadingAnchor.constraint(equalTo: itemInfo.leadingAnchor),
            itemCaption.trailingAnchor.constraint(equalTo: itemInfo.trailingAnchor),
            itemCaption.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemInfo.configure(with: post)
        itemCaption.configure(with: post)
    }
}
