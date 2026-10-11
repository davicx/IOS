//
//  ItemBodyOriginal.swift
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

final class ItemBodyOriginal: UIView {

    //UI COMPONENTS
    private let itemCaption = ItemCaptionOriginal()

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
        itemCaption.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemCaption)

        NSLayoutConstraint.activate([
            itemCaption.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingL),
            itemCaption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            itemCaption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            itemCaption.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemCaption.configure(with: post)
    }
}
