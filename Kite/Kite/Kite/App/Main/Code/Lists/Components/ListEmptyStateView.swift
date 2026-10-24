//
//AI: Poor Code
//
//  ListEmptyStateView.swift
//  Kite
//
//  Created by David Vasquez on 9/17/26.
//

import UIKit


final class ListEmptyStateView: UIView {

    // LOGIC
    private var onAction: (() -> Void)?

    // UI COMPONENTS
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    // MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // LAYOUT
    private func setupViews() {
        backgroundColor = .clear

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Colors.subtleGrayText

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.semibold18
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = Fonts.regular14
        messageLabel.textColor = Colors.subtleGrayText
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.titleLabel?.font = Fonts.semibold14
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = Colors.primaryPink
        actionButton.layer.cornerRadius = 12
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        actionButton.isHidden = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Layout.spacingM
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(actionButton)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 36),
            iconImageView.heightAnchor.constraint(equalToConstant: 36),

            actionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Layout.touchTargetSize),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingXL),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingXL),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Layout.spacingXL),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Layout.spacingXL)
        ])
    }

    // FUNCTIONS
    func configure(
        symbolName: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        iconImageView.image = UIImage(systemName: symbolName)
        titleLabel.text = title
        messageLabel.text = message
        onAction = action

        if let actionTitle = actionTitle, action != nil {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.accessibilityLabel = actionTitle
            actionButton.isHidden = false
        } else {
            actionButton.isHidden = true
            onAction = nil
        }
    }

    // ACTIONS
    @objc private func actionTapped() {
        onAction?()
    }
}
