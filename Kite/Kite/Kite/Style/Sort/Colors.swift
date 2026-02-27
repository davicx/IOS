//
//  Colors.swift
//  Kite
//
//  Created by David Vasquez on 10/25/25.
//

import UIKit



extension UIColor {
    static let itemBackgroundColor = UIColor(hex: "#F7F8F9")
    //static let accentColor = UIColor(hex: "#FF6B00")
    //static let textPrimaryColor = UIColor(hex: "#333333")
}

/*
 itemInfoView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
 itemImageHolderView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
 itemNamePriceDescriptionHolderView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
 
 */
//STYLE
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

