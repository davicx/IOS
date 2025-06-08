//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 1/3/25.
//

import UIKit


class Buttons {

        //LOGIN BUTTON
    static func styleLoginFilledButton(_ button:UIButton) {
        button.backgroundColor = UIColor(hex: "#EA4359")
        button.layer.cornerRadius = 16.0
        button.tintColor = UIColor.white

        // Set the font to Helvetica Neue, size 18, bold
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    static func styleForgotPasswordButton(_ button: UIButton) {
        button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal) // Font color
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 8) // Font
        button.backgroundColor = .clear // Transparent background
    }
     
    
    static func styleLoginButton(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal) // White text color
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12) // Font
        button.backgroundColor = UIColor(hex: "#3797EF") // Background color
        button.layer.cornerRadius = 5 // Rounded corners
    }
    
    static func styleFriendsButton(_ button: UIButton) {
        button.setTitle("Friends", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
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



    
}




/*
static func loginButton(_ button: UIButton) {
    button.backgroundColor = UIColor(hex: "#FAFAFA") // Background color

    button.layer.cornerRadius = 5.0 // Rounded corners
    button.layer.borderWidth = 0.5 // Thin border
    button.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor // Border at 10% opacity

    button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .normal) // Text color at 20% opacity
    button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 14) // SF Pro Text, Regular, size 14
}
 */

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
