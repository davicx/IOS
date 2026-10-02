//
//  ItemProductView.swift
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

final class ItemProductView: UIView {

    //UI COMPONENTS
    private let itemTitleView = UIView()
    private let itemEditMenuView = UIView()
    private let menuImageView = UIImageView()
    private let itemPriceView = UIView()
    private let itemDescriptionView = UIView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [itemTitleView, itemEditMenuView, itemPriceView, itemDescriptionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        setupItemTitleView()
        setupItemEditMenuView()
        setupItemPriceView()
        setupItemDescriptionView()
    }

    //LAYOUT and UI
    private func setupItemTitleView() {
        itemTitleView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.28) // temp

        NSLayoutConstraint.activate([
            itemTitleView.topAnchor.constraint(equalTo: topAnchor),
            itemTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemTitleView.trailingAnchor.constraint(equalTo: itemEditMenuView.leadingAnchor),
            itemTitleView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupItemEditMenuView() {
        itemEditMenuView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.45) // temp

        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.image = UIImage(named: "menu-horizontal")
        menuImageView.contentMode = .scaleAspectFit
        itemEditMenuView.addSubview(menuImageView)

        NSLayoutConstraint.activate([
            itemEditMenuView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemEditMenuView.centerYAnchor.constraint(equalTo: itemTitleView.centerYAnchor),
            itemEditMenuView.widthAnchor.constraint(equalToConstant: 40),
            itemEditMenuView.heightAnchor.constraint(equalToConstant: 40),

            menuImageView.centerXAnchor.constraint(equalTo: itemEditMenuView.centerXAnchor),
            menuImageView.centerYAnchor.constraint(equalTo: itemEditMenuView.centerYAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 20),
            menuImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupItemPriceView() {
        itemPriceView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.28) // temp

        NSLayoutConstraint.activate([
            itemPriceView.topAnchor.constraint(equalTo: itemTitleView.bottomAnchor),
            itemPriceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemPriceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemPriceView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupItemDescriptionView() {
        itemDescriptionView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.28) // temp

        NSLayoutConstraint.activate([
            itemDescriptionView.topAnchor.constraint(equalTo: itemPriceView.bottomAnchor),
            itemDescriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemDescriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemDescriptionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
