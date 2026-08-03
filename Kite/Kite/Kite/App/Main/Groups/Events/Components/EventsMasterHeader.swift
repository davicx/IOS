//
//  EventsMasterHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//
// HEIGHT: Designed for ~60pt. When used as tableView.tableHeaderView,
// set the header frame height (or re-measure after layout) — tableHeaderView
// does not auto-resize from Auto Layout alone.

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class EventsMasterHeader: UIView {

    //UI COMPONENTS
    private let titleLabel = UILabel()
    private let countLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemBackground

        titleLabel.text = "Your Events! How Fun!"
        titleLabel.font = Fonts.semibold16
        titleLabel.textColor = Colors.primaryText
        titleLabel.textAlignment = .center

        countLabel.font = Fonts.regular14
        countLabel.textColor = Colors.grayTextColor
        countLabel.textAlignment = .center
        configure(eventCount: 0)

        [titleLabel, countLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2),

            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 2)
        ])
    }

    //FUNCTIONS
    func configure(eventCount: Int) {
        let noun = eventCount == 1 ? "Event" : "Events"
        countLabel.text = "\(eventCount) \(noun)"
    }
}
