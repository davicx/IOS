//
//  EditItemViewController.swift
//  Kite
//
//  Created by David Vasquez on 11/23/25.
//

import UIKit

//FIlE: EditItemViewController
//STORYBOARD ID: EditItemVCStoryboardID

//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS


class EditItemViewController: UIViewController {

    //LOGIC
    var currentPost: Post?

    private let screenInset: CGFloat = 20
    private let fieldBackground = UIColor(hex: "#F3F4F6")
    private let imageAspect: CGFloat = 1.0 / 1.85
    private var imageTask: Task<Void, Never>?
    private let imageFunctions = ImageFunctions()

    //UI COMPONENTS
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let previewView = UIView()
    private let previewImageView = UIImageView()
    private let placeholderIcon = UIImageView()
    private let cameraButton = UIButton(type: .system)

    private let photoActionsRow = UIView()
    private let changePhotoButton = UIButton(type: .system)
    private let removePhotoButton = UIButton(type: .system)
    private let photoDivider = UIView()

    private let captionLabel = UILabel()
    private let captionView = UITextView()
    private let captionPlaceholder = UILabel()

    private let titleLabel = UILabel()
    private let titleField = UITextField()

    private let priceLabel = UILabel()
    private let priceField = UITextField()

    private let linkNameLabel = UILabel()
    private let linkNameField = UITextField()
    private let linkURLLabel = UILabel()
    private let linkURLField = UITextField()
    private var replacementImage: UIImage?

    private let descriptionLabel = UILabel()
    private let descriptionOptionalLabel = UILabel()
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()

