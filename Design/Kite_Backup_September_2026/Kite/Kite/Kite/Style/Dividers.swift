//
//  Dividers.swift
//  Kite
//
//  Created by David Vasquez on 7/11/26.
//

import UIKit


//Full-width hairline matching the default UITableView separator (color + 1px height), with no leading inset.
//Includes 4pt clear space below the line for breathing room between posts.
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

// Post feed cell chrome: top/bottom hairlines, white content bg, gray gap below.
// Content pins to contentTopAnchor … contentBottomAnchor; call linkContentBottom(to:) last.
final class ItemDivider: UIView {

    //UI COMPONENTS
    private let topBorderView = UIView()
    private let postBackgroundView = UIView()
    private let bottomBorderView = UIView()
    private let bottomSpacingView = UIView()

    private let hairline = 1 / UIScreen.main.scale
    private var contentBottomConstraint: NSLayoutConstraint?

    var contentTopAnchor: NSLayoutYAxisAnchor { topBorderView.bottomAnchor }
    var contentBottomAnchor: NSLayoutYAxisAnchor { bottomBorderView.topAnchor }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = Colors.separator
        addSubview(topBorderView)

        postBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        postBackgroundView.backgroundColor = Colors.screenBackground
        addSubview(postBackgroundView)

        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = Colors.separator
        addSubview(bottomBorderView)

        bottomSpacingView.translatesAutoresizingMaskIntoConstraints = false
        bottomSpacingView.backgroundColor = .clear
        addSubview(bottomSpacingView)

        NSLayoutConstraint.activate([
            topBorderView.topAnchor.constraint(equalTo: topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: hairline),

            bottomSpacingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSpacingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSpacingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSpacingView.heightAnchor.constraint(equalToConstant: Layout.spacingS),

            bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: hairline),
            bottomBorderView.bottomAnchor.constraint(equalTo: bottomSpacingView.topAnchor),

            postBackgroundView.topAnchor.constraint(equalTo: topBorderView.bottomAnchor),
            postBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postBackgroundView.bottomAnchor.constraint(equalTo: bottomBorderView.topAnchor)
        ])

        sendSubviewToBack(postBackgroundView)
    }

    func install(in contentView: UIView) {
        contentView.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: contentView.topAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        contentView.sendSubviewToBack(self)
    }

    func linkContentBottom(to anchor: NSLayoutYAxisAnchor) {
        contentBottomConstraint?.isActive = false
        contentBottomConstraint = bottomBorderView.topAnchor.constraint(equalTo: anchor)
        contentBottomConstraint?.isActive = true
    }
}

// Temporary full-width black 2pt divider (e.g. between groups on Groups page).
final class ThickBlackDivider: UIView {

    private let lineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        lineView.backgroundColor = .black
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            bottomAnchor.constraint(equalTo: lineView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
