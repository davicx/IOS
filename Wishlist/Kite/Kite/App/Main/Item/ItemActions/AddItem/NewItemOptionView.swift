//
//  NewItemOptionView.swift
//  Kite
//
//  Created by David Vasquez on 8/21/26.
//

import UIKit


final class NewItemOptionView: UIControl {

    // LAYOUT
    private let cardHeight: CGFloat = 122
    private let cornerRadius: CGFloat = 16
    private let iconCircleSize: CGFloat = 60

    // UI
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let textStack = UIStackView()

    private var cardBackgroundColor: UIColor = .clear
    private var onTap: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.72 : 1.0
        }
    }

    // MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: cardHeight)
    }

    // LAYOUT
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = Colors.newItemCardBorder.cgColor
        clipsToBounds = true

        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundView.layer.cornerRadius = iconCircleSize / 2
        iconBackgroundView.isUserInteractionEnabled = false
        addSubview(iconBackgroundView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.isUserInteractionEnabled = false
        iconBackgroundView.addSubview(iconImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.newItemOptionTitleFont
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.numberOfLines = 1

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = Fonts.newItemOptionSubtitleFont
        subtitleLabel.textColor = Colors.subtleGrayText
        subtitleLabel.numberOfLines = 2

        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = Layout.spacingXS
        textStack.isUserInteractionEnabled = false
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        addSubview(textStack)

        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = Colors.subtleGrayText
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.isUserInteractionEnabled = false
        addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: cardHeight),

            iconBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            iconBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: iconCircleSize),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: iconCircleSize),

            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 14),
            chevronImageView.heightAnchor.constraint(equalToConstant: 18),

            textStack.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: Layout.spacingL),
            textStack.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Layout.spacingS),
            textStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // FUNCTIONS
    func configure(
        title: String,
        subtitle: String,
        iconName: String,
        iconTintColor: UIColor,
        iconBackgroundColor: UIColor,
        backgroundColor: UIColor,
        action: @escaping () -> Void
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = iconTintColor
        iconBackgroundView.backgroundColor = iconBackgroundColor
        self.backgroundColor = backgroundColor
        cardBackgroundColor = backgroundColor
        onTap = action
    }

    // ACTIONS
    @objc private func handleTap() {
        onTap?()
    }
}
