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
    private let itemFrom = ItemFrom()
    private let menuButton = UIButton(type: .system)

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
        itemFrom.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemFrom)

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        menuButton.tintColor = Colors.subtleGrayText
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        menuButton.accessibilityLabel = "More"
        addSubview(menuButton)

        NSLayoutConstraint.activate([
            itemFrom.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            itemFrom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            itemFrom.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),
            itemFrom.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -Layout.spacingS),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            menuButton.centerYAnchor.constraint(equalTo: itemFrom.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            menuButton.heightAnchor.constraint(equalToConstant: Layout.touchTargetSize)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemFrom.configure(with: post)
    }
}
