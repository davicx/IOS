//
//  Buttons.swift
//  Kite
//
//  Created by David Vasquez on 1/3/25.
//

import UIKit


class ButtonsOld {



    //BUTTON
    //Purchase Button
    static func styleSelectedGreenButton(_ button: UIButton, width: CGFloat, height: CGFloat) {
        //Border: 008300
        //Font: 008300
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#008300").cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor(hex: "#008300"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    static func styleNotSelectedButton(_ button: UIButton, width: CGFloat, height: CGFloat) {
        //Try to match image
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex: "#C7C7C7").cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor(hex: "#343434"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
}

