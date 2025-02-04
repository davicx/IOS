//
//  ViewController.swift
//  ViewWithTextSubview
//
//  Created by David Vasquez on 10/6/24.
//

import UIKit


//EXAMPLE 2: Dynamic Text
class ViewController: UIViewController {
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray // Set background color
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16) // Font size
        label.textAlignment = .center // Center text
        label.numberOfLines = 0 // Allow multiple lines
        //label.backgroundColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        updateLabel(with: "Do you wish me a good morning, or mean that it is a good morning whether I want it or not; or that you feel good this morning; or that it is a morning to be good on?! Do you wish me a good morning, or mean that it is a good morning whether I want it or not; or that you feel good this morning; or that it is a morning to be good on?! Do you wish me a good morning, or mean that it is a good morning whether I want it or not; or that you feel good this morning!")
    }
    
    private func setupLayout() {
        // Add the custom view to the main view
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for custom view
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Add the label to the custom view
        customView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the label
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20), // Padding from the left
            label.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20), // Padding from the right
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20), // Padding from the top
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20) // Padding from the bottom
        ])
    }
    
    private func updateLabel(with text: String) {
        label.text = text
        
        // Calculate the height of the label based on the text
        let labelWidth = view.frame.width - 40 // Adjust for padding
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let estimatedSize = label.sizeThatFits(maxSize)
        print("estimatedSize \(estimatedSize)")
        
        // Update the custom view height constraint
        customView.heightAnchor.constraint(equalToConstant: estimatedSize.height + 40).isActive = true
        
        // Animate layout changes
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}


//


//EXAMPLE 1: Fixed Text
/*
class ViewController: UIViewController {
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray // Set background color
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "hi!"
        label.font = UIFont.systemFont(ofSize: 24) // Font size
        label.textAlignment = .center // Center text
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        // Add the custom view to the main view
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for custom view
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Add the label to the custom view
        customView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: customView.centerYAnchor)
        ])
    }
}
*/
