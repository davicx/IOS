//
//  UserProfileEditView.swift
//  Kite
//
//  Created by David Vasquez on 3/12/25.
//

import UIKit


class UserProfileEditView: UIView {
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            editButton.widthAnchor.constraint(equalToConstant: 120),
            editButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


/*
class UserProfileEditView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
 */

