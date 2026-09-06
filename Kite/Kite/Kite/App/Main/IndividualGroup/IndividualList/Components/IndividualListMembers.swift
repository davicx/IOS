//
//  IndividualListMembers.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//
// HEIGHT: 120pt members strip + hairline above/below (Colors.separator).
// Used under IndividualListHeader in tableHeaderView.

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS

/// Horizontal strip of list (group) members — avatars + @username.
final class IndividualListMembers: UIView {

    //LAYOUT
    private let membersHeight: CGFloat = 120
    private let hairline = 1 / UIScreen.main.scale

    /// Total height including top/bottom separators.
    var totalHeight: CGFloat { membersHeight + (hairline * 2) }

    //UI COMPONENTS
    private let topBorderView = UIView()
    private let bottomBorderView = UIView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private var members: [User] = []
    var onMembersTapped: (() -> Void)?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = UIColor(hex: "#BDBDBD")
        addSubview(topBorderView)

        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = UIColor(hex: "#BDBDBD")
        addSubview(bottomBorderView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: totalHeight),

            topBorderView.topAnchor.constraint(equalTo: topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: hairline),

            bottomBorderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: hairline),

            scrollView.topAnchor.constraint(equalTo: topBorderView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBorderView.topAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(stripTapped))
        addGestureRecognizer(tap)
    }

    //FUNCTIONS
    func configure(with members: [User]) {
        self.members = members
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for member in members {
            stackView.addArrangedSubview(makeMemberView(for: member))
        }
    }

    //ACTIONS
    @objc private func stripTapped() {
        onMembersTapped?()
    }

    private func makeMemberView(for member: User) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isUserInteractionEnabled = false

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 42
        imageView.backgroundColor = .systemGray5
        imageView.image = member.profileImage ?? UIImage(named: "background_1")

        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "@\(member.userName)"
        usernameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        usernameLabel.textColor = .label
        usernameLabel.textAlignment = .center
        usernameLabel.numberOfLines = 1
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.minimumScaleFactor = 0.8

        containerView.addSubview(imageView)
        containerView.addSubview(usernameLabel)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 120),
            containerView.heightAnchor.constraint(equalToConstant: 120),

            imageView.widthAnchor.constraint(equalToConstant: 84),
            imageView.heightAnchor.constraint(equalToConstant: 84),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

        return containerView
    }
}
