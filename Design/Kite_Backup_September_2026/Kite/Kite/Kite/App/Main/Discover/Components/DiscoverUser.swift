//
//  DiscoverUser.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class DiscoverUser: UIControl {

    //LOGIC

    //UI COMPONENTS
    // DiscoverUser
    // ├── avatarView
    // ├── nameLabel
    // ├── usernameLabel
    // └── chevron

    private let avatarView = UIView()
    private let initialLabel = UILabel()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
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

        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.backgroundColor = Colors.newItemPasteIconBackground
        avatarView.layer.cornerRadius = 27
        avatarView.isUserInteractionEnabled = false
        addSubview(avatarView)

        initialLabel.translatesAutoresizingMaskIntoConstraints = false
        initialLabel.font = Fonts.semibold16
        initialLabel.textColor = Colors.primaryPink
        initialLabel.textAlignment = .center
        avatarView.addSubview(initialLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Fonts.semibold16
        nameLabel.textColor = Colors.primaryGrayText
        addSubview(nameLabel)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = Fonts.regular14
        usernameLabel.textColor = Colors.subtleGrayText
        addSubview(usernameLabel)

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

            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 54),
            avatarView.heightAnchor.constraint(equalToConstant: 54),

            initialLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            initialLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            chevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            chevron.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 12),
            chevron.heightAnchor.constraint(equalToConstant: 16),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Layout.spacingM),
            nameLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: -Layout.spacingS),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),

            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            usernameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Layout.spacingM)
        ])
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.feedBackground : Colors.screenBackground
        }
    }

    //ACTIONS

    //FUNCTIONS
    func configure(name: String, username: String) {
        nameLabel.text = name
        usernameLabel.text = username
        initialLabel.text = String(name.prefix(1)).uppercased()
        accessibilityLabel = "\(name), \(username)"
    }
}
