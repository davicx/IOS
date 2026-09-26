//
//  VideoCell.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
import UIKit


class UserCell: UITableViewCell {

    // Containers (50% / 50%)
    private let leftContainer = UIView()
    private let rightContainer = UIView()

    // UI
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let followerCountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none

        [leftContainer, rightContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        [userImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            leftContainer.addSubview($0)
        }

        [userNameLabel, followerCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            rightContainer.addSubview($0)
        }

        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 40

        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        followerCountLabel.font = .systemFont(ofSize: 14)
        followerCountLabel.textColor = .gray
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            // Left container (50%)
            leftContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            // Right container (50%)
            rightContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightContainer.leadingAnchor.constraint(equalTo: leftContainer.trailingAnchor),

            // Image 80x80 centered left
            userImageView.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 80),
            userImageView.heightAnchor.constraint(equalToConstant: 80),

            // Username label
            userNameLabel.topAnchor.constraint(equalTo: rightContainer.topAnchor, constant: 25),
            userNameLabel.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: 12),
            userNameLabel.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor, constant: -12),

            // Follower count label
            followerCountLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 6),
            followerCountLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            followerCountLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor)
        ])
    }

    func setUser(user: User) {
        userNameLabel.text = user.userName
        followerCountLabel.text = "Followers: \(user.userFollowers.count)"
        userImageView.image = user.userImage
    }
}


/*
class UserCell: UITableViewCell {

    let userImageView = UIImageView()
    let userNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUser(user: User) {
        userNameLabel.text = user.userName
        userImageView.image = user.userImage
    }
}
*/


/*
class UserCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    
    func setVideo(video: Video) {
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
    
}

*/


