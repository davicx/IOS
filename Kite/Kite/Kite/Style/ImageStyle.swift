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
}
