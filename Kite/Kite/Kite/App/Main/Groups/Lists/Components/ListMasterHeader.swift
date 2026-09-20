//
//  ListMasterHeader.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//
// HEIGHT: Designed for ~116pt with subtitle + segment.
// When used as tableView.tableHeaderView, set the header frame height
// (or re-measure after layout) — tableHeaderView does not auto-size
// from Auto Layout alone.

import UIKit


//On List Page this is the top area
final class ListsHeaderView: UIView {

    // LOGIC
    var onListTypeChanged: ((Int) -> Void)?
    private var selectedListType: Int = 0
    private var underlineWidthConstraint: NSLayoutConstraint!
    private var underlineCenterXConstraint: NSLayoutConstraint!

    // LAYOUT
    private let listTypeHeight: CGFloat = 50
    private let preferredHeight: CGFloat = 116

    // UI COMPONENTS
    private let subtitleLabel = UILabel()
    private let listTypeContainer = UIView()
    private let myListsButton = UIButton(type: .system)
    private let sharedListsButton = UIButton(type: .system)
    private let listTypeStack = UIStackView()
    private let selectionIndicator = UIView()

    // MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: preferredHeight)
    }

    // LAYOUT
    private func setupViews() {
        backgroundColor = Colors.screenBackground

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Keep wishes organized and share them with friends."
        subtitleLabel.font = Fonts.regular15
        subtitleLabel.textColor = Colors.secondaryGrayText
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 1
        subtitleLabel.lineBreakMode = .byTruncatingTail
        addSubview(subtitleLabel)

        listTypeContainer.translatesAutoresizingMaskIntoConstraints = false
        listTypeContainer.backgroundColor = Colors.newItemInfoBackground
        listTypeContainer.layer.cornerRadius = 13
        listTypeContainer.clipsToBounds = true
        addSubview(listTypeContainer)

        setupListTypeButton(myListsButton, title: "My Lists", tag: 0)
        setupListTypeButton(sharedListsButton, title: "Shared With Me", tag: 1)

        listTypeStack.translatesAutoresizingMaskIntoConstraints = false
        listTypeStack.axis = .horizontal
        listTypeStack.distribution = .fillEqually
        listTypeStack.alignment = .fill
        listTypeStack.spacing = 0
        listTypeStack.addArrangedSubview(myListsButton)
        listTypeStack.addArrangedSubview(sharedListsButton)
        listTypeContainer.addSubview(listTypeStack)

        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.backgroundColor = Colors.primaryPink
        selectionIndicator.layer.cornerRadius = 1
        listTypeContainer.addSubview(selectionIndicator)

        underlineWidthConstraint = selectionIndicator.widthAnchor.constraint(equalToConstant: 40)
        underlineCenterXConstraint = selectionIndicator.centerXAnchor.constraint(equalTo: myListsButton.centerXAnchor)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: preferredHeight),

            subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),

            listTypeContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Layout.spacingL),
            listTypeContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            listTypeContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            listTypeContainer.heightAnchor.constraint(equalToConstant: listTypeHeight),
            listTypeContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),

            listTypeStack.topAnchor.constraint(equalTo: listTypeContainer.topAnchor),
            listTypeStack.leadingAnchor.constraint(equalTo: listTypeContainer.leadingAnchor),
            listTypeStack.trailingAnchor.constraint(equalTo: listTypeContainer.trailingAnchor),
            listTypeStack.bottomAnchor.constraint(equalTo: listTypeContainer.bottomAnchor),

            myListsButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Layout.touchTargetSize),
            sharedListsButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Layout.touchTargetSize),

            selectionIndicator.bottomAnchor.constraint(equalTo: listTypeContainer.bottomAnchor, constant: -3),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 2),
            underlineWidthConstraint,
            underlineCenterXConstraint
        ])

        updateSelectedListType(animated: false)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectionIndicatorWidth()
    }

    private func setupListTypeButton(_ button: UIButton, title: String, tag: Int) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(listTypeButtonTapped(_:)), for: .touchUpInside)
        button.accessibilityLabel = title
    }

    // ACTIONS
    @objc private func listTypeButtonTapped(_ sender: UIButton) {
        guard sender.tag != selectedListType else { return }
        selectedListType = sender.tag
        updateSelectedListType(animated: true)
        onListTypeChanged?(selectedListType)
    }

    // FUNCTIONS
    func selectListType(_ index: Int, animated: Bool = false) {
        selectedListType = max(0, min(1, index))
        updateSelectedListType(animated: animated)
    }

    private func updateSelectedListType(animated: Bool) {
        let myListsSelected = selectedListType == 0

        myListsButton.titleLabel?.font = myListsSelected ? Fonts.semibold14 : Fonts.regular14
        sharedListsButton.titleLabel?.font = myListsSelected ? Fonts.regular14 : Fonts.semibold14
        myListsButton.setTitleColor(
            myListsSelected ? Colors.primaryGrayText : Colors.secondaryGrayText,
            for: .normal
        )
        sharedListsButton.setTitleColor(
            myListsSelected ? Colors.secondaryGrayText : Colors.primaryGrayText,
            for: .normal
        )
        myListsButton.backgroundColor = myListsSelected ? Colors.screenBackground : .clear
        sharedListsButton.backgroundColor = myListsSelected ? .clear : Colors.screenBackground

        myListsButton.accessibilityTraits = myListsSelected ? [.button, .selected] : .button
        sharedListsButton.accessibilityTraits = myListsSelected ? .button : [.button, .selected]

        underlineCenterXConstraint.isActive = false
        underlineCenterXConstraint = selectionIndicator.centerXAnchor.constraint(
            equalTo: (myListsSelected ? myListsButton : sharedListsButton).centerXAnchor
        )
        underlineCenterXConstraint.isActive = true
        updateSelectionIndicatorWidth()

        let updates = {
            self.layoutIfNeeded()
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: updates)
        } else {
            updates()
        }
    }

    private func updateSelectionIndicatorWidth() {
        let buttonWidth = listTypeContainer.bounds.width / 2
        guard buttonWidth > 0 else { return }
        underlineWidthConstraint.constant = max(24, buttonWidth - 16)
    }
}
