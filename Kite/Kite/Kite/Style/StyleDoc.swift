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

