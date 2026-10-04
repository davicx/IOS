//
//  ItemInfoView.swift
//  Kite
//
//  Created by David Vasquez on 9/27/26.
//

/*
import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemInfoView: UIView {

    //UI COMPONENTS
    private let itemImageView = ItemImageView()
    private let itemProductView = ItemProductView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        backgroundColor = .clear

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemProductView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemImageView)
        addSubview(itemProductView)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            itemImageView.heightAnchor.constraint(equalToConstant: 140),

            itemProductView.topAnchor.constraint(equalTo: topAnchor),
            itemProductView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor),
            itemProductView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemProductView.heightAnchor.constraint(equalToConstant: 200),

            bottomAnchor.constraint(equalTo: itemProductView.bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configureItem(with post: Post) {
        itemProductView.configure(name: post.itemName, price: post.itemPrice, description: post.itemDescription)
    }
}
*/
