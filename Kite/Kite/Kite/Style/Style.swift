//
//  Style.swift
//  Kite
//
//  Created by David Vasquez on 1/2/25.
//

import UIKit


class Style {
    
    //FONT
    static let userNameFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let groupInfoFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    static let textBlack: UIColor = .black
    static let textGray: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    static let textClear: UIColor = .clear
    

    static func styleUserNameLabel(_ label: UILabel) {
        label.font = userNameFont
        label.textColor = textBlack
        label.backgroundColor = textClear
    }
    
    static func styleGroupInfoLabel(_ label: UILabel) {
        label.font = groupInfoFont
        label.textColor = textGray
        label.backgroundColor = textClear
    }
    
    static func styleUserNameText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // Light gray like Instagram
        label.backgroundColor = .clear
    }
    
    static func styleSocialCountText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .left
    }
    
    //IMAGES
    static func styleGroupImage(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
    }
    
    
    //LABELS
    static func styleLoginLabel(_ label: UILabel) {
        label.backgroundColor = UIColor(hex: "#FAFAFA") // Background color
        label.layer.cornerRadius = 5.0 // Rounded corners
        label.layer.borderWidth = 0.5 // Thin border
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor // Border at 10% opacity
        
        label.textColor = UIColor.black.withAlphaComponent(0.2) // Text color at 20% opacity
        label.font = UIFont(name: "SFProText-Regular", size: 14) // SF Pro Text, Regular, size 14
        
        label.layer.masksToBounds = true // Ensure rounded corners apply

        // Add left padding
        let padding = String(repeating: " ", count: 2) // Adjust count as needed
        label.text = "\(padding)\(label.text ?? "")"
    }
    
    static func styleLoginTextField(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hex: "#FAFAFA")
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        textField.textColor = UIColor.black.withAlphaComponent(0.8)
        textField.font = UIFont(name: "SFProText-Regular", size: 14)
        textField.layer.masksToBounds = true
        
        // Left padding using a UIView
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    

}


