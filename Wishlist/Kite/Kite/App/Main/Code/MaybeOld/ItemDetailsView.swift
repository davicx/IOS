//
//  ItemDetailsView.swift
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

final class ItemDetailsView: UIView {

    //UI COMPONENTS
    private let titleLabel = UILabel()
    private let moreButton = UIButton(type: .system)
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()

    var onMoreTapped: (() -> Void)?

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

        titleLabel.font = Fonts.semibold20
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = Colors.subtleGrayText
        moreButton.accessibilityLabel = "More item options"
        moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        moreButton.setContentHuggingPriority(.required, for: .horizontal)
        moreButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        priceLabel.font = Fonts.semibold18
        priceLabel.textColor = Colors.primaryGrayText
        priceLabel.numberOfLines = 1

        descriptionLabel.font = Fonts.regular16
        descriptionLabel.textColor = Colors.secondaryGrayText
        descriptionLabel.numberOfLines = 0

        [titleLabel, moreButton, priceLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor),

            moreButton.topAnchor.constraint(equalTo: topAnchor, constant: -Layout.spacingS),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 44),
            moreButton.heightAnchor.constraint(equalToConstant: 44),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingS),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Layout.spacingL),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //ACTIONS
    @objc private func moreTapped() {
        onMoreTapped?()
    }

    //FUNCTIONS
    func configure(name: String?, price: String?, description: String?) {
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        titleLabel.text = (trimmedName?.isEmpty == false) ? trimmedName : "Untitled"

        let trimmedPrice = price?.trimmingCharacters(in: .whitespacesAndNewlines)
        priceLabel.text = (trimmedPrice?.isEmpty == false) ? trimmedPrice : nil

        setDescription(description)
    }

    private func setDescription(_ text: String?) {
        let trimmed = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let trimmed, trimmed.isEmpty == false else {
            descriptionLabel.attributedText = nil
            return
        }

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        descriptionLabel.attributedText = NSAttributedString(
            string: trimmed,
            attributes: [
                .font: Fonts.regular16,
                .foregroundColor: Colors.secondaryGrayText,
                .paragraphStyle: style
            ]
        )
    }
}
*/
