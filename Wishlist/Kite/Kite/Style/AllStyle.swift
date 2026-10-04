//
//  AllStyle.swift
//  Kite
//
//  Reference dump of everything in Style/ (excludes Sort/).
//  Fully commented so it does not conflict with live Colors / Fonts / etc.
//  Source files remain the real definitions.
//

import UIKit


/*
 ============================================================
 COLORS — from Colors.swift
 ============================================================

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

    // Text — darkest to lightest
    static let primaryGrayText = UIColor.black
    static let secondaryGrayText = UIColor(hex: "#4D4D4D")
    static let tertiaryGrayText = UIColor(hex: "#5A5A5A")
    static let mutedGrayText = UIColor(hex: "#5F5F5F")
    static let subtleGrayText = UIColor(hex: "#737373")
    // Old text tokens (replaced):
    // static let primaryText = UIColor.black
    // static let secondaryText = UIColor(hex: "#737373")
    // static let tertiaryText = UIColor(hex: "#5A5A5A")
    // static let darkGrayText = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    // static let grayTextColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
    // static let darkSecondaryText = UIColor(hex: "#5F5F5F")

    //Status
    static let successGreen = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
    static let dangerRed = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
    
    //Backgrounds
    static let screenBackground = UIColor.white
    static let feedBackground = UIColor(hex: "#F3F3F3")
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

    // Profile
    static let profileFullNameTextColor = primaryGrayText
    static let profileUserNameTextColor = subtleGrayText
    static let userInfoCountTextColor = primaryGrayText
    static let userInfoDescriptionTextColor = subtleGrayText
    
    
    //Posts
    static let postCaptionFontColor = primaryGrayText
    static let postedAtTextColor = tertiaryGrayText
    static let postHeaderEventTitleTextColor = primaryGrayText
    static let postHeaderEventTimeTextColor = mutedGrayText
    static let separator = UIColor(hex: "#ECECEC")
    

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
    static let buttonWishlistActionText = primaryGrayText

    //Items
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

 ============================================================
 FONTS — from Fonts.swift
 ============================================================

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
    static let regular15 = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let regular16 = UIFont.systemFont(ofSize: 16, weight: .regular)

    static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)

    static let semibold14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let semibold16 = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let semibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let semibold18 = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let semibold20 = UIFont.systemFont(ofSize: 20, weight: .semibold)

    //APP FONTS

    // Post
    static let postHeaderEventTitleFont = semibold15
    static let postHeaderEventTimeFont = regular13

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

    // List
    static let listNameFont = semibold18
    static let listDescriptionFont = regular14

    // New Item (chooser)
    static let newItemIntroTitleFont = UIFont.systemFont(ofSize: 28, weight: .bold)
    static let newItemIntroSubtitleFont = regular15
    static let newItemOptionTitleFont = semibold17
    static let newItemOptionSubtitleFont = regular14
    static let newItemInfoFont = regular13

    // Buttons
    static let buttonLargeFont = semibold16
    static let buttonRegularFont = regular14
    static let buttonSemiboldFont = semibold14
    static let buttonTikTokFont = semibold15
    static let buttonCompactFont = regular12
}


//OLD
//static let postEventTitleFont = semibold16
//static let postEventDetailsFont = regular14



 ============================================================
 LAYOUT — from Layout.swift
 ============================================================

//
//  Layout.swift
//  Kite
//
//  Created by David Vasquez on 8/11/26.
//

import UIKit


enum Layout {

    // MARK: - Spacing

    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 12
    static let spacingL: CGFloat = 16
    static let spacingXL: CGFloat = 24
    static let spacingXXL: CGFloat = 32

    // MARK: - Common Sizes

    static let iconSize: CGFloat = 24
    static let touchTargetSize: CGFloat = 40
}



/*
 Layout is for consistency — not for eliminating every number.

 Use Layout when the same kind of UI relationship should feel the same
 across the app (e.g. text→text gaps, outer padding, icon size).

 Do NOT invent one-off values for the same relationship:
   BAD:  8pt between name and price in one place, 5pt in another
   GOOD: both use Layout.spacingXS (or whatever token you chose)

 It is fine to hardcode component-specific geometry that only describes
 that component (card height, image column %, unique one-off sizes).

 Do not force every constant through Layout. Only standardize what is
 reused so the app stays visually consistent.
 */

 ============================================================
 STYLE — from Style.swift
 ============================================================

