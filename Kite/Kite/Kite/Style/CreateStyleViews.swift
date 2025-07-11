//
//  CreateStyleViews.swift
//  Kite
//
//  Created by David Vasquez on 7/10/25.
//

import UIKit



struct CreateViewStyles {
    
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
    
    static func createPostImageView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }

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

    static func createPostCaptionText() -> UILabel {
        let label = UILabel()
        label.text = "CAPTION: My Caption"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }

    // MARK: - Divider
    
    static func createPostDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }
}
