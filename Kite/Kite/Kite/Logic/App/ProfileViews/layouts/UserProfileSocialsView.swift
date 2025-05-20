//
//  UserProfileSocialsView.swift
//  Kite
//
//  Created by David Vasquez on 3/12/25.
//

import UIKit




 class UserProfileSocialsView: UIView {
     
     let followingButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Following", for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         button.setTitleColor(.white, for: .normal)
         button.backgroundColor = .systemBlue
         button.layer.cornerRadius = 8
         button.translatesAutoresizingMaskIntoConstraints = false
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
         addSubview(followingButton)
         
         NSLayoutConstraint.activate([
             followingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             followingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
             followingButton.heightAnchor.constraint(equalToConstant: 36),
             followingButton.widthAnchor.constraint(equalToConstant: 120)
         ])
     }
 }

/*
 class UserProfileSocialsView: UIView {
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         backgroundColor = .green
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
 }

 */
