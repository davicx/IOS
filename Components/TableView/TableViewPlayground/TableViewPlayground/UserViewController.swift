//
//  UserViewController.swift
//  TableViewPlayground
//
//  Created by David Vasquez on 11/26/25.
//

import UIKit


class UserViewController: UIViewController {

    var username: String?   // <-- This will receive the value

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        if let username = username {
            print("Received: \(username)")
        }

        // Example label on screen:
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You clicked \(username ?? "Unknown")"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
