//
//  CommentCell.swift
//  TableViewPostComments
//
//  Created by David Vasquez on 4/24/25.
//

import UIKit


class CommentCell: UITableViewCell {

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkText
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commentLabel)
        contentView.addSubview(separator)

        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -10),

            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        commentLabel.text = text
    }
}
