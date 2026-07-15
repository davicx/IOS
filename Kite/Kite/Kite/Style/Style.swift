//
//  Style.swift
//  Kite
//
//  Created by David Vasquez on 4/14/26.
//




import UIKit



//LABELS
enum LabelStyle {

    //Post
    static func postEventTitle(_ label: UILabel) {
        label.font = Fonts.postEventTitleFont
        label.textColor = Colors.primaryText
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
    }

    static func postEventDetails(_ label: UILabel) {
        label.font = Fonts.postEventDetailsFont
        label.textColor = Colors.postedAtTextColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
    }

    //Item
    static func itemName(_ label: UILabel) {
        label.font = Fonts.itemNameFont
        label.textColor = .label
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
    }

    static func itemPrice(_ label: UILabel) {
        label.font = Fonts.itemPriceFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
    }

    static func itemDescription(_ label: UILabel) {
        label.font = Fonts.itemDescriptionFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    static func itemLink(_ label: UILabel) {
        label.font = Fonts.itemLinkFont
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingMiddle
    }

}


// TEXT VIEWS (Single Line of text)
enum TextViewStyle {
    
}


// VIEWS
enum ViewStyle {
    
}


// TEXT FIELDS
enum TextFieldStyle {
    
    //LOGIN
    static func login(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hex: "#FAFAFA")
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        textField.textColor = UIColor.black.withAlphaComponent(0.8)
        textField.font = UIFont(name: "SFProText-Regular", size: 14)
        textField.layer.masksToBounds = true

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }

}









/*
struct StyleConstants {
    static let postHeader: CGFloat = 40
    static let postSocials: CGFloat = 40
    static let postDivider: CGFloat = 5
}
 */

//APPENDIX
/*
 Style
 ├── Elements
 │   └── AppElements.swift
 │
 ├── Text and Fonts
 │   └── AppText.swift
 │
 ├── Style
 │   └── AppStyle.swift
 │
 └── Buttons
 │   └── AppButtons.swift
 │
 ├── Colors
 │   └── AppColors.swift
 
 
 Elements
 Buttons
 Text
 Colors
 Fonts
 
 Style
 ├── Colors
 │   ├── AppColors.swift (more generic like appGray)
 │   └── SemanticColors.swift (Specific FriendBorderRed)
 │
 ├── Fonts
 │   └── AppFonts.swift
 │
 ├── Style
 │   └── AppStyle.swift (Had this before but most stuff seems to be getting put in other files)
 │
 └── Components
     ├── AppButtons.swift
     ├── AppElements.swift (buttons, labels, dividers)
 
 
 */

/*
 Things to watch
 Font vs color coupling
 In Style.swift you have pairs like timeFont + timeFontColor, usernameFont + usernameFontColor. Decide whether those live in AppFonts (and you reference semantic colors from SemanticColors) or in a small AppStyle (or a “text styles” file). Either way, keep the rule consistent so you don’t split the same concept across too many places.
 StyleConstants
 You have things like postHeader, postSocials, postDivider (layout/sizing constants). They could live under Style (e.g. AppStyle.swift or LayoutConstants.swift) or in a Layout/Spacing file. Your plan doesn’t mention constants; adding one line for “layout/spacing constants” would make the structure clear.
 Naming
 “App” prefix is clear. Just keep it consistent (e.g. all in that folder use App* or all use a different convention) so the boundary between app design system and feature-specific style stays obvious.
 Hex initializer
 UIColor(hex:) in your current Colors file is a utility, not a color token. It could stay in AppColors at the bottom, or move to a small UIColor+Hex extension file if you want Colors to be only tokens.
 */




















//ALL OLD BELOW DONT TOUCH BUT CAN PULL FROM 
//Instagram Background Gray F3F5F7

//FILES
/*
 DesignSystem
 ├── Style (All the main style components)
 │   ├── Elements (Style text field, etc)
 │   ├── Text (combo of text and color
 │   ├── Colors
 │   ├── Fonts
 ├── Buttons
 │   └── AppStyle.swift

 */




