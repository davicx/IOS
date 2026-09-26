//
//  DiscoverSearchBar.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class DiscoverSearchBar: UIView, UITextFieldDelegate {

    //LOGIC
    var onTextChange: ((String) -> Void)?

    //UI COMPONENTS
    // DiscoverSearchBar
    // ├── searchIcon
    // ├── textField
    // └── clearButton

    private let searchIcon = UIImageView()
    private let textField = UITextField()
    private let clearButton = UIButton(type: .system)

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
        backgroundColor = Colors.screenBackground
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = Colors.newItemCardBorder.cgColor

        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = Colors.subtleGrayText
        searchIcon.contentMode = .scaleAspectFit
        addSubview(searchIcon)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search items, people, or lists"
        textField.font = Fonts.regular15
        textField.textColor = Colors.primaryGrayText
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        addSubview(textField)

        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = Colors.subtleGrayText
        clearButton.isHidden = true
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        addSubview(clearButton)

        layoutViews()
    }

    //LAYOUT and UI
    private func layoutViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),

            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 18),
            searchIcon.heightAnchor.constraint(equalToConstant: 18),

            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: Layout.spacingS),
            textField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -Layout.spacingS),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),

            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            clearButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Layout.touchTargetSize),
            clearButton.heightAnchor.constraint(equalToConstant: Layout.touchTargetSize)
        ])
    }

    //ACTIONS
    @objc private func textChanged() {
        let text = textField.text ?? ""
        clearButton.isHidden = text.isEmpty
        onTextChange?(text)
    }

    @objc private func clearTapped() {
        textField.text = ""
        clearButton.isHidden = true
        onTextChange?("")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //FUNCTIONS
    func clearText() {
        textField.text = ""
        clearButton.isHidden = true
    }
}
