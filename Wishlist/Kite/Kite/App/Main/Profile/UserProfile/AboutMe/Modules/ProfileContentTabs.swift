//
//  ProfileContentTabs.swift
//  Kite
//

import UIKit


// About Me / Content tabs. The blue underline follows the selected tab.
final class ProfileContentTabs: UIView {

    var onSelectionChanged: ((Int) -> Void)?

    private let stackView = UIStackView()
    private let underline = UIView()
    private let divider = UIView()
    private var buttons: [UIButton] = []
    private var underlineLeadingConstraint: NSLayoutConstraint!
    private var underlineWidthConstraint: NSLayoutConstraint!

    private(set) var selectedIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSelectedIndex(_ index: Int, animated: Bool) {
        guard buttons.indices.contains(index), index != selectedIndex else { return }
        selectedIndex = index
        updateButtonStyles()
        updateUnderline(animated: animated)
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.screenBackground

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        addSubview(stackView)

        for (index, title) in ["About Me", "Content"].enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = Colors.primaryBlue
        addSubview(underline)

        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .systemGray4
        addSubview(divider)

        underlineLeadingConstraint = underline.leadingAnchor.constraint(equalTo: leadingAnchor)
        underlineWidthConstraint = underline.widthAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            underlineLeadingConstraint,
            underlineWidthConstraint,
            underline.heightAnchor.constraint(equalToConstant: 3),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor),

            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        updateButtonStyles()
        bringSubviewToFront(underline)
    }

    @objc private func tabTapped(_ sender: UIButton) {
        guard sender.tag != selectedIndex else { return }
        selectedIndex = sender.tag
        updateButtonStyles()
        updateUnderline(animated: true)
        onSelectionChanged?(selectedIndex)
    }

    private func updateButtonStyles() {
        for (index, button) in buttons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(
                isSelected ? Colors.primaryGrayText : Colors.subtleGrayText,
                for: .normal
            )
            button.titleLabel?.font = isSelected ? Fonts.semibold15 : Fonts.regular15
        }
    }

    private func updateUnderline(animated: Bool) {
        let width = bounds.width
        guard width > 0, !buttons.isEmpty else { return }
        let segmentWidth = width / CGFloat(buttons.count)
        underlineWidthConstraint.constant = segmentWidth
        underlineLeadingConstraint.constant = segmentWidth * CGFloat(selectedIndex)

        let changes = { self.layoutIfNeeded() }
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: changes)
        } else {
            changes()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
        guard width > 0, !buttons.isEmpty else { return }
        let segmentWidth = width / CGFloat(buttons.count)
        let leading = segmentWidth * CGFloat(selectedIndex)
        if underlineWidthConstraint.constant != segmentWidth || underlineLeadingConstraint.constant != leading {
            updateUnderline(animated: false)
        }
    }
}
