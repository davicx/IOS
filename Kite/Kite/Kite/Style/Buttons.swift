//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 5/8/26.
//

import UIKit

class Buttons: UIViewController {

    
    //BUTTONS: Login Buttons
    static func loginButtonStyle(button: UIButton) {
        button.backgroundColor = UIColor(hex: "#3797EF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    
    //LINK BUTTONS: Login Forgot Password Link
    static func loginLinkButtonStyle(button: UIButton) {
        button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

}

//NEW
/*
 class Buttons: UIViewController {

     static func loginButtonStyle(button: UIButton) {

         button.backgroundColor = Colors.loginButtonBackground

         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 5
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
     }

     static func loginLinkButtonStyle(button: UIButton) {

         button.setTitleColor(Colors.loginLinkText, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
     }
 }
 */
