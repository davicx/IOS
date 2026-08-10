//
//  PostHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//

import UIKit

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class PostHeader: UIView {

    //UI COMPONENTS
    let headerGroupImageView = UIView()
    let headerGroupImage = UIImageView()

    let headerGroupNameView = UIView()
    let headerGroupNameLabel = UILabel()

    let headerGroupInfoView = UIView()
    let headerGroupInfoLabel = UILabel()

    let headerGroupMenuView = UIView()
    let headerGroupMenuIcon = UIImageView()
    private let headerTextStackView = UIStackView()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        setupHeaderViews()
    }

    private func setupHeaderViews() {
        headerGroupImageView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupImage.translatesAutoresizingMaskIntoConstraints = false
        headerGroupNameView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerGroupInfoView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        headerGroupMenuView.translatesAutoresizingMaskIntoConstraints = false
        headerGroupMenuIcon.translatesAutoresizingMaskIntoConstraints = false
        headerTextStackView.translatesAutoresizingMaskIntoConstraints = false

        headerGroupImageView.backgroundColor = .clear
        headerGroupNameView.backgroundColor = .clear
        headerGroupInfoView.backgroundColor = .clear
        headerGroupMenuView.backgroundColor = .clear

        headerTextStackView.axis = .vertical
        headerTextStackView.spacing = 2
        headerTextStackView.alignment = .fill
        headerTextStackView.distribution = .fill

        headerGroupImage.contentMode = .scaleAspectFill
        headerGroupImage.clipsToBounds = true
        headerGroupImage.layer.cornerRadius = 4

        headerGroupNameLabel.font = Fonts.postHeaderEventTitleFont
        headerGroupNameLabel.textColor = Colors.postHeaderEventTitleTextColor
        headerGroupNameLabel.numberOfLines = 1
        headerGroupNameLabel.lineBreakMode = .byTruncatingTail

        headerGroupInfoLabel.font = Fonts.postHeaderEventTimeFont
        headerGroupInfoLabel.textColor = Colors.postHeaderEventTimeTextColor
        headerGroupInfoLabel.numberOfLines = 1
        headerGroupInfoLabel.lineBreakMode = .byTruncatingTail

        headerGroupMenuIcon.image = UIImage(named: "menu-horizontal")
        headerGroupMenuIcon.contentMode = .scaleAspectFit

        addSubview(headerGroupImageView)
        headerGroupImageView.addSubview(headerGroupImage)
        addSubview(headerTextStackView)
        headerTextStackView.addArrangedSubview(headerGroupNameView)
        headerGroupNameView.addSubview(headerGroupNameLabel)
        headerTextStackView.addArrangedSubview(headerGroupInfoView)
        headerGroupInfoView.addSubview(headerGroupInfoLabel)
        addSubview(headerGroupMenuView)
        headerGroupMenuView.addSubview(headerGroupMenuIcon)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),

            headerGroupImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerGroupImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerGroupImageView.widthAnchor.constraint(equalToConstant: 40),
            headerGroupImageView.heightAnchor.constraint(equalToConstant: 40),

            headerGroupImage.topAnchor.constraint(equalTo: headerGroupImageView.topAnchor),
            headerGroupImage.leadingAnchor.constraint(equalTo: headerGroupImageView.leadingAnchor),
            headerGroupImage.trailingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor),
            headerGroupImage.bottomAnchor.constraint(equalTo: headerGroupImageView.bottomAnchor),

            headerTextStackView.leadingAnchor.constraint(equalTo: headerGroupImageView.trailingAnchor, constant: 10),
            headerTextStackView.trailingAnchor.constraint(equalTo: headerGroupMenuView.leadingAnchor, constant: -10),
            headerTextStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            headerGroupNameLabel.topAnchor.constraint(equalTo: headerGroupNameView.topAnchor),
            headerGroupNameLabel.leadingAnchor.constraint(equalTo: headerGroupNameView.leadingAnchor),
            headerGroupNameLabel.trailingAnchor.constraint(equalTo: headerGroupNameView.trailingAnchor),
            headerGroupNameLabel.bottomAnchor.constraint(equalTo: headerGroupNameView.bottomAnchor),

            headerGroupInfoLabel.topAnchor.constraint(equalTo: headerGroupInfoView.topAnchor),
            headerGroupInfoLabel.leadingAnchor.constraint(equalTo: headerGroupInfoView.leadingAnchor),
            headerGroupInfoLabel.trailingAnchor.constraint(equalTo: headerGroupInfoView.trailingAnchor),
            headerGroupInfoLabel.bottomAnchor.constraint(equalTo: headerGroupInfoView.bottomAnchor),

            headerGroupMenuView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            headerGroupMenuView.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerGroupMenuView.widthAnchor.constraint(equalToConstant: 50),
            headerGroupMenuView.heightAnchor.constraint(equalToConstant: 50),

            headerGroupMenuIcon.centerXAnchor.constraint(equalTo: headerGroupMenuView.centerXAnchor),
            headerGroupMenuIcon.centerYAnchor.constraint(equalTo: headerGroupMenuView.centerYAnchor),
            headerGroupMenuIcon.widthAnchor.constraint(equalToConstant: 24),
            headerGroupMenuIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let groupImage = post.groupImageData ?? UIImage(named: "background_1") ?? UIImage()
        headerGroupImage.image = groupImage

        headerGroupNameLabel.text = post.groupName ?? "Unknown Group"
        headerGroupInfoLabel.text = post.timeMessage ?? "Just now"
    }
}
