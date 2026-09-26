//
//  ClothingHeader.swift
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


final class ClothingHeader: UIView {

    //UI COMPONENTS
    // ClothingHeader
    // ├── titleLabel
    // ├── editButton
    // └── subtitleLabel

    private let titleLabel = UILabel()
    private let editButton = UIButton(type: .system)
    private let subtitleLabel = UILabel()

    var onEditTapped: (() -> Void)?

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

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Clothing & Sizes"
        titleLabel.font = Fonts.semibold17
        titleLabel.textColor = Colors.primaryGrayText
        addSubview(titleLabel)

        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = Fonts.semibold16
        editButton.setTitleColor(Colors.primaryBlue, for: .normal)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        addSubview(editButton)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Helpful when someone is shopping for you."
        subtitleLabel.font = Fonts.regular16
        subtitleLabel.textColor = Colors.subtleGrayText
        subtitleLabel.numberOfLines = 0
        addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: editButton.leadingAnchor, constant: -Layout.spacingS),

            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingS),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //ACTIONS
    @objc private func editTapped() {
        onEditTapped?()
    }

    //FUNCTIONS
    func setEditingControlsHidden(_ hidden: Bool) {
        editButton.isHidden = hidden
        editButton.isUserInteractionEnabled = !hidden
    }
}
