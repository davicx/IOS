//
//  GroupTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

//Parents: GroupsViewController

import UIKit


//LISTS: Wishlist
class GroupCell: UITableViewCell {

    private let groupIDLabel = UILabel()
    private let groupNameLabel = UILabel()
    private let createdByLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        //print("GroupTableViewCell")
        printCellInfo(cellName: "GroupCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabels() {
        groupNameLabel.font = .boldSystemFont(ofSize: 20)
        createdByLabel.font = .systemFont(ofSize: 14)
        createdByLabel.textColor = .gray
        groupIDLabel.font = .systemFont(ofSize: 16)

        let stack = UIStackView(arrangedSubviews: [groupNameLabel, createdByLabel, groupIDLabel])
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

    func configure(with group: GroupModel, currentUser: String) {
        groupNameLabel.text = group.groupName
        createdByLabel.text = createdByText(for: group, currentUser: currentUser)
        groupIDLabel.text = "Group ID: \(group.groupID)"
    }

    private func createdByText(for group: GroupModel, currentUser: String) -> String {
        guard let createdBy = group.createdBy, !createdBy.isEmpty else {
            return "Group Created By: Unknown"
        }

        if createdBy == currentUser {
            return "Created by you"
        }

        return "Group Created By: \(createdBy)"
    }
}



/*
//GROUPS: Kite
class GroupTableViewCell: UITableViewCell {

    private let groupIDLabel = UILabel()
    private let groupNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        //print("GroupTableViewCell")
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
*/
