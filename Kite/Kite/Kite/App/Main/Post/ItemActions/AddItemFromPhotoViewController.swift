//
//  AddItemFromPhotoViewController.swift
//  Kite
//
//  Created by David Vasquez on 8/21/26.
//

import UIKit


final class AddItemFromPhotoViewController: UIViewController {

    var groupID: Int = 0

    private let placeholderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Photo"
        navigationItem.largeTitleDisplayMode = .never

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = "Add a photo\n(coming next)"
        placeholderLabel.font = Fonts.newItemIntroSubtitleFont
        placeholderLabel.textColor = Colors.secondaryText
        placeholderLabel.textAlignment = .center
        placeholderLabel.numberOfLines = 0
        view.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.spacingXXL),
            placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.spacingXXL)
        ])
    }
}
