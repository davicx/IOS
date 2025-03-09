//
//  UserFollowersView.swift
//  Kite
//
//  Created by David Vasquez on 3/6/25.
//

import UIKit

class UserFollowersView: UIView {

    private let followingLabel = createStatLabel(text: "14")
    private let followersLabel = createStatLabel(text: "38")
    private let likesLabel = createStatLabel(text: "91")

    private let followingTitle = createTitleLabel(text: "Following")
    private let followersTitle = createTitleLabel(text: "Followers")
    private let likesTitle = createTitleLabel(text: "Likes")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let followingStack = createVerticalStackView(label: followingLabel, title: followingTitle)
        let followersStack = createVerticalStackView(label: followersLabel, title: followersTitle)
        let likesStack = createVerticalStackView(label: likesLabel, title: likesTitle)

        let horizontalStack = UIStackView(arrangedSubviews: [followingStack, followersStack, likesStack])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private static func createStatLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }

    private static func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }

    private func createVerticalStackView(label: UILabel, title: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [label, title])
        stack.axis = .vertical
        stack.alignment = .center
        //stack.spacing = 2
        stack.spacing = 0
        return stack
    }
}
