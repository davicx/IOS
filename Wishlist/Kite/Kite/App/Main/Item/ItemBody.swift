//
//  ItemBody.swift
//  Kite
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
    private let itemCaption = ItemCaption()

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
        itemCaption.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemCaption)

        NSLayoutConstraint.activate([
            itemCaption.topAnchor.constraint(equalTo: topAnchor),
            itemCaption.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemCaption.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemCaption.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemCaption.configure(with: post)
    }
}
