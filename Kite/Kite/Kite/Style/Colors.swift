//
//  Colors.swift
//  Kite
//
//  Created by David Vasquez on 5/28/26.
//

import UIKit


class Colors {

    //APP MAIN
    //Kite Main Colors
    static let primaryBlue = UIColor(hex: "#3797EF")
    static let primaryPink = UIColor(hex: "#FF2E7A")

    //Text
    static let primaryText = UIColor.black
    static let secondaryText = UIColor(hex: "#737373")
    static let tertiaryText = UIColor(hex: "#5A5A5A")
    static let darkGrayText = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    static let grayTextColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
    static let darkSecondaryText = UIColor(hex: "#5F5F5F")

    //Status
    static let successGreen = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
    static let dangerRed = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
    
    //Backgrounds
    static let screenBackground = UIColor.white
    static let loadingViewBackgroundColor = UIColor(hex: "#E5E5E5")
    static let itemBackgroundColor = UIColor(hex: "#F7F8F9")

    // Item Detail (Wishlist layout / temporary placeholder visibility)
    static let itemDetailBackground = UIColor(hex: "#F3F1EE")
    static let itemDetailContent = UIColor.white
    static let itemDetailPlaceholder = UIColor(hex: "#E4E1DC")
    static let itemDetailDivider = UIColor(hex: "#D8D5D0")

    //Buttons
    static let tikTokPink = UIColor(hex: "#EF3D57")
    static let tikTokGray = UIColor(hex: "#F1F1F2")
    
    
    //IN APP USE
    //Groups

    // Profile
    static let profileFullNameTextColor = primaryText
    static let profileUserNameTextColor = grayTextColor
    static let userInfoCountTextColor = primaryText
    static let userInfoDescriptionTextColor = grayTextColor
    
    
    //Posts
    static let postCaptionFontColor = primaryText
    static let postedAtTextColor = tertiaryText
    static let postHeaderEventTitleTextColor = primaryText
    static let postHeaderEventTimeTextColor = darkSecondaryText
    

    //Buttons
    static let buttonLoginBackground = primaryBlue
    static let buttonAddFriendBackground = primaryBlue
    static let buttonCurrentFriendsBackground = primaryBlue
    static let buttonFriendInviteBackground = primaryPink
    static let buttonAcceptFriendBackground = successGreen
    static let buttonDeclineFriendBackground = primaryPink
    static let buttonRemoveFriendBackground = screenBackground
    static let buttonPinkBackground = tikTokPink
    static let buttonGrayBackground = tikTokGray
    static let buttonWishlistActionBackground = screenBackground
    static let buttonWishlistActionBorder = itemDetailDivider
    static let buttonWishlistActionText = primaryText

    // New Item option cards
    static let newItemPasteCardBackground = primaryPink.withAlphaComponent(0.08)
    static let newItemPasteIconBackground = primaryPink.withAlphaComponent(0.18)
    static let newItemPhotoCardBackground = primaryBlue.withAlphaComponent(0.08)
    static let newItemPhotoIconBackground = primaryBlue.withAlphaComponent(0.18)
    static let newItemManualCardBackground = UIColor(hex: "#F4F4F5")
    static let newItemManualIconBackground = UIColor(hex: "#E8E8EA")
    static let newItemCardBorder = UIColor(hex: "#E5E5E7")
    static let newItemInfoBackground = UIColor(hex: "#F2F3F5")

    
    //static let buttonAcceptFriendBackground = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
    //static let buttonDeclineFriendBackground = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)


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
