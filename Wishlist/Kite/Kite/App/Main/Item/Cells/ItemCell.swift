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
    // private let itemInfo = ItemInfoView()
    private let itemHolder = UIView()
    private let itemHeader = ItemHeader()
    private let itemBody = ItemBody()
    private let itemFooter = ItemFooter()

    private let holderCornerRadius: CGFloat = 16
    private let holderSideInset: CGFloat = Layout.spacingL * 0.8
    
    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.feedBackground
        contentView.backgroundColor = Colors.feedBackground
        clipsToBounds = false
        contentView.clipsToBounds = false
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupItem() {
        // itemInfo.translatesAutoresizingMaskIntoConstraints = false
        // contentView.addSubview(itemInfo)
        //
        // NSLayoutConstraint.activate([
        //     itemInfo.topAnchor.constraint(equalTo: itemDivider.contentTopAnchor),
        //     itemInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //     itemInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        // ])
        //
        // itemDivider.linkContentBottom(to: itemInfo.bottomAnchor)

        itemHolder.translatesAutoresizingMaskIntoConstraints = false
        itemHolder.backgroundColor = Colors.screenBackground
        itemHolder.layer.cornerRadius = holderCornerRadius
        itemHolder.layer.borderWidth = 1
        itemHolder.layer.borderColor = Colors.separator.cgColor
        itemHolder.clipsToBounds = true
        if #available(iOS 13.0, *) {
            itemHolder.layer.cornerCurve = .continuous
        }
        contentView.addSubview(itemHolder)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false

        [itemHeader, itemBody, itemFooter].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            itemHolder.addSubview($0)
        }

        NSLayoutConstraint.activate([
            itemHolder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingM),
            itemHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: holderSideInset),
            itemHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -holderSideInset),
            itemHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingM),

            itemHeader.topAnchor.constraint(equalTo: itemHolder.topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemFooter.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
            itemFooter.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),
            itemFooter.bottomAnchor.constraint(equalTo: itemHolder.bottomAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: itemHolder.frame,
            cornerRadius: holderCornerRadius
        ).cgPath
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemHeader.configure(with: post)
        itemBody.configure(with: post)
        itemFooter.configure(with: post)
    }
}
