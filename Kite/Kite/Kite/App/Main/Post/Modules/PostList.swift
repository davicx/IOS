//
//  PostList.swift
//  Kite
//
//  Created by David Vasquez on 9/6/26.
//

import UIKit


/// Profile module placeholder — posts feed lives here later.
final class PostList: UIView {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.feedBackground

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Posts"
        titleLabel.font = Fonts.semibold15
        titleLabel.textColor = Colors.subtleGrayText
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 140),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
