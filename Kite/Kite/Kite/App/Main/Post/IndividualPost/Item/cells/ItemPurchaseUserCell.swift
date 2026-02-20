//
//  ItemPurchaseUserCell.swift
//  Kite
//
//  Created by David Vasquez on 2/17/26.
//


import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS

class ItemPurchaseUserCell: UITableViewCell {

    let profileImageView = UIImageView()
    let fullNameLabel = UILabel()
    let usernameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, fullNameLabel, usernameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.textColor = .black
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.textColor = UIColor(hex: "#606060")

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            fullNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            usernameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with user: User) {
        fullNameLabel.text = user.displayName
        usernameLabel.text = "@\(user.userName)"
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")
    }
}
