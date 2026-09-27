//
//  DiscoverItem.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class DiscoverItem: UIControl {

    //LOGIC
    var onAdd: (() -> Void)?

    //UI COMPONENTS
    // DiscoverItem
    // ├── imageView
    // ├── titleLabel
    // ├── categoryLabel
    // └── addButton

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let addButton = UIButton(type: .system)

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
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = Colors.newItemCardBorder.cgColor
        clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Colors.itemBackgroundColor
        imageView.clipsToBounds = true
        addSubview(imageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts.semibold15
        titleLabel.textColor = Colors.primaryGrayText
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = Fonts.regular14
        categoryLabel.textColor = Colors.subtleGrayText
        addSubview(categoryLabel)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = Colors.primaryPink
        addButton.layer.cornerRadius = 19
        addButton.layer.borderWidth = 1.5
        addButton.layer.borderColor = Colors.primaryPink.cgColor
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        addSubview(addButton)

        layoutViews()
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            imageView.heightAnchor.constraint(equalToConstant: 132),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Layout.spacingM),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -Layout.spacingS),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingXS),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),

            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),
            addButton.widthAnchor.constraint(equalToConstant: 38),
            addButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.feedBackground : Colors.screenBackground
        }
    }

    //ACTIONS
    @objc private func addTapped() {
        onAdd?()
    }

    //FUNCTIONS
    func configure(title: String, category: String, imageName: String) {
        titleLabel.text = title
        categoryLabel.text = category
        imageView.image = UIImage(named: imageName)
        accessibilityLabel = title
        addButton.accessibilityLabel = "Add \(title) to a list"
    }
}
