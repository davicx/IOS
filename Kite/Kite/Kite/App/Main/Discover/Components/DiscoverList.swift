//
//  DiscoverList.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class DiscoverList: UIControl {

    //LOGIC

    //UI COMPONENTS
    // DiscoverList
    // ├── coverView
    // ├── titleLabel
    // ├── detailLabel
    // └── chevron

    private let coverView = UIView()
    private let coverLabel = UILabel()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let chevron = UIImageView()

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
        backgroundColor = Colors.screenBackground
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = Colors.newItemCardBorder.cgColor

        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.backgroundColor = Colors.newItemPhotoIconBackground
        coverView.layer.cornerRadius = 10
        coverView.isUserInteractionEnabled = false
        addSubview(coverView)

        coverLabel.translatesAutoresizingMaskIntoConstraints = false
        coverLabel.font = Fonts.semibold16
        coverLabel.textColor = Colors.primaryBlue
        coverLabel.textAlignment = .center
        coverView.addSubview(coverLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.semibold16
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = Fonts.regular14
        detailLabel.textColor = Colors.subtleGrayText
        addSubview(detailLabel)

        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.image = UIImage(systemName: "chevron.right")
        chevron.tintColor = Colors.subtleGrayText
        chevron.contentMode = .scaleAspectFit
        addSubview(chevron)

        layoutViews()
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 80),

            coverView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            coverView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverView.widthAnchor.constraint(equalToConstant: 56),
            coverView.heightAnchor.constraint(equalToConstant: 56),

            coverLabel.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
            coverLabel.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),

            chevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            chevron.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 12),
            chevron.heightAnchor.constraint(equalToConstant: 16),

            titleLabel.leadingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: Layout.spacingM),
            titleLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: -Layout.spacingS),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),

            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            detailLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Layout.spacingM)
        ])
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.feedBackground : Colors.screenBackground
        }
    }

    //ACTIONS

    //FUNCTIONS
    func configure(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
        coverLabel.text = String(title.prefix(1)).uppercased()
        accessibilityLabel = "\(title), \(detail)"
    }
}