/*
 DesignSystem
 ├── Colors
 │   ├── AppColors.swift
 │   └── SemanticColors.swift
 │
 ├── Fonts
 │   └── AppFonts.swift
 │       └── PostHeaderFont
 │       └── PostBodyFont
 │       └── PostUserNameFont (maybe same PostTimeFont)
 │       └── PostTimeFont
 │
 ├── Style
 │   └── AppStyle.swift
 │
 └── Components
     ├── PrimaryButton.swift
     ├── SecondaryButton.swift
     └── StyledLabel.swift

 */







/*
STYLE
 - Fonts
UI ELEMEMENS
BUTTONS
COLORS
*/
 
/*

class StyleOld {
    
    
    
    
    //CLEAN BELOW
    
    //FONT
    static let blackFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let grayFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let mainDarkFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let mainGrayFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    static let timeFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let timeFontColor: UIColor = .gray
    
    static let usernameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let usernameFontColor: UIColor = .label
    
    static let mainTextFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let mainTextFontColor: UIColor = .label
    
    //ITEM FONT
    static let itemNameFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let itemPriceFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let itemDescriptionFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let itemLinkFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)


    let iconBackgroundColor = "#687684"
    
    
    static let userNameFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let groupInfoFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)

    
    static let textBlack: UIColor = .black
    static let textGray: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    static let textDarkGray: UIColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    static let textClear: UIColor = .clear
    

    static func styleUserNameLabel(_ label: UILabel) {
        label.font = userNameFont
        label.textColor = textBlack
        label.backgroundColor = textClear
    }
    
    static func styleGroupInfoLabel(_ label: UILabel) {
        label.font = groupInfoFont
        label.textColor = textGray
        label.backgroundColor = textClear
    }
    
    static func styleUserNameText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // Light gray like Instagram
        label.backgroundColor = .clear
    }
    
    static func styleSocialCountText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .left
    }
    
    // Convenience methods for comprehensive font styles
    static func styleTimeText(_ label: UILabel) {
        label.font = timeFont
        label.textColor = timeFontColor
    }
    
    static func styleUsernameText(_ label: UILabel) {
        label.font = usernameFont
        label.textColor = usernameFontColor
    }
    
    
    
    static func styleMainText(_ label: UILabel) {
        label.font = mainTextFont
        label.textColor = mainTextFontColor
    }
    
    //ITEM LABELS
    static func styleItemNameLabel(_ label: UILabel) {
        label.font = itemNameFont
        label.textColor = .label
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
    }
    
    static func styleItemPriceLabel(_ label: UILabel) {
        label.font = itemPriceFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
    }
    
    static func styleItemDescriptionLabel(_ label: UILabel) {
        label.font = itemDescriptionFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    
    
    static func styleItemLinkLabel(_ label: UILabel) {
        label.font = itemLinkFont
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingMiddle
    }
    
    //IMAGES
    static func styleGroupImage(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
    }
    
    
    //LABELS
    static func styleLoginLabel(_ label: UILabel) {
        label.backgroundColor = UIColor(hex: "#FAFAFA") // Background color
        label.layer.cornerRadius = 5.0 // Rounded corners
        label.layer.borderWidth = 0.5 // Thin border
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor // Border at 10% opacity
        
        label.textColor = UIColor.black.withAlphaComponent(0.2) // Text color at 20% opacity
        label.font = UIFont(name: "SFProText-Regular", size: 14) // SF Pro Text, Regular, size 14
        
        label.layer.masksToBounds = true // Ensure rounded corners apply

        // Add left padding
        let padding = String(repeating: " ", count: 2) // Adjust count as needed
        label.text = "\(padding)\(label.text ?? "")"
    }
    
    static func styleLoginTextField(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hex: "#FAFAFA")
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        textField.textColor = UIColor.black.withAlphaComponent(0.8)
        textField.font = UIFont(name: "SFProText-Regular", size: 14)
        textField.layer.masksToBounds = true
        
        // Left padding using a UIView
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    

}
*/


