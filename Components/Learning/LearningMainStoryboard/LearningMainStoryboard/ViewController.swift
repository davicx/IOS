//
//  ViewController.swift
//  LearningMainStoryboard
//
//  Created by David Vasquez on 9/18/25.
//

import UIKit


class ViewController: UIViewController, UserViewControllerDelegate {

    private var currentUsername = "Frodo"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"

        // Post Button
        let postButton = UIButton(type: .system)
        postButton.setTitle("Go to Post", for: .normal)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)

        // User Button
        let userButton = UIButton(type: .system)
        userButton.setTitle("Go to User", for: .normal)
        userButton.addTarget(self, action: #selector(didTapUser), for: .touchUpInside)

        // Layout with a vertical stack
        let stack = UIStackView(arrangedSubviews: [postButton, userButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Button Actions
    @objc private func didTapPost() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapUser() {
        let vc = UserViewController(username: currentUsername)
        vc.delegate = self   // ✅ set delegate
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - UserViewControllerDelegate
    func userViewController(_ controller: UserViewController, didUpdateUsername username: String) {
        self.currentUsername = username
        print("Username updated to: \(username)")
        // Optionally update a label here if you want to show it on the home screen
    }
}


//WORKING: Simple
/*
class ViewController: UIViewController {
    var username: String?  

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"

        // Post Button
        let postButton = UIButton(type: .system)
        postButton.setTitle("Go to Post", for: .normal)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)

        // User Button
        let userButton = UIButton(type: .system)
        userButton.setTitle("Go to User", for: .normal)
        userButton.addTarget(self, action: #selector(didTapUser), for: .touchUpInside)

        // Layout
        let stack = UIStackView(arrangedSubviews: [postButton, userButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapPost() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapUser() {
        let vc = UserViewController(username: "Frodo")
        navigationController?.pushViewController(vc, animated: true)
    }
}
 */

