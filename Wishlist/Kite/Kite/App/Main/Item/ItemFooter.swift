//
//  ItemFooter.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemFooter: UIView {

    //UI COMPONENTS
    private let itemSocials = ItemSocials()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        itemSocials.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemSocials)

        NSLayoutConstraint.activate([
            itemSocials.topAnchor.constraint(equalTo: topAnchor),
            itemSocials.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemSocials.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemSocials.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func applyMidnight(_ on: Bool) {
        backgroundColor = on ? MidnightColors.cardBackground : Colors.screenBackground
        itemSocials.applyMidnight(on)
    }

    func configure(with post: Post) {
        itemSocials.configure(with: post)
    }
}
