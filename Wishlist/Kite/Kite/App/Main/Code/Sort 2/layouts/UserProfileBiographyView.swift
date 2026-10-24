//
//  UserProfileBiographyView.swift
//  Kite
//
//  Created by David Vasquez on 3/12/25.
//

import UIKit


class UserProfileBiographyView: UIView {
    
    private let firstNameLabel = UILabel()
    private let lastNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .purple
        
        // Configure labels
        firstNameLabel.textAlignment = .center
        firstNameLabel.textColor = .white
        firstNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        lastNameLabel.textAlignment = .center
        lastNameLabel.textColor = .white
        lastNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        // Add labels to view
        addSubview(firstNameLabel)
        addSubview(lastNameLabel)
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Arrange labels horizontally (side by side)
        NSLayoutConstraint.activate([
            firstNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstNameLabel.topAnchor.constraint(equalTo: topAnchor),
            firstNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            firstNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            lastNameLabel.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            lastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            lastNameLabel.topAnchor.constraint(equalTo: topAnchor),
            lastNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            lastNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    func configure(firstName: String, lastName: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }
}
