//
//  Colors.swift
//  Kite
//
//  Created by David Vasquez on 5/28/26.
//

import UIKit


class Colors {


    // Brand
    static let primaryBlue = UIColor(hex: "#3797EF")
    static let primaryPink = UIColor(hex: "#FF2E7A")

    // Text
    static let primaryText = UIColor.black
    static let secondaryText = UIColor.darkGray

    // Backgrounds
    static let screenBackground = UIColor.white

    // Buttons
    static let buttonPrimaryBlueBackground = primaryBlue
    static let buttonPrimaryPinkBackground = primaryPink
}

removeFriendButton.setTitle("Friends", for: .normal)
removeFriendButton.backgroundColor = .white
removeFriendButton.setTitleColor(.black, for: .normal)
removeFriendButton.layer.borderWidth = 1
removeFriendButton.layer.borderColor = UIColor.lightGray.cgColor
