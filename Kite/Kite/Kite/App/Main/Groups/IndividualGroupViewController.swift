//
//  IndividualGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

import UIKit


class IndividualGroupViewController: UIViewController {

    var group: GroupModel?

    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
        let groupID = group?.groupID ?? 0
        let groupName = group?.groupName ?? "No Group Name"
        print("IndividualGroupViewController \(groupName)")
    }

    private func setupLabel() {
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.text = group != nil ? "Group: \(group!.groupName)\nID: \(group!.groupID)" : "No Group"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
