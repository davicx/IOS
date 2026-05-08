//
//  UserProfileSocialsView.swift
//  Kite
//
//  Created by David Vasquez on 3/12/25.
//

import UIKit


class UserProfileSocialsView: UIView {
    
    let viewFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        ButtonsOld.styleFriendsButton(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(viewFriendsButton)
        
        NSLayoutConstraint.activate([
            viewFriendsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewFriendsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewFriendsButton.heightAnchor.constraint(equalToConstant: 36),
            viewFriendsButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
