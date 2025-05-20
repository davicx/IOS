//
//  UserProfileLayout.swift
//  Kite
//
//  Created by David Vasquez on 3/11/25.
//


import UIKit


class UserProfileLayout: UIView {
    
    let profileImageView = UserProfileImageView()
    let userNameView = UserNameView()
    let userProfileSocialsView = UserProfileSocialsView()
    let userProfileEditView = UserProfileEditView()
    let userProfileBiography = UserProfileBiographyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        let views = [profileImageView, userNameView, userProfileSocialsView, userProfileEditView, userProfileBiography]
        //let views = [profileImageView, userNameView, userProfileSocialsView]
        
        views.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            userNameView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            userNameView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userNameView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userNameView.heightAnchor.constraint(equalToConstant: 30),
            
            userProfileSocialsView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
            userProfileSocialsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userProfileSocialsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userProfileSocialsView.heightAnchor.constraint(equalToConstant: 48),
            
            userProfileEditView.topAnchor.constraint(equalTo: userProfileSocialsView.bottomAnchor),
            userProfileEditView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userProfileEditView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userProfileEditView.heightAnchor.constraint(equalToConstant: 60),
            
            userProfileBiography.topAnchor.constraint(equalTo: userProfileEditView.bottomAnchor),
            userProfileBiography.leadingAnchor.constraint(equalTo: leadingAnchor),
            userProfileBiography.trailingAnchor.constraint(equalTo: trailingAnchor),
            userProfileBiography.heightAnchor.constraint(equalToConstant: 30),
             
        ])
    }
}
