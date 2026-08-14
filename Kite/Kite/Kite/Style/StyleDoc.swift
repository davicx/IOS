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

