//
//  UserHeaderView.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/6/24.
//

import UIKit


class UserHeaderView: UICollectionReusableView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "WHO TO FOLLOW"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center // Center the text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230) // Assuming you have this UIColor extension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        addSubview(divider)

        // Constraints for the label
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
        
        // Constraints for the divider
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

