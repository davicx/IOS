//
//  DiscoverTabBar.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

enum DiscoverCategory: Int {
    case items = 0
    case people = 1
    case lists = 2
}

final class DiscoverTabBar: UIView {

    //LOGIC
    var onSelect: ((DiscoverCategory) -> Void)?
    private var selectedCategory: DiscoverCategory? = .items
    private var buttons: [UIButton] = []

    //UI COMPONENTS
    // DiscoverTabBar
    // ├── itemsButton
    // ├── peopleButton
    // └── listsButton

    private let itemsButton = UIButton(type: .system)
    private let peopleButton = UIButton(type: .system)
    private let listsButton = UIButton(type: .system)

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
        layer.cornerRadius = 12

        let titles = ["Items", "People", "Lists"]
        buttons = [itemsButton, peopleButton, listsButton]

        for index in 0..<buttons.count {
            let button = buttons[index]
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            button.setTitle(titles[index], for: .normal)
            button.titleLabel?.font = Fonts.semibold15
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            addSubview(button)
        }

        layoutViews()
        applySelection()
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),

            itemsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            itemsButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            itemsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),

            peopleButton.leadingAnchor.constraint(equalTo: itemsButton.trailingAnchor),
            peopleButton.topAnchor.constraint(equalTo: itemsButton.topAnchor),
            peopleButton.bottomAnchor.constraint(equalTo: itemsButton.bottomAnchor),
            peopleButton.widthAnchor.constraint(equalTo: itemsButton.widthAnchor),

            listsButton.leadingAnchor.constraint(equalTo: peopleButton.trailingAnchor),
            listsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            listsButton.topAnchor.constraint(equalTo: itemsButton.topAnchor),
            listsButton.bottomAnchor.constraint(equalTo: itemsButton.bottomAnchor),
            listsButton.widthAnchor.constraint(equalTo: itemsButton.widthAnchor)
        ])
    }

    //ACTIONS
    @objc private func tabTapped(_ sender: UIButton) {
        guard let category = DiscoverCategory(rawValue: sender.tag) else { return }
        setSelectedCategory(category)
        onSelect?(category)
    }

    //FUNCTIONS
    func setSelectedCategory(_ category: DiscoverCategory?) {
        selectedCategory = category
        applySelection()
    }

    private func applySelection() {
        for button in buttons {
            let isSelected = selectedCategory?.rawValue == button.tag
            button.backgroundColor = isSelected
                ? Colors.primaryPink.withAlphaComponent(0.12)
                : .clear
            button.setTitleColor(
                isSelected ? Colors.primaryGrayText : Colors.subtleGrayText,
                for: .normal
            )
            button.accessibilityTraits = isSelected ? [.button, .selected] : [.button]
        }
    }
}
