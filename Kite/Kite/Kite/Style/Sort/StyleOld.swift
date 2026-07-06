//
//  Style.swift
//  Kite
//
//  Created by David Vasquez on 1/2/25.
//


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
import UIKit






class StyleOld {
    
    
    
    
    //CLEAN BELOW
    
    //FONT
    //Used
    static let blackFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    //Used
    static let grayFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    //Used
    static let mainDarkFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    //Used
    static let mainGrayFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    //Used
    static let timeFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    //Used
    static let timeFontColor: UIColor = .gray
    
    //Used
    static let usernameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    //Used
    static let usernameFontColor: UIColor = .label
    
    //Used
    static let mainTextFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    //Used
    static let mainTextFontColor: UIColor = .label
    
    //ITEM FONT — moved to Fonts.swift + LabelStyle in Style.swift

    //Not Used
    let iconBackgroundColor = "#687684"
    
    
    //Used
    static let userNameFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    //Used
    static let groupInfoFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)

    
    //Used
    static let textBlack: UIColor = .black
    //Used
    static let textGray: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
    //Used
    static let textDarkGray: UIColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    //Used
    static let textClear: UIColor = .clear
    

    //Used
    static func styleUserNameLabel(_ label: UILabel) {
        label.font = userNameFont
        label.textColor = textBlack
        label.backgroundColor = textClear
    }
    
    //Used
    static func styleGroupInfoLabel(_ label: UILabel) {
        label.font = groupInfoFont
        label.textColor = textGray
        label.backgroundColor = textClear
    }
    
    //Used
    static func styleUserNameText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // Light gray like Instagram
        label.backgroundColor = .clear
    }
    
    //Used
    static func styleSocialCountText(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .left
    }
    
    // Convenience methods for comprehensive font styles
    //Used
    static func styleTimeText(_ label: UILabel) {
        label.font = timeFont
        label.textColor = timeFontColor
    }
    
    //Used
    static func styleUsernameText(_ label: UILabel) {
        label.font = usernameFont
        label.textColor = usernameFontColor
    }
    
    
    
    //Not Used
    static func styleMainText(_ label: UILabel) {
        label.font = mainTextFont
        label.textColor = mainTextFontColor
    }
    
    //ITEM LABELS — moved to LabelStyle in Style.swift

    //IMAGES
    //Used
    static func styleGroupImage(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
    }
    
    
    //LABELS

    


}





//FILES
/*
 DesignSystem
 ├── Colors
 │   ├── AppColors.swift
 │   └── SemanticColors.swift
 │
 ├── Fonts
 │   └── AppFonts.swift
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
