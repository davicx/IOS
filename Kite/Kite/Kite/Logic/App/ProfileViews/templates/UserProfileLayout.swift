//
//  UserProfileLayout.swift
//  Kite
//
//  Created by David Vasquez on 3/11/25.
//

import UIKit


class UserProfileLayoutExample {
    
    private let topView = SimpleTopView()
    private let bottomStackView = SimpleBottomStackView()
    
    func setup(in view: UIView) {
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 220),
            
            bottomStackView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
