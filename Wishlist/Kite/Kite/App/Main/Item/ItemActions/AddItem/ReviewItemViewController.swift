//
//  ReviewItemViewController.swift
//  Kite
//
//  Created by David Vasquez on 8/22/26.
//

import UIKit


/// Editable review before save. Owns the draft. Only this screen calls create (Step 7).
final class ReviewItemViewController: UIViewController {

    // LOGIC
    var draft = ItemDraft.empty(groupID: 0)
    var listName: String = "List"
    private let spinnerHelper = SpinnerHelper()
    private let userDefaultManager = UserDefaultManager()
    private var isSubmitting = false

    // UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let photoImageView = UIImageView()
    private let editPhotoButton = UIButton(type: .system)

    private let titleCaptionLabel = UILabel()
    private let titleField = UITextField()

    private let priceCaptionLabel = UILabel()
    private let priceField = UITextField()

    private let linkCaptionLabel = UILabel()
    private let linkField = UITextField()

    private let postCaptionLabel = UILabel()
    private let postTextView = UITextView()

    private let addToListRow = UIControl()
    private let addToListTitleLabel = UILabel()
    private let addToListNameLabel = UILabel()
    private let addToListChevron = UIImageView()

    private let addToListButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 12
    private let photoSize: CGFloat = 96

    // MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupNavigation()
        setupViews()
        applyDraftToFields()
    }

    // LAYOUT
    private func setupNavigation() {
        title = "Review Item"
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        setupPhotoRow()
        setupField(caption: titleCaptionLabel, title: "Title", field: titleField, placeholder: "Item name")
        setupField(caption: priceCaptionLabel, title: "Price", field: priceField, placeholder: "$0.00")
        setupField(caption: linkCaptionLabel, title: "Link", field: linkField, placeholder: "https://")
        linkField.keyboardType = .URL
        linkField.autocapitalizationType = .none
        linkField.autocorrectionType = .no

        setupPostField()
        setupAddToListRow()
        setupCTA()

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

            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            photoImageView.widthAnchor.constraint(equalToConstant: photoSize),
            photoImageView.heightAnchor.constraint(equalToConstant: photoSize),

            editPhotoButton.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: Layout.spacingL),
            editPhotoButton.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),

            titleCaptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Layout.spacingXL),
            titleCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            titleField.topAnchor.constraint(equalTo: titleCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            titleField.heightAnchor.constraint(equalToConstant: 48),

            priceCaptionLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Layout.spacingL),
            priceCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            priceCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            priceField.topAnchor.constraint(equalTo: priceCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            priceField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            priceField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            priceField.heightAnchor.constraint(equalToConstant: 48),

            linkCaptionLabel.topAnchor.constraint(equalTo: priceField.bottomAnchor, constant: Layout.spacingL),
            linkCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            linkField.topAnchor.constraint(equalTo: linkCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            linkField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            linkField.heightAnchor.constraint(equalToConstant: 48),

            postCaptionLabel.topAnchor.constraint(equalTo: linkField.bottomAnchor, constant: Layout.spacingL),
            postCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            postCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            postTextView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            postTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            postTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            postTextView.heightAnchor.constraint(equalToConstant: 110),

            addToListRow.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: Layout.spacingXL),
            addToListRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addToListRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            addToListRow.heightAnchor.constraint(equalToConstant: 56),

            addToListButton.topAnchor.constraint(equalTo: addToListRow.bottomAnchor, constant: Layout.spacingXL),
            addToListButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addToListButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            addToListButton.heightAnchor.constraint(equalToConstant: 52),
            addToListButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    private func setupPhotoRow() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 14
        photoImageView.backgroundColor = Colors.newItemInfoBackground
        contentView.addSubview(photoImageView)

        editPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        editPhotoButton.setTitle("Edit Photo", for: .normal)
        editPhotoButton.titleLabel?.font = Fonts.semibold14
        editPhotoButton.setTitleColor(Colors.primaryPink, for: .normal)
        editPhotoButton.addTarget(self, action: #selector(editPhotoTapped), for: .touchUpInside)
        contentView.addSubview(editPhotoButton)
    }

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

    private func setupAddToListRow() {
        addToListRow.translatesAutoresizingMaskIntoConstraints = false
        addToListRow.backgroundColor = Colors.newItemInfoBackground
        addToListRow.layer.cornerRadius = fieldCornerRadius
        addToListRow.clipsToBounds = true
        contentView.addSubview(addToListRow)

        addToListTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addToListTitleLabel.text = "Add to list"
        addToListTitleLabel.font = Fonts.regular13
        addToListTitleLabel.textColor = Colors.subtleGrayText

        addToListNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addToListNameLabel.font = Fonts.semibold15
        addToListNameLabel.textColor = Colors.primaryGrayText

        addToListChevron.translatesAutoresizingMaskIntoConstraints = false
        addToListChevron.image = UIImage(systemName: "chevron.right")
        addToListChevron.tintColor = Colors.subtleGrayText
        addToListChevron.contentMode = .scaleAspectFit

        let textStack = UIStackView(arrangedSubviews: [addToListTitleLabel, addToListNameLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.spacing = 2
        addToListRow.addSubview(textStack)
        addToListRow.addSubview(addToListChevron)

        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: addToListRow.leadingAnchor, constant: Layout.spacingL),
            textStack.centerYAnchor.constraint(equalTo: addToListRow.centerYAnchor),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: addToListChevron.leadingAnchor, constant: -Layout.spacingS),

            addToListChevron.trailingAnchor.constraint(equalTo: addToListRow.trailingAnchor, constant: -Layout.spacingL),
            addToListChevron.centerYAnchor.constraint(equalTo: addToListRow.centerYAnchor),
            addToListChevron.widthAnchor.constraint(equalToConstant: 12),
            addToListChevron.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    private func setupCTA() {
        addToListButton.translatesAutoresizingMaskIntoConstraints = false
        addToListButton.setTitle("Add to List", for: .normal)
        if let gift = UIImage(systemName: "gift.fill") {
            addToListButton.setImage(gift, for: .normal)
            addToListButton.tintColor = .white
            addToListButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        }
        Buttons.buttonPinkStyle(button: addToListButton)
        addToListButton.layer.cornerRadius = 14
        addToListButton.titleLabel?.font = Fonts.semibold16
        addToListButton.addTarget(self, action: #selector(addToListTapped), for: .touchUpInside)
        contentView.addSubview(addToListButton)
    }

    private func applyDraftToFields() {
        titleField.text = draft.name
        priceField.text = draft.price
        linkField.text = draft.productURL
        postTextView.text = draft.postText
        photoImageView.image = draft.localImage
        addToListNameLabel.text = listName.isEmpty ? "List" : listName

        if draft.localImage == nil {
            photoImageView.image = UIImage(systemName: "photo")
            photoImageView.tintColor = Colors.subtleGrayText
            photoImageView.contentMode = .center
        } else {
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.tintColor = nil
        }
    }

    /// Syncs UI back into the owned draft (used before create in Step 7).
    func syncDraftFromFields() -> ItemDraft {
        draft.name = titleField.text ?? ""
        draft.price = priceField.text
        draft.productURL = linkField.text
        draft.postText = postTextView.text
        return draft
    }

    // ACTIONS
    @objc private func editPhotoTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    // Only create path for Paste / Photo / Manual.
    @objc private func addToListTapped() {
        guard !isSubmitting else { return }

        let updated = syncDraftFromFields()
        let itemName = updated.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemPrice = (updated.price ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let itemLink = (updated.productURL ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let itemDescription = (updated.postText ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let postCaption = itemDescription.isEmpty ? itemName : itemDescription

        guard let postImage = updated.localImage else {
            showSimpleAlert(title: "Photo needed", message: "Add a photo before adding this item to your list.")
            return
        }
        guard !itemName.isEmpty else {
            showSimpleAlert(title: "Title needed", message: "Enter a title for this item.")
            return
        }

        isSubmitting = true
        addToListButton.isEnabled = false
        spinnerHelper.show(in: view, delay: 0.0)

        let postFrom = userDefaultManager.getLoggedInUser()
        let postTo = "\(updated.groupID)"
        let listID = 0
        let groupID = updated.groupID

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
                itemDescription: itemDescription.isEmpty ? itemName : itemDescription,
                itemLink: itemLink
            )

            if success {
                await GroupLogic.shared.fetchGroupWishlistItems(groupID: groupID)
            }

            await MainActor.run {
                self.spinnerHelper.hide()
                self.isSubmitting = false
                self.addToListButton.isEnabled = true

                if success {
                    self.draft = ItemDraft.empty(groupID: groupID)
                    self.dismiss(animated: true)
                } else {
                    self.showSimpleAlert(
                        title: "Couldn’t add item",
                        message: "Something went wrong. Please try again."
                    )
                }
            }
        }
    }

    private func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ReviewItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        draft.localImage = image
        photoImageView.image = image
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.tintColor = nil
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
