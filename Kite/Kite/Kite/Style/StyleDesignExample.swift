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




