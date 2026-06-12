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
    static let title = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    static let bodySemibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let body = UIFont.systemFont(ofSize: 14, weight: .regular)

    //BUTTONS
    static let button = UIFont.systemFont(ofSize: 16, weight: .semibold)

    
    //KITE
    //Kite: Post Header
    static let userName = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let postedAt = UIFont.systemFont(ofSize: 13, weight: .regular)

    
    
    //MAYBE DONT NEED
    //POST FONTS
    static let PostHeaderFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let PostBodyFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    //USER FONTS
    static let userNameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

}


