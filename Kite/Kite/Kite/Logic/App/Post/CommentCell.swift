//
//  CommentCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//


import UIKit


class CommentCell: UITableViewCell {
    let commentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commentLabel.numberOfLines = 0
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentLabel)

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with comment: String) {
        commentLabel.text = comment
    }
}


/*
 class CommentCell: UITableViewCell {
     private let commentLabel = UILabel()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupUI()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setupUI() {
         commentLabel.translatesAutoresizingMaskIntoConstraints = false
         commentLabel.numberOfLines = 0
         contentView.addSubview(commentLabel)

         NSLayoutConstraint.activate([
             commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
         ])
     }

     func configure(with commentText: String) {
         commentLabel.text = commentText
     }
 }

 */
