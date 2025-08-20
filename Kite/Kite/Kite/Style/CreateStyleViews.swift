//
//  CreateStyleViews.swift
//  Kite
//
//  Created by David Vasquez on 7/10/25.
//

import UIKit


struct CreateViewStyles {
    
    
    
    static func createUIView(backgroundColor: UIColor = .clear) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
    
    static func createPostImageView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        
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
    
    
    
    // MARK: - Header, Body, Footer Views
    
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
    
    // MARK: - Post User
    
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

    // MARK: - Post Image

    static func createPostImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }

    // MARK: - Post Socials
    
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

    // MARK: - Post Caption
    
    static func createPostCaptionView() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }



    // MARK: - Divider
    
    static func createPostDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }
}
