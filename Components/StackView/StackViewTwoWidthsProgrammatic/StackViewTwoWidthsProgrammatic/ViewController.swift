//
//  ViewController.swift
//  StackViewTwoWidthsProgrammatic
//
//  Created by David Vasquez on 10/5/24.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0 // No spacing between the subviews
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Create the left label
        let leftLabel = UILabel()
        leftLabel.text = "Left"
        leftLabel.textAlignment = .center
        leftLabel.backgroundColor = .lightGray // For visibility
        
        // Create the right label
        let rightLabel = UILabel()
        rightLabel.text = "Right"
        rightLabel.textAlignment = .center
        rightLabel.backgroundColor = .darkGray // For visibility

        // Add labels to the stack view
        stackView.addArrangedSubview(leftLabel)
        stackView.addArrangedSubview(rightLabel)

        // Add the stack view to the main view
        view.addSubview(stackView)

        // Set up constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        // Set fixed width for the left label and flexible width for the right label
        leftLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        rightLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
    }
}

