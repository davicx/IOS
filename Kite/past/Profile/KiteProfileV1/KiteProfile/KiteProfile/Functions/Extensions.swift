//
//  Extensions.swift
//  KiteProfile
//
//  Created by David Vasquez on 12/13/24.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        //layer.borderWidth = 1
        layer.masksToBounds = false
        //layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
