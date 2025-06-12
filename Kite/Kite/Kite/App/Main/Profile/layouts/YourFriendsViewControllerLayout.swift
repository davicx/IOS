//
//  YourFriendsViewControllerLayout.swift
//  Kite
//
//  Created by David Vasquez on 6/11/25.
//

import UIKit


extension YourFriendsViewController {
    
    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider()

        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]

        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        segmentedControl.frame = CGRect(x: 16, y: 4, width: view.frame.width - 32, height: 36)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
    }

    func addUnderlineForSelectedSegment() {
        let underlineWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineY = segmentedControl.frame.height - underlineHeight
        let underlineX = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth

        if let underline = underlineView {
            UIView.animate(withDuration: 0.25) {
                underline.frame.origin.x = underlineX
            }
        } else {
            let underline = UIView(frame: CGRect(x: underlineX, y: underlineY, width: underlineWidth, height: underlineHeight))
            underline.backgroundColor = .label
            segmentedControl.addSubview(underline)
            underlineView = underline
        }
    }
}


extension YourFriendsViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72

        tableView.register(
            YourFriendsTableViewCell.self,
            forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell
        )
    }
}
