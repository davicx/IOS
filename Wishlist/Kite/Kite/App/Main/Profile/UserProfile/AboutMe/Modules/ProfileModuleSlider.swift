//
//  ProfileModuleSlider.swift
//  Kite
//
//  Created by David Vasquez on 9/6/26.
//

import UIKit


//Capsule tab control: gray track + white selected pill (About Me / Posts).
final class ProfileModuleSlider: UIView {

    var onSelectionChanged: ((Int) -> Void)?

    private let trackView = UIView()
    private let trackBackground = UIView()
    private let selectionView = UIView()
    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
    private var selectionLeadingConstraint: NSLayoutConstraint!
    private var selectionWidthConstraint: NSLayoutConstraint!

    private(set) var selectedIndex: Int = 0
    private let inset: CGFloat = 3

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        trackView.translatesAutoresizingMaskIntoConstraints = false
        trackView.backgroundColor = .clear
        addSubview(trackView)

        trackBackground.translatesAutoresizingMaskIntoConstraints = false
        trackBackground.backgroundColor = Colors.tikTokGray
        trackBackground.layer.cornerRadius = 10
        trackBackground.clipsToBounds = true
        trackView.addSubview(trackBackground)

        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.backgroundColor = Colors.screenBackground
        selectionView.layer.cornerRadius = 8
        selectionView.layer.shadowColor = UIColor.black.cgColor
        selectionView.layer.shadowOpacity = 0.08
        selectionView.layer.shadowOffset = CGSize(width: 0, height: 1)
        selectionView.layer.shadowRadius = 2
        trackView.addSubview(selectionView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        trackView.addSubview(stackView)

        for (index, title) in ["About Me", "Posts"].enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        selectionLeadingConstraint = selectionView.leadingAnchor.constraint(
            equalTo: trackView.leadingAnchor,
            constant: inset
        )
        selectionWidthConstraint = selectionView.widthAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),

            trackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            trackBackground.topAnchor.constraint(equalTo: trackView.topAnchor),
            trackBackground.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            trackBackground.trailingAnchor.constraint(equalTo: trackView.trailingAnchor),
            trackBackground.bottomAnchor.constraint(equalTo: trackView.bottomAnchor),

            selectionLeadingConstraint,
            selectionWidthConstraint,
            selectionView.topAnchor.constraint(equalTo: trackView.topAnchor, constant: inset),
            selectionView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor, constant: -inset),

            stackView.topAnchor.constraint(equalTo: trackView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trackView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor)
        ])

        updateButtonStyles()
    }

    @objc private func tabTapped(_ sender: UIButton) {
        guard sender.tag != selectedIndex else { return }
        selectedIndex = sender.tag
        updateButtonStyles()
        updateSelectionFrame(animated: true)
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

    private func updateSelectionFrame(animated: Bool) {
        let width = trackView.bounds.width
        guard width > 0 else { return }
        let segmentWidth = (width - inset * 2) / CGFloat(buttons.count)
        selectionWidthConstraint.constant = segmentWidth
        selectionLeadingConstraint.constant = inset + segmentWidth * CGFloat(selectedIndex)

        if animated {
            UIView.animate(withDuration: 0.22, delay: 0, options: [.curveEaseInOut]) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectionFrame(animated: false)
    }
}
