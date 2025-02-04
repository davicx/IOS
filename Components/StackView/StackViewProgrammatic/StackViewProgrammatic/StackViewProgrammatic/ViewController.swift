//
//  ViewController.swift
//  StackViewProgrammatic
//
//  Created by David Vasquez on 10/19/24.
//


import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10 // Optional: Add spacing between sections
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create four sections (views)
        for i in 1...4 {
            let section = UIView()
            section.backgroundColor = randomColor()
            stackView.addArrangedSubview(section)
        }
        
        // Add the stack view to the main view
        view.addSubview(stackView)
        
        // Set constraints using NSLayoutConstraint
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // Helper function to generate random colors for each section
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