//
//  Style.swift
//  Kite
//
//  Created by David Vasquez on 4/14/26.
//




import UIKit



//LABELS
enum LabelStyle {

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

    // Temporary layout blocks — full width comes from parent constraints
    static func placeholderContent(
        in view: UIView,
        title: String,
        backgroundColor: UIColor,
        height: CGFloat
    ) {
        view.backgroundColor = backgroundColor

        let label = UILabel()
        label.text = title
        label.font = Fonts.semibold14
        label.textColor = Colors.primaryGrayText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
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







 ============================================================
 BUTTONS — from Buttons.swift
 ============================================================

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
        button.backgroundColor = Colors.buttonLoginBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = Fonts.buttonLargeFont

    }
    
    //FRIEND BUTTONS
    //Current Friends Button (Blue) -> Already friends (e.g. profile "Friends")
    static func currentFriendsButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonCurrentFriendsBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //Remove Friend Button (White) -> Current Friends: Clicking will Remove that friend
    static func removeFriendButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonRemoveFriendBackground
        button.setTitleColor(Colors.primaryGrayText, for: .normal)
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
        button.backgroundColor = Colors.buttonAddFriendBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //Decline Friend Request Button (Pink) -> Someone invited you to be their friend: Decline
    static func declineFriendRequestButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonDeclineFriendBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    

    //Friend Invite Button (Pink) -> You invited someone to be your friend
    static func friendInviteButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonFriendInviteBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonRegularFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    

    //GENERAL BUTTONS
    static func buttonPinkStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPinkBackground
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonTikTokFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    // Wishlist item — full-width Purchase (cart + title); slightly rounded, not a pill
    static func wishlistPurchaseButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonPinkBackground
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonTikTokFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
    }

    static func buttonGrayStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonGrayBackground
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonTikTokFont
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    //WISHLIST BUTTONS
    //Invite Friends / Share List — outlined pills
    static func wishlistInviteFriendsButtonStyle(button: UIButton) {
        wishlistListActionButtonStyle(button: button)
    }

    static func wishlistShareListButtonStyle(button: UIButton) {
        wishlistListActionButtonStyle(button: button)
    }

    private static func wishlistListActionButtonStyle(button: UIButton) {
        button.backgroundColor = Colors.buttonWishlistActionBackground
        button.setTitleColor(Colors.buttonWishlistActionText, for: .normal)
        button.tintColor = Colors.buttonWishlistActionText
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.buttonWishlistActionBorder.cgColor
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.titleLabel?.font = Fonts.buttonCompactFont
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
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

 ============================================================
 IMAGE STYLE — from ImageStyle.swift
 ============================================================

//
//  ImageStyle.swift
//  Kite
//
//  Created by David Vasquez on 5/29/26.
//

import UIKit


class ImageStyle {

    static func loginBackgroundImage(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.contentsRect = CGRect(
            x: 0.25,
            y: 0,
            width: 0.5,
            height: 1
        )
    }

    static func userProfileImage(imageView: UIImageView, diameter: CGFloat) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = diameter / 2
    }

    static func postImage(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = Colors.screenBackground
    }
}

 ============================================================
 DIVIDERS — from Dividers.swift
 ============================================================

//
//  Dividers.swift
//  Kite
//
//  Created by David Vasquez on 7/11/26.
//

import UIKit


//Full-width hairline matching the default UITableView separator (color + 1px height), with no leading inset.
//Includes 4pt clear space below the line for breathing room between posts.
final class MainDivider: UIView {

    private let lineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        lineView.backgroundColor = .separator
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
            bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 4)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Post feed cell chrome: top/bottom hairlines, white content bg, gray gap below.
// Content pins to contentTopAnchor … contentBottomAnchor; call linkContentBottom(to:) last.
final class ItemDivider: UIView {

    //UI COMPONENTS
    private let topBorderView = UIView()
    private let postBackgroundView = UIView()
    private let bottomBorderView = UIView()
    private let bottomSpacingView = UIView()

    private let hairline = 1 / UIScreen.main.scale
    private var contentBottomConstraint: NSLayoutConstraint?

    var contentTopAnchor: NSLayoutYAxisAnchor { topBorderView.bottomAnchor }
    var contentBottomAnchor: NSLayoutYAxisAnchor { bottomBorderView.topAnchor }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = Colors.separator
        addSubview(topBorderView)

        postBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        postBackgroundView.backgroundColor = Colors.screenBackground
        addSubview(postBackgroundView)

        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = Colors.separator
        addSubview(bottomBorderView)

        bottomSpacingView.translatesAutoresizingMaskIntoConstraints = false
        bottomSpacingView.backgroundColor = .clear
        addSubview(bottomSpacingView)

        NSLayoutConstraint.activate([
            topBorderView.topAnchor.constraint(equalTo: topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: hairline),

            bottomSpacingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSpacingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSpacingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSpacingView.heightAnchor.constraint(equalToConstant: Layout.spacingS),

            bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: hairline),
            bottomBorderView.bottomAnchor.constraint(equalTo: bottomSpacingView.topAnchor),

            postBackgroundView.topAnchor.constraint(equalTo: topBorderView.bottomAnchor),
            postBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postBackgroundView.bottomAnchor.constraint(equalTo: bottomBorderView.topAnchor)
        ])

        sendSubviewToBack(postBackgroundView)
    }

    func install(in contentView: UIView) {
        contentView.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: contentView.topAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        contentView.sendSubviewToBack(self)
    }

    func linkContentBottom(to anchor: NSLayoutYAxisAnchor) {
        contentBottomConstraint?.isActive = false
        contentBottomConstraint = bottomBorderView.topAnchor.constraint(equalTo: anchor)
        contentBottomConstraint?.isActive = true
    }
}

// Temporary full-width black 2pt divider (e.g. between groups on Groups page).
final class ThickBlackDivider: UIView {

