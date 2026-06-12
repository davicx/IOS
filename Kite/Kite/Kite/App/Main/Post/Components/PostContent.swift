//
//  PostContent.swift
//  Kite
//
//  Created by David Vasquez on 2/23/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

/*
 TODO — Instagram-style post header (reference: 44 / 14 / 12 / 56)

 HEADER SHELL
 - Raise headerView height to 56pt (fixed, not dynamic).
 - Add 12pt leading inset: left column starts inset from screen edge (restore horizontal padding).
 - Add 12pt trailing inset on right column (ellipsis area).
 - Do not add a separator under the header — body image is the visual break.

 USER PROFILE IMAGE (leftView / userProfileImageView)
 - Bump avatar to 44×44 inside leftView; keep ~4pt inset or resize leftView to fit.
 - Keep ImageStyle.userProfileImage(imageView:diameter:) — pass diameter 44 (or 36 if keeping inset math).
 - Asset stays dynamic later via configure(post:); placeholder user_12 is fine for now.

 MIDDLE TEXT BLOCK (middleView — replace green/yellow placeholders)
 - Swap userNameView + postTimeView for userNameLabel + locationLabel (UILabel).
 - Vertically center the label stack against the profile image, not the full header.
 - Stack: username on top, location below with constant 1–2pt only (not 4–8).

 USERNAME LABEL
 - Text: e.g. "miyan_1980" (from post model later).
 - Style: 14pt semibold, #000000 — add Fonts.postUsername + Colors token or Text.postUsernameStyle(label:).
 - lineBreakMode = .byTruncatingTail, numberOfLines = 1.

 LOCATION LABEL
 - Text: e.g. "Koiwa, Tokyo Japan" (post location / time string later).
 - Style: 12pt regular, #737373 — Fonts.postLocation + Colors.secondaryText or dedicated gray token.
 - numberOfLines = 1; lower hierarchy than username (smaller size + gray, not bold).

 RIGHT MENU (rightView — replace indigo placeholder)
 - UIButton with UIImage(systemName: "ellipsis"), ~17–18pt, tint black / primaryText.
 - Keep width modest (~44–60pt); center icon in rightView.
 - Wire tap later under ACTIONS (edit / more menu delegate).

 STYLE FOLDER (one-time tokens — reuse across post headers)
 - Fonts: postUsername (14 semibold), postLocation (12 regular).
 - Colors: postUsernameText (#000000), postLocationText (#737373) if not reusing secondaryText.
 - Optional Text enum helpers: postUsernameStyle(label:), postLocationStyle(label:).

 LOGIC (when placeholders become real UI)
 - configure(with post:) sets username, location, userProfileImageView.image.
 - Hide location label when string is empty.
 */

final class PostContent: UIView {

    //UI COMPONENTS
    //MAIN
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    //HEADER
    let leftView = UIView()
    let userProfileImageView = UIImageView()
    let middleView = UIView()
    let rightView = UIView()
    
    //Header: User text
    let userNameLabel = UILabel()
    let postedAtLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupHeaderView()
        setupBodyView()
        setupFooterView()
    }

    private func setupHeaderView() {
        headerView.backgroundColor = Colors.screenBackground

        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 52)
        ])

        //HEADER:
        //Header Left: profile image holder — 58pt wide (8 + 42 + 8), full header height
        leftView.backgroundColor = .clear
        userProfileImageView.image = UIImage(named: "user_12")
        ImageStyle.userProfileImage(imageView: userProfileImageView, diameter: 42)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(userProfileImageView)

        //Header Middle: Username and posted at
        middleView.backgroundColor = .clear

        userNameLabel.text = "davey"
        userNameLabel.font = Fonts.userName
        userNameLabel.textColor = Colors.primaryText
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail

        postedAtLabel.text = "Posted today at 1pm in Sunriver Oregon"
        postedAtLabel.font = Fonts.postedAt
        //postedAtLabel.textColor = Colors.secondaryText
        postedAtLabel.textColor = Colors.postedAtText
        postedAtLabel.numberOfLines = 1
        postedAtLabel.lineBreakMode = .byTruncatingTail

        //Header Right: Post edit placeholder
        rightView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)

        [leftView, middleView, rightView, userNameLabel, postedAtLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        headerView.addSubview(leftView)
        headerView.addSubview(middleView)
        headerView.addSubview(rightView)
        middleView.addSubview(userNameLabel)
        middleView.addSubview(postedAtLabel)

        NSLayoutConstraint.activate([
            // Left — profile image holder (58×52: 8 + 42pt image + 8)
            leftView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: headerView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            leftView.widthAnchor.constraint(equalToConstant: 58),

            // Profile image — 42pt circle (52 − 5 − 5), inset inside holder
            userProfileImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 8),
            userProfileImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
            userProfileImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            userProfileImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -5),

            // Right — post edit
            rightView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: headerView.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            rightView.widthAnchor.constraint(equalToConstant: 60),

            // Middle — fills space between left and right, full header height
            middleView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            middleView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            middleView.topAnchor.constraint(equalTo: headerView.topAnchor),
            middleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            // Username + posted at — vertically centered as a tight stack (Instagram-style)
            postedAtLabel.topAnchor.constraint(equalTo: middleView.centerYAnchor, constant: 1),
            postedAtLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            postedAtLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),

            userNameLabel.bottomAnchor.constraint(equalTo: postedAtLabel.topAnchor, constant: -2),
            userNameLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: middleView.trailingAnchor)
        ])
    }

    private func setupBodyView() {
        bodyView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)

        addSubview(bodyView)
        bodyView.translatesAutoresizingMaskIntoConstraints = false

        addPlaceholderLabel("Body", to: bodyView)

        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupFooterView() {
        footerView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.3)

        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false

        addPlaceholderLabel("Footer", to: footerView)

        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /*
    func setupViews() {
        backgroundColor = .clear

        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        bodyView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
        footerView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.3)

        addPlaceholderLabel("Header", to: headerView)
        addPlaceholderLabel("Body", to: bodyView)
        addPlaceholderLabel("Footer", to: footerView)
    }

    func setupConstraints() {
        [headerView, bodyView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 100),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
     */
    
    
    //TEMP
    private func addPlaceholderLabel(_ text: String, to view: UIView) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
