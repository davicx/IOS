//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 5/8/26.
//

import UIKit

class Buttons: UIViewController {

    //LOGIN BUTTONS

    static func loginButtonStyle(button: UIButton) {
        button.backgroundColor = UIColor(hex: "#3797EF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    static func loginLinkButtonStyle(button: UIButton) {
        button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

}