    private let helperLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)

    deinit {
        imageTask?.cancel()
        NotificationCenter.default.removeObserver(self)
    }

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        //EditItemViewController
        printPageInfo(vcName: "EditItemViewController")

        view.backgroundColor = Colors.screenBackground
        setupNavigationBar()
        setupScrollView()
        setupPreview()
        setupPhotoActions()
        setupCaption()
        setupTitle()
        setupPrice()
        setupLink()
        setupDescription()
        setupHelper()
        setupKeyboard()
        applyPost()
    }

    //LAYOUT
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.screenBackground
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: Colors.primaryText
        ]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.title = "Edit Item"

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.tintColor = Colors.primaryPink
        closeButton.layer.cornerRadius = 22
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOpacity = 0.08
        closeButton.layer.shadowRadius = 8
        closeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        let closeImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold))
        closeButton.setImage(closeImage, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(Colors.primaryPink, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        saveButton.titleLabel?.adjustsFontForContentSizeCategory = true
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.backgroundColor = Colors.screenBackground
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Colors.screenBackground
        scrollView.addSubview(contentView)

        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissTap.cancelsTouchesInView = false
        dismissTap.delegate = self
        scrollView.addGestureRecognizer(dismissTap)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupPreview() {
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.backgroundColor = fieldBackground
        previewView.layer.cornerRadius = Layout.cornerLarge
        previewView.clipsToBounds = true
        contentView.addSubview(previewView)

        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.clipsToBounds = true
        previewView.addSubview(previewImageView)

        placeholderIcon.translatesAutoresizingMaskIntoConstraints = false
        placeholderIcon.image = UIImage(systemName: "photo")
        placeholderIcon.tintColor = Colors.subtleGrayText
        placeholderIcon.contentMode = .scaleAspectFit
        previewView.addSubview(placeholderIcon)

        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        cameraButton.tintColor = .white
        cameraButton.layer.cornerRadius = 22
        let cameraImage = UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold))
        cameraButton.setImage(cameraImage, for: .normal)
        cameraButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        previewView.addSubview(cameraButton)

        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenInset),
            previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            previewView.heightAnchor.constraint(equalTo: previewView.widthAnchor, multiplier: imageAspect),

            previewImageView.topAnchor.constraint(equalTo: previewView.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor),

            placeholderIcon.centerXAnchor.constraint(equalTo: previewView.centerXAnchor),
            placeholderIcon.centerYAnchor.constraint(equalTo: previewView.centerYAnchor),
            placeholderIcon.widthAnchor.constraint(equalToConstant: 36),
            placeholderIcon.heightAnchor.constraint(equalToConstant: 36),

            cameraButton.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -12),
            cameraButton.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -12),
            cameraButton.widthAnchor.constraint(equalToConstant: 44),
            cameraButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupPhotoActions() {
        photoActionsRow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoActionsRow)

        stylePhotoButton(changePhotoButton, title: "Change Photo", color: Colors.primaryPink)
        stylePhotoButton(removePhotoButton, title: "Remove Photo", color: Colors.subtleGrayText)
        changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        removePhotoButton.addTarget(self, action: #selector(removePhotoTapped), for: .touchUpInside)
        photoActionsRow.addSubview(changePhotoButton)
        photoActionsRow.addSubview(removePhotoButton)

        photoDivider.translatesAutoresizingMaskIntoConstraints = false
        photoDivider.backgroundColor = Colors.dividerColor
        photoActionsRow.addSubview(photoDivider)

        NSLayoutConstraint.activate([
            photoActionsRow.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: Layout.spacingS),
            photoActionsRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            photoActionsRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            photoActionsRow.heightAnchor.constraint(equalToConstant: 44),

            changePhotoButton.leadingAnchor.constraint(equalTo: photoActionsRow.leadingAnchor),
            changePhotoButton.trailingAnchor.constraint(equalTo: photoDivider.leadingAnchor),
            changePhotoButton.topAnchor.constraint(equalTo: photoActionsRow.topAnchor),
            changePhotoButton.bottomAnchor.constraint(equalTo: photoActionsRow.bottomAnchor),

            photoDivider.centerXAnchor.constraint(equalTo: photoActionsRow.centerXAnchor),
            photoDivider.centerYAnchor.constraint(equalTo: photoActionsRow.centerYAnchor),
            photoDivider.widthAnchor.constraint(equalToConstant: 1),
            photoDivider.heightAnchor.constraint(equalToConstant: 18),

            removePhotoButton.leadingAnchor.constraint(equalTo: photoDivider.trailingAnchor),
            removePhotoButton.trailingAnchor.constraint(equalTo: photoActionsRow.trailingAnchor),
            removePhotoButton.topAnchor.constraint(equalTo: photoActionsRow.topAnchor),
            removePhotoButton.bottomAnchor.constraint(equalTo: photoActionsRow.bottomAnchor)
        ])
    }

    private func setupCaption() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.text = "Caption"
        styleSectionLabel(captionLabel)
        contentView.addSubview(captionLabel)

        styleTextView(captionView)
        captionView.delegate = self
        contentView.addSubview(captionView)

        captionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        captionPlaceholder.text = "Write a caption"
        stylePlaceholder(captionPlaceholder)
        captionView.addSubview(captionPlaceholder)

        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: photoActionsRow.bottomAnchor, constant: Layout.spacingL),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            captionView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: Layout.spacingS),
            captionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            captionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            captionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 96),

            captionPlaceholder.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 14),
            captionPlaceholder.leadingAnchor.constraint(equalTo: captionView.leadingAnchor, constant: 16)
        ])
    }

    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        styleSectionLabel(titleLabel)
        contentView.addSubview(titleLabel)

        styleTextField(titleField)
        titleField.returnKeyType = .next
        titleField.delegate = self
        contentView.addSubview(titleField)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: captionView.bottomAnchor, constant: Layout.spacingXL),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingS),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            titleField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
    }

    private func setupPrice() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "Price"
        styleSectionLabel(priceLabel)
        contentView.addSubview(priceLabel)

        styleTextField(priceField)
        priceField.keyboardType = .decimalPad
        priceField.placeholder = "0.00"
        contentView.addSubview(priceField)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Layout.spacingXL),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            priceField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Layout.spacingS),
            priceField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            priceField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            priceField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
    }

    private func setupLink() {
        linkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        linkNameLabel.text = "Link name"
        styleSectionLabel(linkNameLabel)
        contentView.addSubview(linkNameLabel)

        styleTextField(linkNameField)
        linkNameField.placeholder = "Target"
        linkNameField.autocorrectionType = .no
        contentView.addSubview(linkNameField)

        linkURLLabel.translatesAutoresizingMaskIntoConstraints = false
        linkURLLabel.text = "Link URL"
        styleSectionLabel(linkURLLabel)
        contentView.addSubview(linkURLLabel)

        styleTextField(linkURLField)
        linkURLField.placeholder = "https://"
        linkURLField.keyboardType = .URL
        linkURLField.autocapitalizationType = .none
        linkURLField.autocorrectionType = .no
        contentView.addSubview(linkURLField)

        NSLayoutConstraint.activate([
            linkNameLabel.topAnchor.constraint(equalTo: priceField.bottomAnchor, constant: Layout.spacingXL),
            linkNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            linkNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            linkNameField.topAnchor.constraint(equalTo: linkNameLabel.bottomAnchor, constant: Layout.spacingS),
            linkNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            linkNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            linkNameField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),

            linkURLLabel.topAnchor.constraint(equalTo: linkNameField.bottomAnchor, constant: Layout.spacingXL),
            linkURLLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            linkURLLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            linkURLField.topAnchor.constraint(equalTo: linkURLLabel.bottomAnchor, constant: Layout.spacingS),
            linkURLField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            linkURLField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            linkURLField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
    }

    private func setupDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Description"
        styleSectionLabel(descriptionLabel)
        contentView.addSubview(descriptionLabel)

        descriptionOptionalLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionOptionalLabel.text = "(optional)"
        descriptionOptionalLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionOptionalLabel.adjustsFontForContentSizeCategory = true
        descriptionOptionalLabel.textColor = Colors.subtleGrayText
        contentView.addSubview(descriptionOptionalLabel)

        styleTextView(descriptionView)
        descriptionView.delegate = self
        contentView.addSubview(descriptionView)

        descriptionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        descriptionPlaceholder.text = "Add a description"
        stylePlaceholder(descriptionPlaceholder)
        descriptionView.addSubview(descriptionPlaceholder)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: linkURLField.bottomAnchor, constant: Layout.spacingXL),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),

            descriptionOptionalLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 6),
            descriptionOptionalLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            descriptionOptionalLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -screenInset),

            descriptionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Layout.spacingS),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 128),

            descriptionPlaceholder.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 14),
            descriptionPlaceholder.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16)
        ])
    }

    private func setupHelper() {
        helperLabel.translatesAutoresizingMaskIntoConstraints = false
        helperLabel.text = "Changes will be visible to everyone on this list."
        helperLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        helperLabel.adjustsFontForContentSizeCategory = true
        helperLabel.textColor = Colors.subtleGrayText
        helperLabel.numberOfLines = 0
        contentView.addSubview(helperLabel)

        NSLayoutConstraint.activate([
            helperLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Layout.spacingM),
            helperLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            helperLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            helperLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func styleSectionLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Colors.primaryText
    }

    private func styleTextField(_ field: UITextField) {
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.adjustsFontForContentSizeCategory = true
        field.textColor = Colors.primaryText
        field.backgroundColor = fieldBackground
        field.layer.cornerRadius = Layout.cornerMedium
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        field.rightViewMode = .always
    }

    private func styleTextView(_ textView: UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.adjustsFontForContentSizeCategory = true
        textView.textColor = Colors.primaryText
        textView.backgroundColor = fieldBackground
        textView.layer.cornerRadius = Layout.cornerMedium
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
    }

    private func stylePlaceholder(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Colors.subtleGrayText
    }

    private func stylePhotoButton(_ button: UIButton, title: String, color: UIColor) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
    }

    //ACTIONS
    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func saveTapped() {
        view.endEditing(true)
        guard let post = currentPost, let postFrom = post.postFrom, !postFrom.isEmpty else { return }
        saveButton.isEnabled = false

        let caption = captionView.text ?? ""
        let itemName = titleField.text ?? ""
        let itemPrice = priceField.text ?? ""
        let itemDescription = descriptionView.text ?? ""
        let itemLink = linkURLField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let itemLinkName = linkNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let image = replacementImage

        Task {
            do {
                let saved = try await PostsAPI().editItem(
                    postID: post.postID,
                    postFrom: postFrom,
                    postCaption: caption,
                    itemName: itemName,
                    itemPrice: itemPrice,
                    itemDescription: itemDescription,
                    itemLink: itemLink,
                    itemLinkName: itemLinkName,
                    postImage: image
                )
                await MainActor.run {
                    self.saveButton.isEnabled = true
                    guard saved else { return }
                    post.postCaption = caption
                    post.itemName = itemName
                    post.itemPrice = itemPrice
                    post.itemDescription = itemDescription
                    post.itemLink = itemLink
                    post.itemLinkName = itemLinkName
                    PostDataController.shared.applyEditedItem(
                        postID: post.postID,
                        postCaption: caption,
                        itemName: itemName,
                        itemPrice: itemPrice,
                        itemDescription: itemDescription,
                        itemLink: itemLink,
                        itemLinkName: itemLinkName,
                        image: image
                    )
                    self.dismiss(animated: true)
                }
            } catch {
                await MainActor.run {
                    self.saveButton.isEnabled = true
                }
            }
        }
    }

    @objc private func changePhotoTapped() {
        view.endEditing(true)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }

    @objc private func removePhotoTapped() {
        imageTask?.cancel()
        showPreview(image: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardInView = view.convert(frame, from: nil)
        let overlap = max(0, view.bounds.maxY - keyboardInView.minY - view.safeAreaInsets.bottom)
        scrollView.contentInset.bottom = overlap
        scrollView.verticalScrollIndicatorInsets.bottom = overlap
    }

    //FUNCTIONS
    private func applyPost() {
        let post = currentPost
        captionView.text = post?.postCaption ?? ""
        titleField.text = post?.itemName
        priceField.text = post?.itemPrice
        linkNameField.text = post?.itemLinkName
        let storedLink = post?.itemLink?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        linkURLField.text = storedLink.caseInsensitiveCompare("item_link") == .orderedSame ? "" : storedLink
        descriptionView.text = post?.itemDescription ?? ""
        captionPlaceholder.isHidden = !(captionView.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        descriptionPlaceholder.isHidden = !descriptionView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        if let image = post?.postImageData {
            showPreview(image: image)
            return
        }

        showPreview(image: nil)
        guard let url = post?.fileUrl?.trimmingCharacters(in: .whitespacesAndNewlines), !url.isEmpty else { return }
        imageTask = Task { [weak self] in
            let image = await self?.imageFunctions.fetchImage(from: url)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard let self, self.previewImageView.image == nil else { return }
                self.showPreview(image: image)
            }
        }
    }

    private func showPreview(image: UIImage?) {
        previewImageView.image = image
        placeholderIcon.isHidden = image != nil
    }
}


extension EditItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
            priceField.becomeFirstResponder()
        }
        return false
    }
}


extension EditItemViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let empty = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        if textView == captionView {
            captionPlaceholder.isHidden = !empty
        } else if textView == descriptionView {
            descriptionPlaceholder.isHidden = !empty
        }
    }
}


extension EditItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true) { [weak self] in
            guard let image else { return }
            self?.imageTask?.cancel()
            self?.replacementImage = image
            self?.showPreview(image: image)
        }
    }
}


extension EditItemViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var view = touch.view
        while let current = view {
            if current is UIControl { return false }
            view = current.superview
        }
        return true
    }
}
