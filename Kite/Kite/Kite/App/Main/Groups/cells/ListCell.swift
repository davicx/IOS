//
//  ListCell.swift
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

final class ListCell: UITableViewCell {

    //UI COMPONENTS
    private let listHeader = ListHeader()
    private let listImage = ListImage()
    private let listMembers = ListMembers()
    private let listSocials = ListSocials()
    private let thickBlackDivider = ThickBlackDivider()

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupListHeader()
        setupListImage()
        setupListMembers()
        setupListSocials()
        setupThickBlackDivider()
    }

    private func setupListHeader() {
        listHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listHeader)

        NSLayoutConstraint.activate([
            listHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            listHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupListImage() {
        listImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listImage)

        NSLayoutConstraint.activate([
            listImage.topAnchor.constraint(equalTo: listHeader.bottomAnchor),
            listImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupListMembers() {
        listMembers.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listMembers)

        NSLayoutConstraint.activate([
            listMembers.topAnchor.constraint(equalTo: listImage.bottomAnchor),
            listMembers.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listMembers.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupListSocials() {
        listSocials.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listSocials)

        NSLayoutConstraint.activate([
            listSocials.topAnchor.constraint(equalTo: listMembers.bottomAnchor),
            listSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupThickBlackDivider() {
        thickBlackDivider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thickBlackDivider)

        NSLayoutConstraint.activate([
            thickBlackDivider.topAnchor.constraint(equalTo: listSocials.bottomAnchor),
            thickBlackDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thickBlackDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thickBlackDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
