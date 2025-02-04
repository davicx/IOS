//
//  SecondViewController.swift
//  Twitter
//
//  Created by David Vasquez on 10/4/24.
//


import UIKit


class SecondViewController: UIViewController {
    var postCaption: String?

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Set the navigation bar color
        navigationController?.navigationBar.barTintColor = .blue
        
        // Set the title text color
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        
        // Set the label text
        label.text = postCaption
        view.addSubview(label)

        // Center the label in the view
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

