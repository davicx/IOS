//
//  PostCell.swift
//  TableViewPostComments
//
//  Created by David Vasquez on 4/24/25.
//

import UIKit


class PostCell: UITableViewCell {

    private let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.systemBlue
        contentView.addSubview(postLabel)

        postLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            postLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        postLabel.text = text
    }
}
