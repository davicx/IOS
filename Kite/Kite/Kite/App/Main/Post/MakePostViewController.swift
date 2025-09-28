//
//  MakePostViewController.swift
//  Kite
//
//  Created by David Vasquez on 9/26/25.
//

import UIKit



class MakePostViewController: UIViewController {
    
    private let titleLabel = componentFunctions.createTitleLabel()
    private let closeButton = componentFunctions.createCloseButton()
    private let itemDescriptionInput = componentFunctions.createItemDescriptionInput()
    private let itemLinkInput = componentFunctions.createItemLinkInput()
    private let addPhotoButton = componentFunctions.createAddPhotoButton()
    private let submitItemButton = componentFunctions.createSubmitItemButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add all UI elements to view
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(itemDescriptionInput)
        view.addSubview(itemLinkInput)
        view.addSubview(addPhotoButton)
        view.addSubview(submitItemButton)
        
        // Add button targets
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        submitItemButton.addTarget(self, action: #selector(submitItemTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Close button in top-left
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Title label below close button
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Item description input - 80% width, 120 height
            itemDescriptionInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            itemDescriptionInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemDescriptionInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemDescriptionInput.heightAnchor.constraint(equalToConstant: 120),
            
            // Item link input - 80% width, 40 height
            itemLinkInput.topAnchor.constraint(equalTo: itemDescriptionInput.bottomAnchor, constant: 20),
            itemLinkInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemLinkInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemLinkInput.heightAnchor.constraint(equalToConstant: 40),
            
            // Add photo button - 80% width, 32 height
            addPhotoButton.topAnchor.constraint(equalTo: itemLinkInput.bottomAnchor, constant: 20),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 32),
            
            // Submit item button - 80% width, 32 height
            submitItemButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            submitItemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitItemButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            submitItemButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addPhotoTapped() {
        print("addPhotoButton")
    }
    
    @objc private func submitItemTapped() {
        print("itemDescriptionInput: \(itemDescriptionInput.text ?? "")")
        print("itemLinkInput: \(itemLinkInput.text ?? "")")
    }
}
NewPostViewController
