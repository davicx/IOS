//
//  ClothingFooterAddNew.swift
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


final class ClothingFooterAddNew: UIView {

    //UI COMPONENTS
    // ClothingFooterAddNew
    // └── addButton

    private let addButton = UIButton(type: .system)
    private let dashedBorder = CAShapeLayer()

    var onAddTapped: (() -> Void)?

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

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("+ Add clothing note", for: .normal)
        addButton.backgroundColor = Colors.primaryBlue.withAlphaComponent(0.08)
        addButton.setTitleColor(Colors.primaryBlue, for: .normal)
        addButton.titleLabel?.font = Fonts.semibold17
        addButton.layer.cornerRadius = 16
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingL),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingL),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 76)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        dashedBorder.removeFromSuperlayer()
        dashedBorder.strokeColor = Colors.primaryBlue.withAlphaComponent(0.35).cgColor
        dashedBorder.fillColor = UIColor.clear.cgColor
        dashedBorder.lineWidth = 1
        dashedBorder.lineDashPattern = [6, 4]
        dashedBorder.path = UIBezierPath(roundedRect: addButton.bounds, cornerRadius: 16).cgPath
        addButton.layer.addSublayer(dashedBorder)
    }

    //ACTIONS
    @objc private func addTapped() {
        onAddTapped?()
    }

    //FUNCTIONS
    func setAddControlsHidden(_ hidden: Bool) {
        isHidden = hidden
        addButton.isUserInteractionEnabled = !hidden
    }
}
