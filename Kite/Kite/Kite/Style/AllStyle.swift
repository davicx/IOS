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

 class Colors {

     //APP MAIN
     //Kite Main Colors
     static let primaryBlue = UIColor(hex: "#3797EF")
     static let primaryPink = UIColor(hex: "#FF2E7A")

     //Text — darkest to lightest
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
 STYLE — from Style.swift (LabelStyle / TextViewStyle / ViewStyle / TextFieldStyle)
 ============================================================

 //LABELS
 enum LabelStyle {

     //Post
     /*
     static func postEventTitle(_ label: UILabel) {
         label.font = Fonts.postEventTitleFont
         label.textColor = Colors.primaryGrayText
         label.numberOfLines = 1
         label.lineBreakMode = .byTruncatingTail
     }

     static func postEventDetails(_ label: UILabel) {
         label.font = Fonts.postEventDetailsFont
         label.textColor = Colors.postedAtTextColor
         label.numberOfLines = 1
         label.lineBreakMode = .byTruncatingTail
     }
     */

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
 LAYOUT GUIDE NOTES — from LayoutGuide.md (summary)
 ============================================================

 // Core rule: before adding a new visual value, check Colors, Fonts, Layout.
 // Reuse an existing token when it fits.
 //
 // Two layers:
 //   1. Tokens — Colors.primaryBlue, Fonts.semibold16, Layout.spacingS
 //   2. Semantic styles — Fonts.postCaptionFont, Buttons.loginButtonStyle
 //
 // Folder roles:
 //   Colors.swift, Fonts.swift, Layout.swift, Style.swift,
 //   Buttons.swift, ImageStyle.swift, Dividers.swift
 //
 // Spacing system (4pt): 4, 8, 12, 16, 24, 32
 // Prefer white / black / gray; brand blue/pink only for interaction or priority.

 */
