//
//  AddItemManuallyViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/15/26.
//

import UIKit


/// Manual entry → builds `ItemDraft` → Review creates (Step 7).
final class AddItemManuallyViewController: UIViewController {

    // LOGIC
    var groupID: Int {
        get { draft.groupID }
        set { draft.groupID = newValue }
    }
    /// Filled here → Review creates. Manual only builds the draft.
    var draft = ItemDraft.empty(groupID: 0)
    var listName: String = "List"
    var selectedImage: UIImage?

    // UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let introTitleLabel = UILabel()
    private let introSubtitleLabel = UILabel()

    private let titleCaptionLabel = UILabel()
    private let titleField = UITextField()

    private let priceCaptionLabel = UILabel()
    private let priceField = UITextField()

    private let linkCaptionLabel = UILabel()
    private let linkField = UITextField()

    private let postCaptionLabel = UILabel()
    private let postTextView = UITextView()

    private let addToListCaptionLabel = UILabel()
    private let addToListRow = UIControl()
    private let addToListNameLabel = UILabel()
    private let addToListChevron = UIImageView()

    private let addPhotoButton = UIButton(type: .system)
    private let photoPreviewImageView = UIImageView()

    private let continueButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 12
    private let fieldHeight: CGFloat = 48
    private let postFieldHeight: CGFloat = 110
    private let photoPreviewHeight: CGFloat = 120

    private var photoPreviewHeightConstraint: NSLayoutConstraint?
    private var photoPreviewTopConstraint: NSLayoutConstraint?

    // MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Enter Manually"
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
        setupKeyboardDismiss()
        applySampleDefaultsIfNeeded()
        updatePhotoUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "AddItemManuallyViewController")
    }

    // LAYOUT
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        setupIntro()
        setupField(caption: titleCaptionLabel, title: "Title", field: titleField, placeholder: "Item name")
        setupField(caption: priceCaptionLabel, title: "Price", field: priceField, placeholder: "$0.00")
        setupField(caption: linkCaptionLabel, title: "Link (optional)", field: linkField, placeholder: "https://")
        linkField.keyboardType = .URL
        linkField.autocapitalizationType = .none
        linkField.autocorrectionType = .no

        setupPostField()
        setupAddToListSection()
        setupPhotoSection()
        setupContinueButton()

        let side = Layout.spacingXXL
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            introTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            introTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            introTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            introSubtitleLabel.topAnchor.constraint(equalTo: introTitleLabel.bottomAnchor, constant: Layout.spacingS),
            introSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            introSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            titleCaptionLabel.topAnchor.constraint(equalTo: introSubtitleLabel.bottomAnchor, constant: Layout.spacingXL),
            titleCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            titleField.topAnchor.constraint(equalTo: titleCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            titleField.heightAnchor.constraint(equalToConstant: fieldHeight),

            priceCaptionLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Layout.spacingL),
            priceCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            priceCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            priceField.topAnchor.constraint(equalTo: priceCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            priceField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            priceField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            priceField.heightAnchor.constraint(equalToConstant: fieldHeight),

            linkCaptionLabel.topAnchor.constraint(equalTo: priceField.bottomAnchor, constant: Layout.spacingL),
            linkCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            linkField.topAnchor.constraint(equalTo: linkCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            linkField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            linkField.heightAnchor.constraint(equalToConstant: fieldHeight),

            postCaptionLabel.topAnchor.constraint(equalTo: linkField.bottomAnchor, constant: Layout.spacingL),
            postCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            postCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            postTextView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            postTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            postTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            postTextView.heightAnchor.constraint(equalToConstant: postFieldHeight),

            addToListCaptionLabel.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: Layout.spacingXL),
            addToListCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addToListCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            addToListRow.topAnchor.constraint(equalTo: addToListCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            addToListRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addToListRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            addToListRow.heightAnchor.constraint(equalToConstant: 56),

            addPhotoButton.topAnchor.constraint(equalTo: addToListRow.bottomAnchor, constant: Layout.spacingXL),
            addPhotoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addPhotoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 48),

            photoPreviewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            photoPreviewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            continueButton.topAnchor.constraint(equalTo: photoPreviewImageView.bottomAnchor, constant: Layout.spacingXL),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])

        let previewTop = photoPreviewImageView.topAnchor.constraint(
            equalTo: addPhotoButton.bottomAnchor,
            constant: Layout.spacingL
        )
        let previewHeight = photoPreviewImageView.heightAnchor.constraint(equalToConstant: 0)
        photoPreviewTopConstraint = previewTop
        photoPreviewHeightConstraint = previewHeight
        NSLayoutConstraint.activate([previewTop, previewHeight])
    }

    private func setupIntro() {
        introTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introTitleLabel.text = "Add item details"
        introTitleLabel.font = Fonts.semibold17
        introTitleLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(introTitleLabel)

        introSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introSubtitleLabel.text = "Fill in what you know."
        introSubtitleLabel.font = Fonts.regular14
        introSubtitleLabel.textColor = Colors.subtleGrayText
        introSubtitleLabel.numberOfLines = 0
        contentView.addSubview(introSubtitleLabel)
    }

    /// Same field styling as Review Item.
    private func setupField(caption: UILabel, title: String, field: UITextField, placeholder: String) {
        caption.translatesAutoresizingMaskIntoConstraints = false
        caption.text = title
        caption.font = Fonts.semibold14
        caption.textColor = Colors.primaryGrayText
        contentView.addSubview(caption)

        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = placeholder
        field.font = Fonts.regular16
        field.textColor = Colors.primaryGrayText
        field.backgroundColor = Colors.screenBackground
        field.layer.cornerRadius = fieldCornerRadius
        field.layer.borderWidth = 1
        field.layer.borderColor = Colors.newItemCardBorder.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        field.rightViewMode = .always
        contentView.addSubview(field)
    }

    private func setupPostField() {
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.text = "Your post (optional)"
        postCaptionLabel.font = Fonts.semibold14
        postCaptionLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(postCaptionLabel)

        postTextView.translatesAutoresizingMaskIntoConstraints = false
        postTextView.font = Fonts.regular16
        postTextView.textColor = Colors.primaryGrayText
        postTextView.backgroundColor = Colors.screenBackground
        postTextView.layer.cornerRadius = fieldCornerRadius
        postTextView.layer.borderWidth = 1
        postTextView.layer.borderColor = Colors.newItemCardBorder.cgColor
        postTextView.textContainerInset = UIEdgeInsets(
            top: Layout.spacingM,
            left: Layout.spacingS,
            bottom: Layout.spacingM,
            right: Layout.spacingS
        )
        contentView.addSubview(postTextView)
    }

    /// Display-only list row — same visual language as Review Item.
    private func setupAddToListSection() {
        addToListCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addToListCaptionLabel.text = "Add to list"
        addToListCaptionLabel.font = Fonts.semibold14
        addToListCaptionLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(addToListCaptionLabel)

        addToListRow.translatesAutoresizingMaskIntoConstraints = false
        addToListRow.backgroundColor = Colors.newItemInfoBackground
        addToListRow.layer.cornerRadius = fieldCornerRadius
        addToListRow.clipsToBounds = true
        addToListRow.isUserInteractionEnabled = false
        contentView.addSubview(addToListRow)

        let listIcon = UIImageView(image: UIImage(systemName: "list.bullet.rectangle"))
        listIcon.translatesAutoresizingMaskIntoConstraints = false
        listIcon.tintColor = Colors.subtleGrayText
        listIcon.contentMode = .scaleAspectFit
        addToListRow.addSubview(listIcon)

        addToListNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addToListNameLabel.font = Fonts.semibold15
        addToListNameLabel.textColor = Colors.primaryGrayText
        addToListNameLabel.text = listName.isEmpty ? "List" : listName
        addToListRow.addSubview(addToListNameLabel)

        addToListChevron.translatesAutoresizingMaskIntoConstraints = false
        addToListChevron.image = UIImage(systemName: "chevron.right")
        addToListChevron.tintColor = Colors.subtleGrayText
        addToListChevron.contentMode = .scaleAspectFit
        addToListRow.addSubview(addToListChevron)

        NSLayoutConstraint.activate([
            listIcon.leadingAnchor.constraint(equalTo: addToListRow.leadingAnchor, constant: Layout.spacingL),
            listIcon.centerYAnchor.constraint(equalTo: addToListRow.centerYAnchor),
            listIcon.widthAnchor.constraint(equalToConstant: 22),
            listIcon.heightAnchor.constraint(equalToConstant: 22),

            addToListNameLabel.leadingAnchor.constraint(equalTo: listIcon.trailingAnchor, constant: Layout.spacingM),
            addToListNameLabel.centerYAnchor.constraint(equalTo: addToListRow.centerYAnchor),
            addToListNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: addToListChevron.leadingAnchor, constant: -Layout.spacingS),

            addToListChevron.trailingAnchor.constraint(equalTo: addToListRow.trailingAnchor, constant: -Layout.spacingL),
            addToListChevron.centerYAnchor.constraint(equalTo: addToListRow.centerYAnchor),
            addToListChevron.widthAnchor.constraint(equalToConstant: 12),
            addToListChevron.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    private func setupPhotoSection() {
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.setTitle("Add Photo (optional)", for: .normal)
        if let camera = UIImage(systemName: "camera.fill") {
            addPhotoButton.setImage(camera, for: .normal)
            addPhotoButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        }
        Buttons.addFriendButtonStyle(button: addPhotoButton)
        addPhotoButton.layer.cornerRadius = 14
        addPhotoButton.titleLabel?.font = Fonts.semibold15
        addPhotoButton.tintColor = .white
        addPhotoButton.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        contentView.addSubview(addPhotoButton)

        photoPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        photoPreviewImageView.contentMode = .scaleAspectFill
        photoPreviewImageView.clipsToBounds = true
        photoPreviewImageView.layer.cornerRadius = fieldCornerRadius
        photoPreviewImageView.backgroundColor = Colors.newItemInfoBackground
        photoPreviewImageView.isHidden = true
        contentView.addSubview(photoPreviewImageView)
    }

    private func setupContinueButton() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue to Review", for: .normal)
        Buttons.buttonPinkStyle(button: continueButton)
        continueButton.layer.cornerRadius = 14
        continueButton.titleLabel?.font = Fonts.semibold16
        continueButton.addTarget(self, action: #selector(continueToReviewTapped), for: .touchUpInside)
        contentView.addSubview(continueButton)
    }

    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    private func applySampleDefaultsIfNeeded() {
        if titleField.text?.isEmpty != false {
            titleField.text = "Secret of Mana"
        }
        if priceField.text?.isEmpty != false {
            priceField.text = "$49.99"
        }
        if linkField.text?.isEmpty != false {
            linkField.text = "https://www.nintendo.com/secret-of-mana"
        }
        if postTextView.text?.isEmpty != false {
            postTextView.text = "I want to get Secret of Mana.\nLooks awesome!"
        }
        addToListNameLabel.text = listName.isEmpty ? "List" : listName
    }

    private func updatePhotoUI() {
        let image = selectedImage ?? draft.localImage
        let hasPhoto = image != nil
        photoPreviewImageView.image = image
        photoPreviewImageView.isHidden = !hasPhoto
        photoPreviewTopConstraint?.constant = hasPhoto ? Layout.spacingL : 0
        photoPreviewHeightConstraint?.constant = hasPhoto ? photoPreviewHeight : 0
        addPhotoButton.setTitle(hasPhoto ? "Change Photo" : "Add Photo (optional)", for: .normal)
    }

    // DRAFT
    /// Builds draft from current fields (empty fields OK). Only Review creates.
    func makeDraft() -> ItemDraft {
        draft.name = titleField.text ?? ""
        draft.price = priceField.text
        draft.postText = postTextView.text
        draft.productURL = linkField.text
        draft.localImage = selectedImage ?? draft.localImage
        return draft
    }

    // ACTIONS
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func addPhotoTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @objc private func continueToReviewTapped() {
        let review = ReviewItemViewController()
        review.draft = makeDraft()
        review.listName = listName
        navigationController?.pushViewController(review, animated: true)
    }
}

extension AddItemManuallyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        selectedImage = image
        draft.localImage = image
        updatePhotoUI()
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
