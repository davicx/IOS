//
//  UserCellTableViewCell.swift
//  TableViewPlayground
//
//  Created by David Vasquez on 11/27/25.
//

import UIKit


class UserCell: UITableViewCell {

    let plusButton = UIButton(type: .system)
    let minusButton = UIButton(type: .system)
    let likeLabel = UILabel()
    var user: User?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        plusButton.setTitle("+", for: .normal)
        minusButton.setTitle("-", for: .normal)
        plusButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)

        likeLabel.font = .systemFont(ofSize: 16)
        likeLabel.textColor = .label

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(plusButton)
        contentView.addSubview(minusButton)
        contentView.addSubview(likeLabel)

        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            minusButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10),
            minusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            likeLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -10),
            likeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUI),
            name: .userUpdated,
            object: nil
        )
    }

    func configure(with user: User) {
        self.user = user
        textLabel?.text = user.name
        likeLabel.text = "\(user.likes)"
    }

    @objc private func incrementTapped() {
        guard let user = user else { return }
        UserDataController.shared.incrementLikes(for: user)
    }

    @objc private func decrementTapped() {
        guard let user = user else { return }
        UserDataController.shared.decrementLikes(for: user)
    }

    @objc private func updateUI(_ notification: Notification) {
        guard let updatedUser = notification.object as? User else { return }
        guard updatedUser.name == user?.name else { return }
        likeLabel.text = "\(updatedUser.likes)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
class UserCell: UITableViewCell {

    let likeButton = UIButton(type: .system)
    let likeLabel = UILabel()
    var user: User?  // <-- Store the real model, not just a name

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        likeButton.setTitle("❤️", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        likeLabel.font = .systemFont(ofSize: 16)
        likeLabel.textColor = .label

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)

        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            likeLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -10),
            likeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        // 🔥 The cell listens for updates
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUI),
            name: .userUpdated,
            object: nil
        )
    }

    // Called by tableView in cellForRowAt:
    func configure(with user: User) {
        self.user = user
        textLabel?.text = user.name
        likeLabel.text = "\(user.likes)"
    }

    @objc private func likeTapped() {
        guard let user = user else { return }
        UserDataController.shared.incrementLikes(for: user)   // REAL pattern
    }

    // 🔥 Refresh when a user updates
    @objc private func updateUI(_ notification: Notification) {
        guard let updatedUser = notification.object as? User else { return }
        guard updatedUser.name == user?.name else { return }

        likeLabel.text = "\(updatedUser.likes)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
//WORKS
/*
 class UserCell: UITableViewCell {

    let likeButton = UIButton(type: .system)
    let likeLabel = UILabel()
    var username: String?     // we set this from cellForRow

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        likeButton.setTitle("❤️", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)

        likeLabel.font = .systemFont(ofSize: 16)
        likeLabel.textColor = .label

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)

        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            likeLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -10),
            likeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc private func likeTapped() {
        print("like tapped")
        if let username = username {
            UserDataController.shared.like(username)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
