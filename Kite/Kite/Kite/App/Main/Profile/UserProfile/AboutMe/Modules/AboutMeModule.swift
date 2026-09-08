//
//  AboutMeModule.swift
//  Kite
//
//  Created by David Vasquez on 9/6/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class AboutMeModule: UIView {

    //UI COMPONENTS
    // AboutMeModule
    // ├── aboutMe
    // └── clothingModule

    private let aboutMe = AboutMe()
    private let clothingModule = ClothingModule()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.feedBackground

        addSubview(aboutMe)
        addSubview(clothingModule)

        NSLayoutConstraint.activate([
            aboutMe.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingS),
            aboutMe.leadingAnchor.constraint(equalTo: leadingAnchor),
            aboutMe.trailingAnchor.constraint(equalTo: trailingAnchor),

            clothingModule.topAnchor.constraint(equalTo: aboutMe.bottomAnchor, constant: Layout.spacingL),
            clothingModule.leadingAnchor.constraint(equalTo: leadingAnchor),
            clothingModule.trailingAnchor.constraint(equalTo: trailingAnchor),
            clothingModule.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingS)
        ])
    }

    //FUNCTIONS
    func configure(biography: String) {
        aboutMe.configure(biography: biography)
    }
}
