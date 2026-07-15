//
//  Fonts.swift
//  Kite
//
//  Created by David Vasquez on 4/14/26.
//

import UIKit

class Fonts {

    //BASE FONTS
    static let regular12 = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let regular13 = UIFont.systemFont(ofSize: 13, weight: .regular)
    static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)

    static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)

    static let semibold14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let semibold16 = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let semibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let semibold18 = UIFont.systemFont(ofSize: 18, weight: .semibold)

    //APP FONTS

    // Post
    static let postEventTitleFont = semibold16
    static let postEventDetailsFont = regular14

    static let postCaptionFont = regular14
    static let postUsernameFont = semibold15
    static let postedAtFont = regular12
    
    // Profile
    static let profileFullNameFont = semibold16
    static let profileUserNameFont = semibold14
    static let userInfoCountFont = semibold18
    static let userInfoDescriptionFont = semibold16

    // Item
    static let itemNameFont = semibold16
    static let itemPriceFont = medium15
    static let itemDescriptionFont = regular14
    static let itemLinkFont = regular13

    // Buttons
    static let buttonLargeFont = semibold16
    static let buttonRegularFont = regular14
    static let buttonSemiboldFont = semibold14
    static let buttonTikTokFont = semibold15
}


