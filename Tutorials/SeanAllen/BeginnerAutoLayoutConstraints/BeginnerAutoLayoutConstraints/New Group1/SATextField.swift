//
//  SATextField.swift
//  BeginnerAutoLayoutConstraints
//
//  Created by David Vasquez on 9/15/24.
//

import UIKit

class SATextField: UITextField {
    override init (frame: CGRect) {
        super.init (frame: frame)
        setUpField()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init( coder: Decoder )
        setUpField ()
    }
    
    private func setUpField() {
        tintColor = .white
        textColor = .darkGray
        font = UIFont(name: "avenirNextCondensedDemiBold", size: 18.0)
        backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        UITextAutocorrectionType .no
        layer.cornerRadius = 25.0
        clipsToBounds = true
    }
    
    //let placeholder = self.placeholder != nil ? self.placeholder! : ""
    
}
