//
//  ItemPurchaseViewController.swift
//  Kite
//
//  Created by David Vasquez on 2/14/26.
//

import UIKit

class ItemPurchaseViewController: UIViewController {

    private let cancelButton = UIButton(type: .system)
    private let purchaseButton = UIButton(type: .system)
    private let buttonStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    private func setupButtons() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        Buttons.styleNotSelectedButton(cancelButton, width: 120, height: 44)

        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        Buttons.styleSelectedGreenButton(purchaseButton, width: 120, height: 44)

        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(purchaseButton)

        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func purchaseTapped() {
        // No-op for now
        dismiss(animated: true)
    }
}
