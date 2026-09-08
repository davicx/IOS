//
//  AboutMe.swift
//  Kite
//
//  Created by David Vasquez on 9/6/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


final class AboutMe: UIView {

    //LOGIC
    private var biographyText: String = ""
    /// Caps bio text area (~5–6 lines at 15pt). Longer bios scroll inside the card.
    private let maxBioTextHeight: CGFloat = 120

    //UI COMPONENTS
    // AboutMe
    // ├── headerRow
    // │   ├── titleLabel
    // │   └── editButton
    // └── bioCard
    //     └── bioTextView

    private let headerRow = UIView()
    private let titleLabel = UILabel()
    private let editButton = UIButton(type: .system)

    private let bioCard = UIView()
    private let bioTextView = UITextView()
    private var bioTextViewHeightConstraint: NSLayoutConstraint!

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
        backgroundColor = .clear

        setupHeaderRow()
        setupBioCard()
        layoutViews()
    }

    private func setupHeaderRow() {
        headerRow.translatesAutoresizingMaskIntoConstraints = false
        headerRow.backgroundColor = .clear
        addSubview(headerRow)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "About Me"
        titleLabel.font = Fonts.semibold16
        titleLabel.textColor = Colors.primaryGrayText
        headerRow.addSubview(titleLabel)

        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = Fonts.regular15
        editButton.setTitleColor(Colors.primaryBlue, for: .normal)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        headerRow.addSubview(editButton)
    }

    private func setupBioCard() {
        bioCard.translatesAutoresizingMaskIntoConstraints = false
        bioCard.backgroundColor = Colors.screenBackground
        bioCard.layer.cornerRadius = 16
        bioCard.layer.borderWidth = 1
        bioCard.layer.borderColor = Colors.separator.cgColor
        bioCard.clipsToBounds = true
        addSubview(bioCard)

        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.font = Fonts.regular15
        bioTextView.textColor = Colors.primaryGrayText
        bioTextView.backgroundColor = .clear
        bioTextView.isEditable = false
        bioTextView.isSelectable = true
        bioTextView.isScrollEnabled = false
        bioTextView.showsVerticalScrollIndicator = true
        bioTextView.textContainerInset = .zero
        bioTextView.textContainer.lineFragmentPadding = 0
        bioCard.addSubview(bioTextView)

        bioTextViewHeightConstraint = bioTextView.heightAnchor.constraint(equalToConstant: 0)
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            headerRow.topAnchor.constraint(equalTo: topAnchor),
            headerRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            headerRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),

            titleLabel.leadingAnchor.constraint(equalTo: headerRow.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerRow.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerRow.bottomAnchor),

            editButton.trailingAnchor.constraint(equalTo: headerRow.trailingAnchor),
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            editButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: Layout.spacingS),

            bioCard.topAnchor.constraint(equalTo: headerRow.bottomAnchor, constant: Layout.spacingS),
            bioCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            bioCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            bioCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            bioTextView.topAnchor.constraint(equalTo: bioCard.topAnchor, constant: Layout.spacingL),
            bioTextView.leadingAnchor.constraint(equalTo: bioCard.leadingAnchor, constant: Layout.spacingL),
            bioTextView.trailingAnchor.constraint(equalTo: bioCard.trailingAnchor, constant: -Layout.spacingL),
            bioTextView.bottomAnchor.constraint(equalTo: bioCard.bottomAnchor, constant: -Layout.spacingL),
            bioTextViewHeightConstraint
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBioTextHeight()
    }

    //ACTIONS
    @objc private func editTapped() {
        print("(edit)")
    }

    //FUNCTIONS
    func configure(biography: String) {
        biographyText = biography
        let trimmed = biography.trimmingCharacters(in: .whitespacesAndNewlines)
        bioTextView.text = trimmed.isEmpty ? "biography" : trimmed
        setNeedsLayout()
        layoutIfNeeded()
        updateBioTextHeight()
    }

    private func updateBioTextHeight() {
        let horizontalPadding = Layout.spacingL * 2
        let width = bioCard.bounds.width > 0
            ? bioCard.bounds.width - horizontalPadding
            : bounds.width - (Layout.spacingL * 4)

        guard width > 0 else { return }

        let fitting = bioTextView.sizeThatFits(
            CGSize(width: width, height: .greatestFiniteMagnitude)
        )
        let capped = min(fitting.height, maxBioTextHeight)
        bioTextViewHeightConstraint.constant = ceil(capped)
        bioTextView.isScrollEnabled = fitting.height > maxBioTextHeight + 0.5
    }
}
