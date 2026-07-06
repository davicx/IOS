//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 5/8/26.
//

import UIKit


enum Buttons {


    //LOGIN BUTTONS
    //Login Button (Blue) 
    static func loginButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPrimaryBlueBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = Fonts.buttonLargeFont

    }
    
    //FRIEND BUTTONS
    //Current Friends Button (Blue) -> Already friends (e.g. profile "Friends")
    static func currentFriendsButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPrimaryBlueBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //Remove Friend Button (White) -> Current Friends: Clicking will Remove that friend
    static func removeFriendButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.screenBackground
        button.setTitleColor(Colors.primaryText, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    //Accept Friend Request Button (Green) -> Someone invited you to be their friend: Accept
    static func acceptFriendRequestButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonAcceptFriendBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //Add Friend Button (Blue) -> Not friends yet
    static func addFriendButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPrimaryBlueBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //Decline Friend Request Button (Red) -> Someone invited you to be their friend: Decline
    static func declineFriendRequestButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonDeclineFriendBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    

    //Friend Invite Button (Pink) -> You invited someone to be your friend
    //RE NAME TO friendInviteButtonStyle
    static func cancelFriendInviteButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPrimaryPinkBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    

    //LINK BUTTONS
    static func linkButtonStyle(button: UIButton) {
        button.setTitleColor(Colors.primaryBlue, for: .normal)
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.backgroundColor = .clear

    }

    static func linkButtonBoldStyle(button: UIButton) {
        button.setTitleColor(Colors.primaryBlue, for: .normal)
        button.titleLabel?.font = Fonts.buttonSemiboldFont
        button.backgroundColor = .clear
    }
    
    
    //EXTERNAL
    static func styleTwitterButton(_ button:UIButton) {
        button.backgroundColor = UIColor(hex: "#1DA1F2")
        button.layer.cornerRadius = 12.0
        button.tintColor = UIColor.white

        // Set the font to Helvetica Neue, size 18, bold
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    static func styleTikTokButton(_ button: UIButton) {
        button.backgroundColor = .clear // Clear background
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0 // Thin 1-point border
        button.layer.borderColor = UIColor(hex: "#E3E3E4").cgColor // Border color
        
        button.setTitleColor(UIColor(hex: "#000000"), for: .normal) // Set text color
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    }
    
    

}



//NEW
/*
 class Buttons: UIViewController {

     static func loginButtonStyle(button: UIButton) {

         button.backgroundColor = Colors.loginButtonBackground

         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 5
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
     }

     static func loginLinkButtonStyle(button: UIButton) {

         button.setTitleColor(Colors.loginLinkText, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
     }
 }
 */
