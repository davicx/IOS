//
//  NewItemViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/15/26.
//


import UIKit

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS

//IN API
/*
 fix this to have something
 var createdPost = {
     postID: 0,
     postType: postType,
     groupID: Number(groupID),
     groupName: "needGroupName",
     groupImage: "needGroupImage",
 */



class NewItemViewController: UIViewController {
    
    //LOGIC
    var groupID: Int = 0
    var selectedImage: UIImage?
    private let spinnerHelper = SpinnerHelper()


    //UI COMPONENTS
    private let titleLabel = componentFunctions.createTitleLabel()
    private let closeButton = componentFunctions.createCloseButton()
    private let itemDescriptionInput = componentFunctions.createItemDescriptionInput()
    private let itemNameInput = componentFunctions.createItemLinkInput()
    private let itemPriceInput = componentFunctions.createItemLinkInput()
    private let itemLinkInput = componentFunctions.createItemLinkInput()
    private let addPhotoButton = componentFunctions.createAddPhotoButton()
    private let photoPreviewImageView = UIImageView()
    private let submitItemButton = componentFunctions.createSubmitItemButton()
    
    
    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewPostLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "NewPostViewController")
    }

    //LAYOUT
    func setupNewPostLayout() {
        
        // Configure photo preview image view
        photoPreviewImageView.contentMode = .scaleAspectFill
        photoPreviewImageView.clipsToBounds = true
        photoPreviewImageView.layer.cornerRadius = 8
        photoPreviewImageView.backgroundColor = .lightGray
        photoPreviewImageView.isHidden = true
        photoPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set temporary default text
        itemDescriptionInput.text = "I want to get Secret of Mana"
        itemNameInput.text = "Secret of Mana"
        itemPriceInput.text = "$50"
        itemLinkInput.text = "www.secretofmana.com"
        
  
        // Add all UI elements to view
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(itemDescriptionInput)
        view.addSubview(itemNameInput)
        view.addSubview(itemPriceInput)
        view.addSubview(itemLinkInput)
        view.addSubview(addPhotoButton)
        view.addSubview(photoPreviewImageView)
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
            
            // Item name input - 80% width, 40 height
            itemNameInput.topAnchor.constraint(equalTo: itemDescriptionInput.bottomAnchor, constant: 20),
            itemNameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemNameInput.heightAnchor.constraint(equalToConstant: 40),
            
            // Item price input - 80% width, 40 height
            itemPriceInput.topAnchor.constraint(equalTo: itemNameInput.bottomAnchor, constant: 20),
            itemPriceInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemPriceInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemPriceInput.heightAnchor.constraint(equalToConstant: 40),
            
            // Item link input - 80% width, 40 height
            itemLinkInput.topAnchor.constraint(equalTo: itemPriceInput.bottomAnchor, constant: 20),
            itemLinkInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemLinkInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemLinkInput.heightAnchor.constraint(equalToConstant: 40),
            
            // Add photo button - 80% width, 32 height
            addPhotoButton.topAnchor.constraint(equalTo: itemLinkInput.bottomAnchor, constant: 20),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 32),
            
            // Photo preview image view - 80% width, 120 height
            photoPreviewImageView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            photoPreviewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoPreviewImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            photoPreviewImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Submit item button - 80% width, 32 height
            submitItemButton.topAnchor.constraint(equalTo: photoPreviewImageView.bottomAnchor, constant: 20),
            submitItemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitItemButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            submitItemButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    
    //ACTIONS
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addPhotoTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func submitItemTapped() {
        let currentUser = userDefaultManager.getLoggedInUser()
        let listID = 0

        let postFrom = currentUser
        let postTo = "\(groupID)"

        let itemDescription = itemDescriptionInput.text ?? "No item description given"
        let itemName = itemNameInput.text ?? ""
        let itemPrice = itemPriceInput.text ?? ""
        let itemLink = itemLinkInput.text ?? ""
        let postCaption = itemDescription
        
        // Validate required fields
        guard let postImage = selectedImage else {
            print("Please select an image")
            return
        }
        
        guard !itemName.isEmpty else {
            print("Please enter an item name")
            return
        }
        
        guard !itemPrice.isEmpty else {
            print("Please enter an item price")
            return
        }
        
        print("Submitting item post...")
        print("itemDescriptionInput: \(itemDescriptionInput.text ?? "")")
        print("itemNameInput: \(itemNameInput.text ?? "")")
        print("itemPriceInput: \(itemPriceInput.text ?? "")")
        print("itemLinkInput: \(itemLinkInput.text ?? "")")
        
        // Show spinner overlay
        spinnerHelper.show(in: self.view, delay: 0.0)
        
        Task {
            let success = await PostLogic.shared.createItemPost(
                postImage: postImage,
                postFrom: postFrom,
                postTo: postTo,
                postCaption: postCaption,
                groupID: groupID,
                listID: listID,
                itemName: itemName,
                itemPrice: itemPrice,
                itemDescription: itemDescription,
                itemLink: itemLink
            )
            
            DispatchQueue.main.async {
                // Hide spinner
                self.spinnerHelper.hide()
                
                if success {
                    print("Item post created successfully!")
                    self.dismiss(animated: true)
                } else {
                    print("Failed to create item post")
                }
            }
        }
        
    }
    
}

extension NewItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            photoPreviewImageView.image = selectedImage
            photoPreviewImageView.isHidden = false
            self.selectedImage = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


