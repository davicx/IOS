//
//  UserProfileView.swift
//  Kite
//
//  Created by David Vasquez on 3/10/25.
//


import UIKit


class UserProfileView: UIView {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(profileImageView)
        addSubview(userNameLabel)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
