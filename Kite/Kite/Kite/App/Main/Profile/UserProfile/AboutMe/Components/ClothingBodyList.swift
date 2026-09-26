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

    //UI COMPONENTS
    // ClothingBodyList
    // └── cardView
    //     └── stackView (rows)

    private let cardView = UIView()
    private let stackView = UIStackView()
    private let emptyLabel = UILabel()

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
        setupEmptyLabel()
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

    private func setupEmptyLabel() {
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No clothing preferences yet."
        emptyLabel.font = Fonts.regular16
        emptyLabel.textColor = Colors.subtleGrayText
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.isHidden = true
        cardView.addSubview(emptyLabel)
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
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            emptyLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Layout.spacingXL),
            emptyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Layout.spacingL),
            emptyLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Layout.spacingL),
            emptyLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Layout.spacingXL)
        ])
    }

    //FUNCTIONS
    func configure(preferences: [ProfilePreference]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        emptyLabel.isHidden = !preferences.isEmpty
        stackView.isHidden = preferences.isEmpty

        for (index, preference) in preferences.enumerated() {
            let row = makeRow(
                category: preference.preferenceCategory,
                title: preference.preferenceTitle,
                description: preference.preferenceDescription
            )
            stackView.addArrangedSubview(row)

            if index < preferences.count - 1 {
                let divider = UIView()
                divider.translatesAutoresizingMaskIntoConstraints = false
                divider.backgroundColor = Colors.separator
                stackView.addArrangedSubview(divider)
                divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            }
        }
    }

    private func makeRow(category: String, title: String, description: String) -> UIView {
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
        iconLabel.text = emoji(for: category)
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
        nameLabel.text = category
        nameLabel.font = Fonts.semibold16
        nameLabel.textColor = Colors.subtleGrayText

        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = title
        valueLabel.font = Fonts.semibold17
        valueLabel.textColor = Colors.primaryGrayText
        valueLabel.numberOfLines = 2
        valueLabel.lineBreakMode = .byTruncatingTail

        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        descriptionLabel.text = trimmedDescription.isEmpty ? nil : trimmedDescription
        descriptionLabel.font = Fonts.regular14
        descriptionLabel.textColor = Colors.subtleGrayText
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.isHidden = trimmedDescription.isEmpty

        let chevronLabel = UILabel()
        chevronLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronLabel.text = "›"
        chevronLabel.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        chevronLabel.textColor = Colors.subtleGrayText.withAlphaComponent(0.5)
        chevronLabel.textAlignment = .center
        row.addSubview(chevronLabel)

        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(valueLabel)
        if !descriptionLabel.isHidden {
            textStack.addArrangedSubview(descriptionLabel)
        }

        NSLayoutConstraint.activate([
            row.heightAnchor.constraint(greaterThanOrEqualToConstant: 104),

            iconBackground.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: Layout.spacingL),
            iconBackground.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            iconBackground.widthAnchor.constraint(equalToConstant: 80),
            iconBackground.heightAnchor.constraint(equalToConstant: 80),

            iconLabel.centerXAnchor.constraint(equalTo: iconBackground.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor),

            textStack.leadingAnchor.constraint(equalTo: iconBackground.trailingAnchor, constant: Layout.spacingL),
            textStack.topAnchor.constraint(equalTo: row.topAnchor, constant: Layout.spacingM),
            textStack.bottomAnchor.constraint(equalTo: row.bottomAnchor, constant: -Layout.spacingM),

            chevronLabel.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: Layout.spacingS),
            chevronLabel.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -Layout.spacingL),
            chevronLabel.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            chevronLabel.widthAnchor.constraint(equalToConstant: 20)
        ])

        return row
    }

    private func emoji(for category: String) -> String {
        let key = category.lowercased()
        if key.contains("shoe") { return "👟" }
        if key.contains("coat") || key.contains("jacket") { return "🧥" }
        if key.contains("shirt") || key.contains("tee") { return "👕" }
        if key.contains("pant") || key.contains("jean") { return "👖" }
        if key.contains("hat") { return "🧢" }
        return "👕"
    }
}
