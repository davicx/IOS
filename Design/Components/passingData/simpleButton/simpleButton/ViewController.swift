//
//  ViewController.swift
//  simpleButton
//
//  Created by David Vasquez on 5/22/25.
//

import UIKit


// MARK: - ViewController
class ViewController: UIViewController, ButtonDelegate {

    let customButton = UIButton(type: .system)
    let handler = CustomButtonHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Setup button
        customButton.setTitle("Tap Me", for: .normal)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(customButton)

        // Center the button
        NSLayoutConstraint.activate([
            customButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Set delegate
        handler.delegate = self
    }

    @objc func buttonTapped() {
        handler.simulateTap()
    }

    // MARK: - ButtonDelegate Method
    func buttonWasTapped() {
        print("ViewController received the tap event via delegate.")
    }
}
