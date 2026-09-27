//
//  ItemInfoView.swift
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
/*

final class ItemInfoView: UIView {

    //UI COMPONENTS
    private let itemImageView = ItemImageView()
    private let itemDetailsView = ItemDetailsView()
    private let horizontalStack = UIStackView()

    var onMoreTapped: (() -> Void)? {
        get { itemDetailsView.onMoreTapped }
        set { itemDetailsView.onMoreTapped = newValue }
    }

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

        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .top
        horizontalStack.distribution = .fill
        horizontalStack.spacing = Layout.spacingM
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStack)

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemDetailsView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.addArrangedSubview(itemImageView)
        horizontalStack.addArrangedSubview(itemDetailsView)

        let padding = Layout.spacingL
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            itemImageView.widthAnchor.constraint(equalTo: horizontalStack.widthAnchor, multiplier: 0.46)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let name = post.itemName
        itemImageView.configure(image: post.postImageData, name: name)
        itemDetailsView.configure(
            name: name,
            price: post.itemPrice,
            description: post.itemDescription
        )
    }

    func configureSample() {
        itemImageView.configure(image: UIImage(named: "chrono"), name: "Secret of Mana")
        itemDetailsView.configure(
            name: "Secret of Mana",
            price: "$49.99",
            description: "I want to get Secret of Mana. Looks awesome! One of my favorite SNES games from when I was a kid."
        )
    }
}

*/
