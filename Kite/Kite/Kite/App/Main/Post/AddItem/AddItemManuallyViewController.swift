//
//  AddItemManuallyViewController.swift
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

class AddItemManuallyViewController: UIViewController {

    //LOGIC
    var groupID: Int {
        get { draft.groupID }
        set { draft.groupID = newValue }
    }
    /// Filled here → Review creates (Step 7). Manual only builds the draft.
    var draft = ItemDraft.empty(groupID: 0)
    var listName: String = "List"
    var selectedImage: UIImage?

    //UI COMPONENTS
    private let titleLabel = componentFunctions.createTitleLabel()
    private let closeButton = componentFunctions.createCloseButton()
    private let itemDescriptionInput = componentFunctions.createItemDescriptionInput()
    private let itemNameInput = componentFunctions.createItemLinkInput()
    private let itemPriceInput = componentFunctions.createItemLinkInput()
    private let itemLinkInput = componentFunctions.createItemLinkInput()
    private let addPhotoButton = componentFunctions.createAddPhotoButton()
    private let photoPreviewImageView = UIImageView()
    private let continueButton = componentFunctions.createSubmitItemButton()

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Enter Manually"
        navigationItem.largeTitleDisplayMode = .never
        setupNewPostLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "AddItemManuallyViewController")
    }

    //LAYOUT
    func setupNewPostLayout() {
        photoPreviewImageView.contentMode = .scaleAspectFill
        photoPreviewImageView.clipsToBounds = true
        photoPreviewImageView.layer.cornerRadius = 8
        photoPreviewImageView.backgroundColor = .lightGray
        photoPreviewImageView.isHidden = true
        photoPreviewImageView.translatesAutoresizingMaskIntoConstraints = false

        itemDescriptionInput.text = "I want to get Secret of Mana"
        itemNameInput.text = "Secret of Mana"
        itemPriceInput.text = "$50"
        itemLinkInput.text = "www.secretofmana.com"

        continueButton.setTitle("Continue to Review", for: .normal)

        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(itemDescriptionInput)
        view.addSubview(itemNameInput)
        view.addSubview(itemPriceInput)
        view.addSubview(itemLinkInput)
        view.addSubview(addPhotoButton)
        view.addSubview(photoPreviewImageView)
        view.addSubview(continueButton)

        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueToReviewTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            itemDescriptionInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            itemDescriptionInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemDescriptionInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemDescriptionInput.heightAnchor.constraint(equalToConstant: 120),

            itemNameInput.topAnchor.constraint(equalTo: itemDescriptionInput.bottomAnchor, constant: 20),
            itemNameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemNameInput.heightAnchor.constraint(equalToConstant: 40),

            itemPriceInput.topAnchor.constraint(equalTo: itemNameInput.bottomAnchor, constant: 20),
            itemPriceInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemPriceInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemPriceInput.heightAnchor.constraint(equalToConstant: 40),

            itemLinkInput.topAnchor.constraint(equalTo: itemPriceInput.bottomAnchor, constant: 20),
            itemLinkInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemLinkInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemLinkInput.heightAnchor.constraint(equalToConstant: 40),

            addPhotoButton.topAnchor.constraint(equalTo: itemLinkInput.bottomAnchor, constant: 20),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 32),

            photoPreviewImageView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            photoPreviewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoPreviewImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            photoPreviewImageView.heightAnchor.constraint(equalToConstant: 120),

            continueButton.topAnchor.constraint(equalTo: photoPreviewImageView.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            continueButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    //ACTIONS
    @objc private func closeTapped() {
        if let navigationController, navigationController.viewControllers.first != self {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func addPhotoTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    /// Builds draft from current fields (empty fields OK). Only Review creates.
    func makeDraft() -> ItemDraft {
        draft.name = itemNameInput.text ?? ""
        draft.price = itemPriceInput.text
        draft.postText = itemDescriptionInput.text
        draft.productURL = itemLinkInput.text
        draft.localImage = selectedImage
        return draft
    }

    @objc private func continueToReviewTapped() {
        let review = ReviewItemViewController()
        review.draft = makeDraft()
        review.listName = listName
        navigationController?.pushViewController(review, animated: true)
    }

    /*
    // OLD: Manual called createItemPost directly. Removed in Step 4 — only Review creates (Step 7).
    @objc private func submitItemTapped() { ... }
    */
}

extension AddItemManuallyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
