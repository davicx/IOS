//
//  AppColors.swift
//  Playground
//
//  Created by David Vasquez on 2/26/26.
//

import UIKit

extension UIColor {
    
    //APP
    
    //POSTS
    //App Text A1: Main Text for all posts 
    static let textBlack = UIColor(hex: "#262626")
    
    
    
    //GROUPS
    
    //ITEMS
    static let itemBackgroundColor = UIColor(hex: "#F7F8F9")



}

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
