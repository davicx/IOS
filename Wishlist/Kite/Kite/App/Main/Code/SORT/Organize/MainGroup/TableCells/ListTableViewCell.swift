//
//  ListTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 8/18/25.
//

import UIKit


class ListTableViewCell: UITableViewCell {

    private let groupIDLabel = UILabel()
    private let groupNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        print("ListTableViewCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabels() {
        groupIDLabel.font = .systemFont(ofSize: 16)
        groupNameLabel.font = .boldSystemFont(ofSize: 20)

        let stack = UIStackView(arrangedSubviews: [groupIDLabel, groupNameLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with group: GroupModel) {
        groupIDLabel.text = "Group ID: \(group.groupID)"
        groupNameLabel.text = group.groupName
    }
}
