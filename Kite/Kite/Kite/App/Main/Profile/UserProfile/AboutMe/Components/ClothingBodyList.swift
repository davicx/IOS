//
//  ClothingBodyList.swift
//  Kite
//
//  Created by David Vasquez on 9/6/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class ClothingBodyList: UIView {

    //LOGIC
    private struct TempItem {
        let emoji: String
        let name: String
        let value: String
    }

    private let tempItems: [TempItem] = [
        TempItem(emoji: "👟", name: "Shoes", value: "Men's 12"),
        TempItem(emoji: "🧥", name: "Coats", value: "Large only"),
        TempItem(emoji: "👕", name: "Shirts", value: "No T-shirts for me")
    ]

    //UI COMPONENTS
    // ClothingBodyList
    // └── cardView
    //     └── stackView (rows)

    private let cardView = UIView()
    private let stackView = UIStackView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        setupCardView()
        setupStackView()
        populateTempRows()
        layoutViews()
    }

    private func setupCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = Colors.screenBackground
        cardView.layer.cornerRadius = 28
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = Colors.separator.cgColor
        cardView.clipsToBounds = true
        addSubview(cardView)
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        cardView.addSubview(stackView)
    }

    private func populateTempRows() {
        for (index, item) in tempItems.enumerated() {
            let row = makeRow(emoji: item.emoji, name: item.name, value: item.value)
            stackView.addArrangedSubview(row)

            if index < tempItems.count - 1 {
                let divider = UIView()
                divider.translatesAutoresizingMaskIntoConstraints = false
                divider.backgroundColor = Colors.separator
                stackView.addArrangedSubview(divider)
                divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            }
        }
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.topAnchor.constraint(equalTo: cardView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
    }

    //FUNCTIONS
    private func makeRow(emoji: String, name: String, value: String) -> UIView {
        let row = UIView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.backgroundColor = .clear

        let iconBackground = UIView()
        iconBackground.translatesAutoresizingMaskIntoConstraints = false
        iconBackground.backgroundColor = Colors.primaryBlue.withAlphaComponent(0.12)
        iconBackground.layer.cornerRadius = 16
        row.addSubview(iconBackground)

        let iconLabel = UILabel()
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.text = emoji
        iconLabel.font = UIFont.systemFont(ofSize: 24)
        iconLabel.textAlignment = .center
        iconBackground.addSubview(iconLabel)

        let textStack = UIStackView()
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .fill
        textStack.distribution = .fill
        textStack.spacing = 2
        row.addSubview(textStack)

        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = Fonts.semibold16
        nameLabel.textColor = Colors.subtleGrayText

        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.font = Fonts.semibold17
        valueLabel.textColor = Colors.primaryGrayText
        valueLabel.numberOfLines = 0

        let chevronLabel = UILabel()
        chevronLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronLabel.text = "›"
        chevronLabel.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        chevronLabel.textColor = Colors.subtleGrayText.withAlphaComponent(0.5)
        chevronLabel.textAlignment = .center
        row.addSubview(chevronLabel)

        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(valueLabel)

        NSLayoutConstraint.activate([
            row.heightAnchor.constraint(equalToConstant: 104),

            iconBackground.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: Layout.spacingL),
            iconBackground.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            iconBackground.widthAnchor.constraint(equalToConstant: 80),
            iconBackground.heightAnchor.constraint(equalToConstant: 80),

            iconLabel.centerXAnchor.constraint(equalTo: iconBackground.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor),

            textStack.leadingAnchor.constraint(equalTo: iconBackground.trailingAnchor, constant: Layout.spacingL),
            textStack.centerYAnchor.constraint(equalTo: row.centerYAnchor),

            chevronLabel.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: Layout.spacingS),
            chevronLabel.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -Layout.spacingL),
            chevronLabel.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            chevronLabel.widthAnchor.constraint(equalToConstant: 20)
        ])

        return row
    }
}
