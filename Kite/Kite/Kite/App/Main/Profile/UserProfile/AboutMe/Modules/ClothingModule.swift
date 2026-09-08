//
//  ClothingModule.swift
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


final class ClothingModule: UIView {

    //UI COMPONENTS
    // ClothingModule
    // ├── header
    // ├── bodyList
    // └── footerAddNew

    private let header = ClothingHeader()
    private let bodyList = ClothingBodyList()
    private let footerAddNew = ClothingFooterAddNew()

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

        addSubview(header)
        addSubview(bodyList)
        addSubview(footerAddNew)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),

            bodyList.topAnchor.constraint(equalTo: header.bottomAnchor, constant: Layout.spacingS),
            bodyList.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyList.trailingAnchor.constraint(equalTo: trailingAnchor),

            footerAddNew.topAnchor.constraint(equalTo: bodyList.bottomAnchor, constant: Layout.spacingM),
            footerAddNew.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerAddNew.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerAddNew.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
