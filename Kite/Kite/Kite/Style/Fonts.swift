//
//  Fonts.swift
//  Kite
//
//  Created by David Vasquez on 4/14/26.
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


class Fonts {
    
    
    //MAIN FONTS
    static let PostHeaderFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let PostBodyFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let userNameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

}



