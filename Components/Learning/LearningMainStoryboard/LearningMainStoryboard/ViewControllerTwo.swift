//
//  ViewControllerTwo.swift
//  LearningMainStoryboard
//
//  Created by David Vasquez on 9/18/25.
//

import UIKit


class ViewControllerTwo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "VC2"

        let label = UILabel()
        label.text = "This is VC2"
        label.font = .systemFont(ofSize: 24, weight: .bold)

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
