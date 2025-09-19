//
//  ViewController.swift
//  LearningMainStoryboard
//
//  Created by David Vasquez on 9/18/25.
//

import UIKit


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "VC1"

        let button = UIButton(type: .system)
        button.setTitle("Go to VC2", for: .normal)
        button.addTarget(self, action: #selector(openVC2), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func openVC2() {
        let vc2 = ViewControllerTwo()
        navigationController?.pushViewController(vc2, animated: true)
    }
}

