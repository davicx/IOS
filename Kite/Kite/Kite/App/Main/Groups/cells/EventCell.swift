//
//  EventCell.swift
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

final class EventCell: UITableViewCell {

    //UI COMPONENTS
    private let eventHeader = EventHeader()
    private let eventImage = EventImage()
    private let eventMembers = EventMembers()
    private let eventSocials = EventSocials()
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
        setupEventHeader()
        setupEventImage()
        setupEventMembers()
        setupEventSocials()
        setupThickBlackDivider()
    }

    private func setupEventHeader() {
        eventHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventHeader)

        NSLayoutConstraint.activate([
            eventHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupEventImage() {
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventImage)

        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: eventHeader.bottomAnchor),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupEventMembers() {
        eventMembers.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventMembers)

        NSLayoutConstraint.activate([
            eventMembers.topAnchor.constraint(equalTo: eventImage.bottomAnchor),
            eventMembers.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventMembers.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupEventSocials() {
        eventSocials.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventSocials)

        NSLayoutConstraint.activate([
            eventSocials.topAnchor.constraint(equalTo: eventMembers.bottomAnchor),
            eventSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupThickBlackDivider() {
        thickBlackDivider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thickBlackDivider)

        NSLayoutConstraint.activate([
            thickBlackDivider.topAnchor.constraint(equalTo: eventSocials.bottomAnchor),
            thickBlackDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thickBlackDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thickBlackDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
