//
//  UserFollowersView.swift
//  Kite
//
//  Created by David Vasquez on 3/6/25.
//

import UIKit


//SAME as below but with colors
class UserFollowersView: UIView {

    private let followingCountLabel = createStatLabel(text: "14", color: .red)
    private let followersCountLabel = createStatLabel(text: "38", color: .blue)
    private let likesCountLabel = createStatLabel(text: "91", color: .green)

    private let followingTitle = createTitleLabel(text: "Following", color: .yellow)
    private let followersTitle = createTitleLabel(text: "Followers", color: .purple)
    private let likesTitle = createTitleLabel(text: "Likes", color: .orange)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let followingStack = createVerticalStackView(label: followingCountLabel, title: followingTitle)
        let followersStack = createVerticalStackView(label: followersCountLabel, title: followersTitle)
        let likesStack = createVerticalStackView(label: likesCountLabel, title: likesTitle)

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

    private static func createStatLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = color // Assigning different colors
        return label
    }

    private static func createTitleLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.backgroundColor = color // Assigning different colors
        return label
    }

    private func createVerticalStackView(label: UILabel, title: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [label, title])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 0 // Reducing space between count and title
        return stack
    }
}


//GOOD WORKS
/*
class UserFollowersView: UIView {

    private let followingCountLabel = createStatLabel(text: "14")
    private let followersCountLabel = createStatLabel(text: "38")
    private let likesCountLabel = createStatLabel(text: "91")

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
        let followingStack = createVerticalStackView(label: followingCountLabel, title: followingTitle)
        let followersStack = createVerticalStackView(label: followersCountLabel, title: followersTitle)
        let likesStack = createVerticalStackView(label: likesCountLabel, title: likesTitle)

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
     
    /*
    private func createVerticalStackView(label: UILabel, title: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [label, title])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 0
        
        // Adjust hugging priorities to bring labels closer
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return stack
    }
     */

}
*/
