//
//  UserViewController.swift
//  LearningMainStoryboard
//
//  Created by David Vasquez on 9/19/25.
//

import UIKit



protocol UserViewControllerDelegate: AnyObject {
    func userViewController(_ controller: UserViewController, didUpdateUsername username: String)
}

class UserViewController: UIViewController {
    private var username: String
    weak var delegate: UserViewControllerDelegate?

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "User"

        // Label showing current username
        let label = UILabel()
        label.text = "Current: \(username)"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        // Button to simulate change
        let changeButton = UIButton(type: .system)
        changeButton.setTitle("Change to Sam", for: .normal)
        changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
        changeButton.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [label, changeButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapChange() {
        username = "Sam"
        delegate?.userViewController(self, didUpdateUsername: username)
        navigationController?.popViewController(animated: true)
    }
}



//WORKING: Simple
/*
class UserViewController: UIViewController {
    private let username: String

    // Custom initializer
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    // Required by UIKit when using init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "User"

        let label = UILabel()
        label.text = username
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
*/
