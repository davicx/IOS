//
//  CreateStyleViews.swift
//  Kite
//
//  Created by David Vasquez on 7/10/25.
//

import UIKit


struct componentFunctions {

    //VIEWS
    static func createUIView(backgroundColor: UIColor = .clear) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
    
    
    //IMAGE
    static func createPostImageView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view

    }
    
    //COMMENT  
    static func createCommentLabel() -> UILabel {
        let label = UILabel()
        label.text = "Comment goes here..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createCommentDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    

    //BUTTONS
    
    
    //MAIN VIEWS
    static func createHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }

    static func createBodyView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    static func createFooterView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }
    
    //POST
    static func createPostUserView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }

    static func createPostUserName() -> UILabel {
        let label = UILabel()
        label.text = "Garden Party"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }

    static func createPostImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }

    static func createPostSocialsView() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }

    static func createPostSocialsText() -> UILabel {
        let label = UILabel()
        label.text = "SOCIALS: Post User"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }

    static func createPostCaptionView() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }


    static func createPostDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }
    
    static func createPostCaptionText() -> UILabel {
        let label = UILabel()
        label.text = "CAPTION: My Caption"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }
    
    static func createPostStyleCaptionText() -> UILabel {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0) // Instagram-like gray
        label.backgroundColor = .clear
        
        return label
    }
    
    //POST CREATION UI ELEMENTS
    static func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "new post"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createCloseButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //POST CREATION FORM ELEMENTS
    static func createItemDescriptionInput() -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }
    
    static func createItemLinkInput() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Enter link..."
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .URL
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    static func createAddPhotoButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Add Photo", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createSubmitItemButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Submit Item", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
