//
//AI: Poor Code
//
//  CreateListCell.swift
//  Kite
//
//  Created by David Vasquez on 9/17/26.
//

import UIKit


final class CreateListCell: UITableViewCell {

    // LAYOUT
    private let createNewListButtonHeight: CGFloat = 96
    private let cornerRadius: CGFloat = 16
    private let iconCircleSize: CGFloat = 44

    // UI COMPONENTS
    private let createNewListButtonArea = UIView()
    private let iconBackgroundView = UIView()
    private let plusButton = UIImageView()
    private let createNewListTitle = UILabel()
    private let createNewListSubTitle = UILabel()
    private let textStack = UIStackView()

    var onCreateListTapped: (() -> Void)?

    // MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        createNewListButtonArea.alpha = highlighted ? 0.78 : 1.0
    }

    // LAYOUT
    private func setupViews() {
        createNewListButtonArea.translatesAutoresizingMaskIntoConstraints = false
        createNewListButtonArea.backgroundColor = Colors.newItemPasteCardBackground
        createNewListButtonArea.layer.cornerRadius = cornerRadius
        createNewListButtonArea.layer.borderWidth = 1
        createNewListButtonArea.layer.borderColor = Colors.primaryPink.withAlphaComponent(0.25).cgColor
        createNewListButtonArea.clipsToBounds = true
        contentView.addSubview(createNewListButtonArea)

        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundView.backgroundColor = Colors.newItemPasteIconBackground
        iconBackgroundView.layer.cornerRadius = iconCircleSize / 2
        createNewListButtonArea.addSubview(iconBackgroundView)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.image = UIImage(systemName: "plus")
        plusButton.tintColor = Colors.primaryPink
        plusButton.contentMode = .scaleAspectFit
        iconBackgroundView.addSubview(plusButton)

        createNewListTitle.translatesAutoresizingMaskIntoConstraints = false
        createNewListTitle.text = "Create a new list"
        createNewListTitle.font = Fonts.semibold14
        createNewListTitle.textColor = Colors.primaryPink
        createNewListTitle.numberOfLines = 1

        createNewListSubTitle.translatesAutoresizingMaskIntoConstraints = false
        createNewListSubTitle.text = "Make a list for any occasion and invite friends."
        createNewListSubTitle.font = Fonts.regular13
        createNewListSubTitle.textColor = Colors.subtleGrayText
        createNewListSubTitle.numberOfLines = 2

        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = Layout.spacingXS
        textStack.addArrangedSubview(createNewListTitle)
        textStack.addArrangedSubview(createNewListSubTitle)
        createNewListButtonArea.addSubview(textStack)

        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        createNewListButtonArea.addGestureRecognizer(tap)
        createNewListButtonArea.isAccessibilityElement = true
        createNewListButtonArea.accessibilityTraits = .button
        createNewListButtonArea.accessibilityLabel = "Create a new list"

        NSLayoutConstraint.activate([
            createNewListButtonArea.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            createNewListButtonArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingL),
            createNewListButtonArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingL),
            createNewListButtonArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            createNewListButtonArea.heightAnchor.constraint(equalToConstant: createNewListButtonHeight),

            iconBackgroundView.leadingAnchor.constraint(equalTo: createNewListButtonArea.leadingAnchor, constant: Layout.spacingL),
            iconBackgroundView.centerYAnchor.constraint(equalTo: createNewListButtonArea.centerYAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: iconCircleSize),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: iconCircleSize),

            plusButton.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 18),
            plusButton.heightAnchor.constraint(equalToConstant: 18),

            textStack.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: Layout.spacingM),
            textStack.trailingAnchor.constraint(equalTo: createNewListButtonArea.trailingAnchor, constant: -Layout.spacingL),
            textStack.centerYAnchor.constraint(equalTo: createNewListButtonArea.centerYAnchor)
        ])
    }

    // ACTIONS
    @objc private func cardTapped() {
        onCreateListTapped?()
    }
}
