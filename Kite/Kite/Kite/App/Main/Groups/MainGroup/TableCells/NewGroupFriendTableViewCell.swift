//
//  NewGroupFriendTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 7/4/25.
//

import UIKit


class NewGroupFriendTableViewCell: UITableViewCell {

    // UI Elements
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let selectionCheckbox = UIButton(type: .system)

    // Friend reference
    private var friend: Friend?

    // Selection state
    private var isChecked = false {
        didSet {
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            selectionCheckbox.setImage(UIImage(systemName: imageName), for: .normal)
            selectionCheckbox.tintColor = isChecked ? .systemBlue : .lightGray
            
            // Print username on toggle
            if let friend = friend {
                print(isChecked ? "\(friend.friendName) was checked" : "\(friend.friendName) was unchecked")
            }
        }
    }

    // Callback if needed
    var onCheckboxToggle: ((Bool) -> Void)?

    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionCheckbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI Setup
    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, selectionCheckbox].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            selectionCheckbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            selectionCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionCheckbox.widthAnchor.constraint(equalToConstant: 32),
            selectionCheckbox.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    // Public configure method
    func configure(with friend: Friend) {
        self.friend = friend
        usernameLabel.text = "@\(friend.friendName)"
        fullNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        profileImageView.image = friend.profileImage ?? UIImage(named: "placeholder_profile")
        isChecked = false // Reset each time cell is reused
    }

    // Checkbox toggle action
    @objc private func toggleCheckbox() {
        isChecked.toggle()
        onCheckboxToggle?(isChecked)
    }
}

/*
class NewGroupFriendTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let selectionCheckbox = UIButton(type: .system)

    // Callback to notify selection state
    var onCheckboxToggle: ((Bool) -> Void)?

    private var isChecked = false {
        didSet {
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            let image = UIImage(systemName: imageName)
            selectionCheckbox.setImage(image, for: .normal)
            selectionCheckbox.tintColor = isChecked ? .systemBlue : .lightGray
            print(isChecked ? "selected" : "not selected")
            onCheckboxToggle?(isChecked)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionCheckbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, selectionCheckbox].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            selectionCheckbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            selectionCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionCheckbox.widthAnchor.constraint(equalToConstant: 32),
            selectionCheckbox.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with friend: Friend) {
        usernameLabel.text = "@\(friend.friendName)"
        fullNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        profileImageView.image = friend.profileImage ?? UIImage(named: "placeholder_profile")
        isChecked = false // reset state
    }

    @objc private func toggleCheckbox() {
        isChecked.toggle()
    }
}

*/


/*
class NewGroupFriendTableViewCell: UITableViewCell {
    private let usernameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameLabel)

        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with friend: Friend) {
        usernameLabel.text = "@\(friend.friendName)"
    }
}
*/


