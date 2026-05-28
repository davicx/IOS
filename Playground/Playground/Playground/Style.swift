//
//  Style.swift
//  Playground
//
//  Created by David Vasquez on 5/25/26.
//


import UIKit


/*
 DesignSystem
 ├── Style
 │   ├── Colors
 │   ├── Fonts
 │   └── Text (text and color)
 │
 ├── Buttons
 │   ├── Login Buttons
 │
 ├── Elements (style a text field)
 │
 └── Extensions
 */

//TEXTS
enum Text {

    static func postBodyText(label: UILabel) {
        label.font = Fonts.regular14
        label.textColor = .postBodyTextColor
        label.numberOfLines = 0

    }

}

//FONTS
enum Fonts {
    static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let semiBold16 = UIFont.systemFont(
        ofSize: 16,
        weight: .semibold
    )

}

//ELEMENTS
enum Elements {
    static func styleProfileHolder(view: UIView) {
        view.backgroundColor = .profileHolderBackground
        view.layer.cornerRadius = 12
    }
    
    static func postDivider(view: UIView) {
        view.backgroundColor = .postDividerColor
    }
    
    
}



//BUTTONS
enum Buttons {

    static func acceptFriendButton(button: UIButton) {
        button.backgroundColor = .acceptFriendButtonBackground
        button.setTitleColor(
            .white,
            for: .normal
        )

        button.titleLabel?.font = Fonts.semiBold16
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}

//COLORS
extension UIColor {

    static let profileHolderBackground = UIColor(
        hex: "#D9D9D9"
    )

    static let postBodyTextColor = UIColor(
        hex: "#262626"
    )
    
    static let acceptFriendButtonBackground = UIColor(
        hex: "#1FA855"
    )
    
    
    static let postDividerColor = UIColor(
        hex: "#E5E5E5"
    )
}


















extension UIColor {

    convenience init(hex: String) {

        var hexSanitized = hex.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        hexSanitized = hexSanitized.replacingOccurrences(
            of: "#",
            with: ""
        )

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0

        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0

        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0
        )

    }

}
