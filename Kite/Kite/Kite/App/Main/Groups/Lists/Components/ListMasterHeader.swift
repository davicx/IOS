//
//  ListMasterHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//
// HEIGHT: Designed for ~60pt (matches the working Wishlist tableHeaderView).
// When used as tableView.tableHeaderView, set the header frame height
// (or re-measure after layout) — tableHeaderView does not auto-resize
// from Auto Layout alone.

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class ListMasterHeader: UIView {

    //LOGIC
    var onSelectionChanged: ((Int) -> Void)?
    private var underlineLeadingConstraint: NSLayoutConstraint!

    //UI COMPONENTS
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        return sc
    }()
    private let underlineView = UIView()

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

        setupSegmentedControl()
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        underlineView.backgroundColor = .black
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underlineView)

        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            underlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            underlineLeadingConstraint,
            underlineView.widthAnchor.constraint(
                equalTo: segmentedControl.widthAnchor,
                multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)
            ),
            underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider()
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    //ACTIONS
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        underlineLeadingConstraint.constant = segmentWidth * CGFloat(sender.selectedSegmentIndex)

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }

        onSelectionChanged?(sender.selectedSegmentIndex)
    }
}
