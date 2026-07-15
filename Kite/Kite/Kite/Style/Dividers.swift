//
//  Dividers.swift
//  Kite
//
//  Created by David Vasquez on 7/11/26.
//

import UIKit


/// Full-width hairline matching the default UITableView separator (color + 1px height), with no leading inset.
/// Includes 4pt clear space below the line for breathing room between posts.
final class MainDivider: UIView {

    private let lineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        lineView.backgroundColor = .separator
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
            bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 4)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
