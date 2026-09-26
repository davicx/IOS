//
//  ViewController.swift
//  LayoutThreeItemsProgrammatic
//
//  Created by David Vasquez on 9/21/24.
//

import UIKit

class ViewController: UIViewController {
    let mainView = UIView()
    let imageView = UIImageView()
    let expandingLabel = UILabel()
    let blueSubview = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
        setupImageView()
        setupLabel()
        setupBlueSubview()
    }

    private func setupMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor) // Full height
        ])
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background_1") // Replace with your image name
        imageView.contentMode = .scaleAspectFill
        mainView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5) // Adjust height as needed
        ])
    }

    private func setupLabel() {
        expandingLabel.translatesAutoresizingMaskIntoConstraints = false
        expandingLabel.numberOfLines = 0
        expandingLabel.text = "This is an expanding label. It will grow as more text is added."
        expandingLabel.font = UIFont.systemFont(ofSize: 16)
        mainView.addSubview(expandingLabel)

        NSLayoutConstraint.activate([
            expandingLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            expandingLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            expandingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28) // Spacing from image
        ])
    }

    private func setupBlueSubview() {
        blueSubview.translatesAutoresizingMaskIntoConstraints = false
        blueSubview.backgroundColor = .blue
        mainView.addSubview(blueSubview)

        NSLayoutConstraint.activate([
            blueSubview.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            blueSubview.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            blueSubview.topAnchor.constraint(equalTo: expandingLabel.bottomAnchor, constant: 8), // Spacing from label
            blueSubview.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

