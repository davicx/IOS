//
//  ItemCell.swift
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

final class ItemCell: UITableViewCell {

    //UI COMPONENTS
    private let itemInfo = ItemInfoView()
    private let itemDivider = ItemDivider()
    
    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.feedBackground
        contentView.backgroundColor = .clear
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupItem() {
        itemDivider.install(in: contentView)

        itemInfo.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemInfo)

        NSLayoutConstraint.activate([
            itemInfo.topAnchor.constraint(equalTo: itemDivider.contentTopAnchor),
            itemInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        itemDivider.linkContentBottom(to: itemInfo.bottomAnchor)
    }
}
