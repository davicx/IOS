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


// About Me tab content — scrolls inside the fixed profile content area.
final class AboutMeModule: UIView {

    //UI COMPONENTS
    // AboutMeModule
    // ├── scrollView
    // │   └── contentView
    // │       ├── aboutMe
    // │       ├── clothingModule
    // │       └── logoutButton

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let aboutMe = AboutMe()
    private let clothingModule = ClothingModule()
    private let logoutButton = UIButton(type: .system)

    var onLogoutTapped: (() -> Void)?
    var onEditPreferencesTapped: (() -> Void)? {
        get { clothingModule.onEditTapped }
        set { clothingModule.onEditTapped = newValue }
    }
    var onAddPreferenceTapped: (() -> Void)? {
        get { clothingModule.onAddTapped }
        set { clothingModule.onAddTapped = newValue }
    }

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

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Colors.feedBackground
        scrollView.addSubview(contentView)

        contentView.addSubview(aboutMe)
        contentView.addSubview(clothingModule)

        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        contentView.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            aboutMe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingS),
            aboutMe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutMe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            clothingModule.topAnchor.constraint(equalTo: aboutMe.bottomAnchor, constant: Layout.spacingL),
            clothingModule.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            clothingModule.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            logoutButton.topAnchor.constraint(equalTo: clothingModule.bottomAnchor, constant: Layout.spacingL),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingL),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingL),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingL)
        ])
    }

    //ACTIONS
    @objc private func logoutTapped() {
        onLogoutTapped?()
    }

    //FUNCTIONS
    func configure(biography: String) {
        aboutMe.configure(biography: biography)
    }

    func configurePreferences(preferences: [ProfilePreference], isOwner: Bool) {
        clothingModule.configure(preferences: preferences, isOwner: isOwner)
    }
}
