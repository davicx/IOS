//
//  InviteFriendCell.swift
//  Kite
//

import UIKit


final class InviteFriendCell: UITableViewCell {

    var onToggle: (() -> Void)?

    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let checkboxButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onToggle = nil
        profileImageView.image = UIImage(named: "placeholder_profile")
    }

    func configure(with user: User, checked: Bool) {
        usernameLabel.text = "@\(user.userName)"
        fullNameLabel.text = user.displayName
        profileImageView.image = user.profileImage ?? UIImage(named: "placeholder_profile")
        let symbol = checked ? "checkmark.square.fill" : "square"
        checkboxButton.setImage(UIImage(systemName: symbol), for: .normal)
        checkboxButton.tintColor = checked ? Colors.primaryPink : Colors.subtleGrayText
    }

    @objc private func checkboxTapped() {
        onToggle?()
    }

    private func setupViews() {
        selectionStyle = .none
        [profileImageView, usernameLabel, fullNameLabel, checkboxButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.textColor = Colors.primaryText
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        checkboxButton.contentHorizontalAlignment = .center

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: checkboxButton.leadingAnchor, constant: -12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            checkboxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 44),
            checkboxButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
