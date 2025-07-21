//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 7/21/25.
//

import UIKit


class PostCell: UITableViewCell {
    let postImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPostImageView()
    }

    private func setupPostImageView() {
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postImageView)

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 2.0 / 3.0) // 3:2 ratio
        ])
    }

    func configure(with image: UIImage?) {
        postImageView.image = image ?? UIImage(systemName: "photo")
    }
}
