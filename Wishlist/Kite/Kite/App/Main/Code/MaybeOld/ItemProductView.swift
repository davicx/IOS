//
//  ItemProductView.swift
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

final class ItemProductView: UIView {

    //UI COMPONENTS
    //Top Row: Title and Menu
    private let itemTitleView = UIView()
    private let itemTitleLabel = UILabel()
    private let itemEditMenuView = UIView()
    private let menuImageView = UIImageView()
    
    //Middle Row: Price
    private let itemPriceView = UIView()
    private let itemPriceLabel = UILabel()
    
    //Bottom Row: Description
    private let itemDescriptionView = UIView()
    private let itemDescriptionLabel = UILabel()

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

        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.font = Fonts.itemNameFont
        itemTitleLabel.textColor = Colors.primaryGrayText
        itemTitleLabel.numberOfLines = 1
        itemTitleLabel.lineBreakMode = .byTruncatingTail
        itemTitleView.addSubview(itemTitleLabel)

        NSLayoutConstraint.activate([
            itemTitleView.topAnchor.constraint(equalTo: topAnchor),
            itemTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemTitleView.trailingAnchor.constraint(equalTo: itemEditMenuView.leadingAnchor),
            itemTitleView.heightAnchor.constraint(equalToConstant: 26),

            itemTitleLabel.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor, constant: 6),
            itemTitleLabel.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),
            itemTitleLabel.centerYAnchor.constraint(equalTo: itemTitleView.centerYAnchor)
        ])
    }

    private func setupItemEditMenuView() {
        itemEditMenuView.backgroundColor = .clear

        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.image = UIImage(named: "menu-horizontal")
        menuImageView.contentMode = .scaleAspectFit
        itemEditMenuView.addSubview(menuImageView)

        NSLayoutConstraint.activate([
            itemEditMenuView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemEditMenuView.centerYAnchor.constraint(equalTo: itemTitleView.centerYAnchor),
            itemEditMenuView.widthAnchor.constraint(equalToConstant: 32),
            itemEditMenuView.heightAnchor.constraint(equalToConstant: 32),

            menuImageView.centerXAnchor.constraint(equalTo: itemEditMenuView.centerXAnchor),
            menuImageView.centerYAnchor.constraint(equalTo: itemEditMenuView.centerYAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 22),
            menuImageView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }

    private func setupItemPriceView() {
        itemPriceView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.28) // temp

        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = Fonts.semibold15
        itemPriceLabel.textColor = Colors.primaryGrayText
        itemPriceLabel.numberOfLines = 1
        itemPriceLabel.lineBreakMode = .byTruncatingTail
        itemPriceView.addSubview(itemPriceLabel)

        NSLayoutConstraint.activate([
            itemPriceView.topAnchor.constraint(equalTo: itemTitleView.bottomAnchor),
            itemPriceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemPriceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemPriceView.heightAnchor.constraint(equalToConstant: 26),

            itemPriceLabel.leadingAnchor.constraint(equalTo: itemPriceView.leadingAnchor, constant: 6),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemPriceView.trailingAnchor, constant: -Layout.spacingM),
            itemPriceLabel.centerYAnchor.constraint(equalTo: itemPriceView.centerYAnchor)
        ])
    }

    private func setupItemDescriptionView() {
        itemDescriptionView.backgroundColor = .clear

        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.font = Fonts.itemDescriptionFont
        itemDescriptionLabel.textColor = Colors.primaryGrayText
        itemDescriptionLabel.numberOfLines = 3
        itemDescriptionLabel.lineBreakMode = .byTruncatingTail
        itemDescriptionView.addSubview(itemDescriptionLabel)

        NSLayoutConstraint.activate([
            itemDescriptionView.topAnchor.constraint(equalTo: itemPriceView.bottomAnchor),
            itemDescriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemDescriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemDescriptionView.heightAnchor.constraint(equalToConstant: 80),

            itemDescriptionLabel.topAnchor.constraint(equalTo: itemDescriptionView.topAnchor, constant: Layout.spacingS),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemDescriptionView.leadingAnchor, constant: 6),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemDescriptionView.trailingAnchor),
            itemDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: itemDescriptionView.bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(name: String?, price: String?, description: String?) {
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemTitleLabel.text = (trimmedName?.isEmpty == false) ? trimmedName : "Untitled"

        let trimmedPrice = price?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemPriceLabel.text = (trimmedPrice?.isEmpty == false) ? trimmedPrice : nil

        let trimmedDescription = description?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemDescriptionLabel.text = (trimmedDescription?.isEmpty == false) ? trimmedDescription : nil
    }
}
*/
