//
//  Colors.swift
//  Kite
//
//  Created by David Vasquez on 5/28/26.
//

import UIKit


class Colors {


    // Kite Main Colors
    static let primaryBlue = UIColor(hex: "#3797EF")
    static let primaryPink = UIColor(hex: "#FF2E7A")

    // Text
    static let primaryText = UIColor.black
    static let secondaryText = UIColor(hex: "#737373")
    static let postedAtText = UIColor(hex: "#5A5A5A")
    
    // Backgrounds
    static let screenBackground = UIColor.white
    static let loadingViewBackgroundColor = UIColor(hex: "#E5E5E5")
    static let itemBackgroundColor = UIColor(hex: "#F7F8F9")

    // Buttons
    static let buttonPrimaryBlueBackground = primaryBlue
    static let buttonPrimaryPinkBackground = primaryPink
    static let buttonAcceptFriendBackground = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
    static let buttonDeclineFriendBackground = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
    

}


/*
 OLD?
 itemInfoView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
 itemImageHolderView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
 itemNamePriceDescriptionHolderView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
 //static let accentColor = UIColor(hex: "#FF6B00")
 //static let textPrimaryColor = UIColor(hex: "#333333")
 //POSTS
 //App Text A1: Main Text for all posts
 static let textBlack = UIColor(hex: "#262626")
 
 
 
 //GROUPS
 
 //ITEMS


 */

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
