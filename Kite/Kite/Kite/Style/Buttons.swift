//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 5/8/26.
//

import UIKit

enum Buttons {

    //BUTTONS: Login Buttons
    static func loginButtonStyle(button: UIButton) {

        button.backgroundColor = Colors.buttonPrimaryBackground

        button.setTitleColor(.white, for: .normal)

        button.layer.cornerRadius = 5

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

    }

    //LINK BUTTONS: Login Forgot Password Link
    static func loginLinkButtonStyle(button: UIButton) {

        button.setTitleColor(Colors.primary, for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        button.backgroundColor = .clear

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