    private let lineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        lineView.backgroundColor = .black
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            bottomAnchor.constraint(equalTo: lineView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 ============================================================
 STYLE DOC — from StyleDoc.swift
 ============================================================

//
//  StyleDoc.swift
//  Kite
//
//  Created by David Vasquez on 7/3/26.
//

import Foundation


//
//  StyleDesignExample.swift
//  Kite
//
//  Created by David Vasquez on 5/28/26.
//



//HOW TO APPLY STYLE
/*
class ViewController: UIViewController {

    let titleLabel = UILabel()
    let profileContainerView = UIView()
    let dividerView = UIView()
    let actionButton = UIButton(type: .system)
    let usernameTextField = UITextField()
    let colorView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("HelloStyleWorldViewController")

        setupViews()
        setupConstraints()
    }

    func setupViews() {

        view.backgroundColor = .white

        //Text
        titleLabel.text = "Hello Style World"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        //Using Style
        Text.postBodyText(label: titleLabel)
        view.addSubview(titleLabel)

        //Element
        profileContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileContainerView)

        //Divider
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        Elements.postDivider(view: dividerView)
        view.addSubview(dividerView)

        //Button
        actionButton.setTitle("Accept", for: .normal)

        //style
        Buttons.acceptFriendButton(button: actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)

        //Input Field
        usernameTextField.placeholder = "Username"
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)

        //Color View
        colorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            //Text
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //Element
            profileContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileContainerView.widthAnchor.constraint(equalToConstant: 140),
            profileContainerView.heightAnchor.constraint(equalToConstant: 200),

            //Divider
            dividerView.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: 30),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            //Button
            actionButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 220),
            actionButton.heightAnchor.constraint(equalToConstant: 44),

            //Input Field
            usernameTextField.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 30),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 260),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),

            //Color View
            colorView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40)

        ])
    }

}
*/


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

/*
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


*/





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









//BUTTONS

/*
static func styleLoginFilledButton(_ button:UIButton) {
    button.backgroundColor = UIColor(hex: "#EA4359")
    button.layer.cornerRadius = 16.0
    button.tintColor = UIColor.white

    // Set the font to Helvetica Neue, size 18, bold
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
}

static func styleForgotPasswordButton(_ button: UIButton) {
    button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal) // Font color
    button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 8) // Font
    button.backgroundColor = .clear // Transparent background
}
 

static func styleLoginButton(_ button: UIButton) {
    button.setTitleColor(.white, for: .normal) // White text color
    button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12) // Font
    button.backgroundColor = UIColor(hex: "#3797EF") // Background color
    button.layer.cornerRadius = 5 // Rounded corners
}
*/





/*
static func loginButton(_ button: UIButton) {
    button.backgroundColor = UIColor(hex: "#FAFAFA") // Background color

    button.layer.cornerRadius = 5.0 // Rounded corners
    button.layer.borderWidth = 0.5 // Thin border
    button.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor // Border at 10% opacity

    button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .normal) // Text color at 20% opacity
    button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 14) // SF Pro Text, Regular, size 14
}
 */

/*
static func styleTikTokButton(_ button: UIButton) {
    button.backgroundColor = .clear // Clear background
    button.layer.cornerRadius = 4.0
    button.layer.borderWidth = 1.0 // Thin 1-point border
    button.layer.borderColor = UIColor(hex: "#E3E3E4").cgColor
    button.tintColor = UIColor.white
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
}
 */
/*
static func styleTikTokButton(_ button:UIButton) {
    //button.backgroundColor = UIColor(hex: "#EA4359")
    button.layer.cornerRadius = 4.0
    button.tintColor = UIColor.white
    
    //E3E3E4

    // Set the font to Helvetica Neue, size 18, bold
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
}
 */


//Temp.styleTextField(userNameTextField)
//Buttons.styleLoginFilledButton(sayHiButtonStyle)
//sayHiButtonStyle.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)


/*
 let button = UIButton(type: .system)

 // Set the button's font
 button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)

 // Set the tint color
 button.tintColor = UIColor.white

 // Optionally, set a title to see the font style
 button.setTitle("Press Me", for: .normal)

static func styleLoginTextField(_ textfield:UITextField) {
    
    // Create the bottom line
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
    
    // Remove border on text field
    textfield.borderStyle = .none
    
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
    
}



static func styleLoginHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
}
 */


//ELEMENTS
/*
static func styleTextField(_ textfield:UITextField) {
    
    // Create the bottom line
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
    
    // Remove border on text field
    textfield.borderStyle = .none
    
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
    
}

static func styleFilledButton(_ button:UIButton) {
    
    // Filled rounded corner style
    button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.white
}

static func styleHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
}

static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}

 /*
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
  /*
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
   */
 */
 
 
*/


 ============================================================
 LAYOUT GUIDE — from LayoutGuide.md
 ============================================================

# Kite Style How To

Kite uses a small consumer-mobile design system.

The goal is not to create a large enterprise design system.
The goal is to keep the app visually consistent, compact, and easy to extend without every screen drifting in a different direction.

Kite should feel:

- clean
- content-first
- mostly white / black / gray
- restrained with brand color
- typography-led
- compact and modern
- friendly, not corporate

---

## Core Rule

**Before adding a new visual value, check `Colors`, `Fonts`, and `Layout`. Reuse an existing token when it fits. Add a new token only when the design genuinely requires a new visual role.**

---

## Two Layers

Kite styling uses two layers:

### 1. Tokens

Tokens define the visual vocabulary.

Examples:

- `Colors.primaryBlue`
- `Colors.primaryGrayText`
- `Fonts.semibold16`
- `Layout.spacingMedium`
- `Layout.radiusSmall`

These are the raw reusable building blocks.

### 2. Semantic styles

Semantic styles define how Kite components use the tokens.

Examples:

- `Fonts.postUsernameFont`
- `Fonts.postCaptionFont`
- `Colors.postedAtTextColor`
- `Buttons.loginButtonStyle(button:)`
- `LabelStyle.postEventTitle(_:)`

These are component-facing names that keep the app readable.

Rule:

**Tokens define the visual vocabulary. Semantic styles define how Kite components use that vocabulary.**

---

## Style Folder Responsibilities

### `Colors.swift`

Contains:

- base color tokens
- semantic color aliases

Examples:

- token: `primaryBlue`
- token: `primaryGrayText`
- semantic alias: `buttonLoginBackground`
- semantic alias: `postedAtTextColor`

Use `Colors.swift` when choosing a color.

Do not define raw hex or custom `UIColor(red:)` values in feature components unless testing temporarily.

### `Fonts.swift`

Contains:

- base font tokens
- semantic component font aliases

Examples:

- token: `regular14`
- token: `semibold16`
- semantic alias: `postCaptionFont`
- semantic alias: `profileFullNameFont`

Use `Fonts.swift` when choosing typography.

Component-specific font names are encouraged even when several resolve to the same base token.

For example:

- `postUsernameFont`
- `commentUsernameFont`
- `groupNameFont`

may all point to the same underlying token.

That is useful abstraction, not duplication.

### `Layout.swift`

Contains shared layout tokens:

- spacing
- corner radius
- icon sizes
- avatar sizes
- border widths

This file exists to reduce arbitrary layout values.

Use `Layout.swift` before introducing new hard-coded spacing or size numbers.

### `Style.swift`

Contains reusable styling helpers for UI elements.

Examples:

- `LabelStyle`
- `TextFieldStyle`
- `ViewStyle`

Use this when multiple components style the same kind of UIKit view in the same way.

### `Buttons.swift`

Contains shared button appearances.

Examples:

- login button
- friend state buttons
- generic filled/gray buttons
- link buttons

If a button pattern appears in more than one place, move it here.

### `ImageStyle.swift`

Contains reusable image treatments.

Examples:

- avatar image styling
- post image styling
- background image styling

### `Dividers.swift`

Contains divider components and divider-like shared visual structure.

Use when a divider pattern repeats.

---

## Typography Rules

Kite should use one primary font family with a small set of sizes and mostly regular + semibold.

### Base roles

- `title`
- `heading`
- `body`
- `caption`

### Typical use

- `title`: page titles
- `heading`: group names, important names, section headings
- `body`: main content, posts, comments, primary button text
- `caption`: timestamps, metadata, helper text

### Weight guidance

Prefer:

- regular
- semibold

Use bold only when there is a clear reason.

### Component examples

- post username -> body semibold
- post text -> body regular
- post timestamp -> caption regular
- comment username -> body semibold
- comment text -> body regular
- group name -> heading semibold
- page title -> title semibold/bold
- button text -> body semibold

Rule:

**Do not choose a new font for every component. Start from the existing type roles.**

---

## Color Rules

Most of Kite should remain neutral.

### Preferred roles

#### Background

- `background`
- `surface`

#### Text

- `textPrimary`
- `textSecondary`
- `textTertiary`

#### Structure

- `border`
- `divider`

#### Brand

- `primary`
- `accent`

#### State

- `success`
- `danger`

Kite blue and pink are part of the app identity, but they should be used intentionally.

Rule:

**Most UI should be white + black + gray. Brand colors should emphasize interaction or priority, not decorate every surface.**

Examples:

- timestamp -> `textSecondary` or `textTertiary`
- divider -> `divider`
- card background -> `surface`
- main CTA -> `primary`
- supportive accent action -> `accent`

---

## Layout Rules

Kite uses a 4-point spacing system.

Preferred values:

- 4
- 8
- 12
- 16
- 24
- 32

These should become shared layout tokens in `Layout.swift`.

### Typical usage

- icon to text -> 8
- username to timestamp -> 4
- title to subtitle -> 4
- content block padding -> 12 or 16
- screen horizontal inset -> 16
- section separation -> 24
- major separation -> 32

Rule:

**Avoid arbitrary spacing values unless there is a specific visual reason.**

---

## Shape Rules

Kite should use a small shape vocabulary.

### Corner radius

Use a small set of standard radii, for example:

- small
- medium
- large
- circle

### Icons

Use a small set of icon sizes, for example:

- small
- normal
- large

### Avatars

Use a small set of avatar sizes, for example:

- small
- normal
- large

### Borders

Use a small set of border widths and border colors.

Rule:

**Do not let every component invent its own radius, icon size, avatar size, or border treatment.**

---

## Building a New Component

When creating a new component:

1. Start with layout and hierarchy.
2. Use spacing from `Layout.swift`.
3. Use fonts from `Fonts.swift`.
4. Use colors from `Colors.swift`.
5. If repeated label styling appears, move it into `LabelStyle`.
6. If repeated image styling appears, move it into `ImageStyle`.
7. If repeated button styling appears, move it into `Buttons.swift`.
8. Only add a new token if an existing token truly does not fit.

Rule:

**When something looks wrong, first adjust spacing, alignment, hierarchy, or emphasis. Do not immediately invent a new color, font, radius, or border.**

---

## Migration Strategy

Do not attempt a broad visual migration all at once.

Preferred order:

1. write the rules
2. add `Layout.swift`
3. migrate 2-3 visible components
4. evaluate whether the system is actually helping
5. continue gradually as files are touched

Good first migration targets:

- `PostContent`
- `PostCaption`
- profile name / username / info counts
- friend buttons
- group headers

These are visible, compact, and already partly tokenized.

---

## Practical Kite Rule

Kite uses one typography system, one color system, a 4pt spacing grid, and a small set of standard shapes. New UI should reuse these tokens before introducing new visual values.

The app should feel consistent because the same design vocabulary is being reused, not because every screen was redesigned at once.


 */
