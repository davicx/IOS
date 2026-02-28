//
//  AppText.swift
//  Kite
//
//  Created by David Vasquez on 2/26/26.
//

import UIKit

// MARK: - Main text style (Instagram-like body)

private let mainTextFont = UIFont.systemFont(ofSize: 15, weight: .regular)

enum AppText {
    static func mainTextStyle(_ label: UILabel) {
        label.font = mainTextFont
        label.textColor = UIColor.textBlack
        label.numberOfLines = 0
    }
}




extension UILabel {
    func mainTextStyle() {
        AppText.mainTextStyle(self)
    }
}

/*
 Usage:
 let label = UILabel()
 label.mainTextStyle()

 */

//TEXT A: Generic Site Wide Text

//TEXT B: Specific Text




/*

FUNCTIONS A: All Functions Related to Friend Actions
    1) Function A1: Add Friend
    2) Function A2: Remove Friend
    3) Function A3: Accept Friend Invite
    4) Function A4: Decline Friend Invite
    5) Function A5: Cancel Friend Request
 
FUNCTIONS B: All Functions Related Friend Information
    1) Function B1: Get all Group Posts
    2) Function B2: Get the Current Users Friends
    3) Function B3: Get Another Users Friends
    4) Function B4: Update User Profile Information
*/
