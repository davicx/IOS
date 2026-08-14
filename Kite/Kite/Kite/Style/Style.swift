//
//  Style.swift
//  Kite
//
//  Created by David Vasquez on 4/14/26.
//




import UIKit



//LABELS
enum LabelStyle {

    //Post
    /*
    static func postEventTitle(_ label: UILabel) {
        label.font = Fonts.postEventTitleFont
        label.textColor = Colors.primaryText
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
        label.textColor = Colors.primaryText
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






