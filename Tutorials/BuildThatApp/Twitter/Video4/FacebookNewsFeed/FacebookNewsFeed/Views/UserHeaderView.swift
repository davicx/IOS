//
//  UserHeaderView.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/15/24.
//

import UIKit

class UserHeaderView: UICollectionReusableView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "HEADER"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.blue // Replace with your twitterBlue color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        
        // Center the label horizontally and vertically
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
