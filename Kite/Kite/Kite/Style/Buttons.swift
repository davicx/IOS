//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 1/3/25.
//

import UIKit


class Buttons {
    
    static func styleLoginFilledButton(_ button:UIButton) {
        button.backgroundColor = UIColor(hex: "#EA4359")
        button.layer.cornerRadius = 16.0
        button.tintColor = UIColor.white

        // Set the font to Helvetica Neue, size 18, bold
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    
    static func styleTwitterButton(_ button:UIButton) {
        button.backgroundColor = UIColor(hex: "#1DA1F2")
        button.layer.cornerRadius = 12.0
        button.tintColor = UIColor.white

        // Set the font to Helvetica Neue, size 18, bold
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    static func styleTikTokButton(_ button: UIButton) {
        button.backgroundColor = .clear // Clear background
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0 // Thin 1-point border
        button.layer.borderColor = UIColor(hex: "#E3E3E4").cgColor // Border color
        
        button.setTitleColor(UIColor(hex: "#000000"), for: .normal) // Set text color
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    /*
    static func styleTikTokButton(_ button: UIButton) {
        button.backgroundColor = .clear // Clear background
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0 // Thin 1-point border
        button.layer.borderColor = UIColor(hex: "#E3E3E4").cgColor
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
     */
    /*
    static func styleTikTokButton(_ button:UIButton) {
        //button.backgroundColor = UIColor(hex: "#EA4359")
        button.layer.cornerRadius = 4.0
        button.tintColor = UIColor.white
        
        //E3E3E4

        // Set the font to Helvetica Neue, size 18, bold
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
     */
    


    
}


//Temp.styleTextField(userNameTextField)
//Buttons.styleLoginFilledButton(sayHiButtonStyle)
//sayHiButtonStyle.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)


/*
 let button = UIButton(type: .system)

 // Set the button's font
 button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)

 // Set the tint color
 button.tintColor = UIColor.white

 // Optionally, set a title to see the font style
 button.setTitle("Press Me", for: .normal)

static func styleLoginTextField(_ textfield:UITextField) {
    
    // Create the bottom line
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
    
    // Remove border on text field
    textfield.borderStyle = .none
    
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
    
}



static func styleLoginHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
}
 */
