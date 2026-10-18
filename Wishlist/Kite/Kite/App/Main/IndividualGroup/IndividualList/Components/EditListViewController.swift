//
//  EditListViewController.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS


final class EditListViewController: UIViewController {

    //LOGIC
    private let list: GroupModel
    private let originalName: String
    private let originalDescription: String
    private let originalImageURL: String?

    private enum ImageChange {
        case unchanged
        case replaced(UIImage)
        case removed
    }

    private var imageChange: ImageChange = .unchanged
    private var nameWasEdited = false
    private var imageTask: Task<Void, Never>?
    private let imageFunctions = ImageFunctions()

    private let screenInset: CGFloat = 20
    private let fieldBackground = UIColor(hex: "#F3F4F6")
    private let imageAspect: CGFloat = 1.0 / 1.85

    //UI COMPONENTS
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let previewView = UIView()
    private let previewImageView = UIImageView()
    private let placeholderIcon = UIImageView()
    private let cameraButton = UIButton(type: .system)

    private let photoActionsRow = UIStackView()
    private let changePhotoButton = UIButton(type: .system)
    private let removePhotoButton = UIButton(type: .system)

    private let nameLabel = UILabel()
    private let nameField = UITextField()
    private let nameErrorLabel = UILabel()
    private var nameFieldHeight: NSLayoutConstraint?
    private var nameErrorSpacing: NSLayoutConstraint?

    private let descriptionLabel = UILabel()
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()

    private let helperLabel = UILabel()

    private let closeButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let savingIndicator = UIActivityIndicatorView(style: .medium)

    private var isSaving = false

    init(list: GroupModel) {
        self.list = list
        let name = list.groupName.trimmingCharacters(in: .whitespacesAndNewlines)
        originalName = name
        originalDescription = EditListViewController.displayDescription(list.groupDescription)
        originalImageURL = EditListViewController.usableImageURL(list.groupImage)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        imageTask?.cancel()
        NotificationCenter.default.removeObserver(self)
    }

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupNavigationBar()
        setupScrollView()
        setupPreview()
        setupPhotoActions()
        setupName()
        setupDescription()
        setupHelper()
        setupKeyboard()
        applyOriginalContent()
        refreshPhotoActions()
        refreshSaveState()
        loadOriginalImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.presentationController?.delegate = self
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateNameFieldHeight()
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
        navigationItem.title = "Edit List"

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
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        saveButton.titleLabel?.adjustsFontForContentSizeCategory = true
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        savingIndicator.hidesWhenStopped = true
        savingIndicator.color = Colors.primaryPink
        let saveRow = UIStackView(arrangedSubviews: [saveButton, savingIndicator])
        saveRow.axis = .horizontal
        saveRow.alignment = .center
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveRow)
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
        photoActionsRow.axis = .horizontal
        photoActionsRow.spacing = 20
        photoActionsRow.alignment = .center
        contentView.addSubview(photoActionsRow)

        stylePhotoButton(changePhotoButton)
        stylePhotoButton(removePhotoButton)
        changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        removePhotoButton.addTarget(self, action: #selector(removePhotoTapped), for: .touchUpInside)
        photoActionsRow.addArrangedSubview(changePhotoButton)
        photoActionsRow.addArrangedSubview(removePhotoButton)

        NSLayoutConstraint.activate([
            photoActionsRow.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: Layout.spacingL),
            photoActionsRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            photoActionsRow.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -screenInset),
            changePhotoButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            removePhotoButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }

    private func setupName() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "List name"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = Colors.primaryText
        contentView.addSubview(nameLabel)

        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameField.adjustsFontForContentSizeCategory = true
        nameField.textColor = Colors.primaryText
        nameField.backgroundColor = fieldBackground
        nameField.layer.cornerRadius = Layout.cornerMedium
        nameField.autocorrectionType = .no
        nameField.returnKeyType = .next
        nameField.delegate = self
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        nameField.leftViewMode = .always
        nameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        nameField.rightViewMode = .always
        nameField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        contentView.addSubview(nameField)

        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        nameErrorLabel.text = "Enter a list name."
        nameErrorLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        nameErrorLabel.adjustsFontForContentSizeCategory = true
        nameErrorLabel.textColor = Colors.primaryPink
        nameErrorLabel.numberOfLines = 0
        nameErrorLabel.isHidden = true
        contentView.addSubview(nameErrorLabel)

        let fieldHeight = nameField.heightAnchor.constraint(equalToConstant: 52)
        nameFieldHeight = fieldHeight
        let errorSpacing = nameErrorLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 0)
        nameErrorSpacing = errorSpacing

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoActionsRow.bottomAnchor, constant: Layout.spacingXL),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Layout.spacingS),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            fieldHeight,

            errorSpacing,
            nameErrorLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor, constant: 4),
            nameErrorLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor)
        ])
        updateNameFieldHeight()
    }

    private func setupDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = Colors.primaryText
        contentView.addSubview(descriptionLabel)

        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionView.adjustsFontForContentSizeCategory = true
        descriptionView.textColor = Colors.primaryText
        descriptionView.backgroundColor = fieldBackground
        descriptionView.layer.cornerRadius = Layout.cornerMedium
        descriptionView.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        descriptionView.delegate = self
        contentView.addSubview(descriptionView)

        descriptionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        descriptionPlaceholder.text = "Add a description"
        descriptionPlaceholder.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionPlaceholder.adjustsFontForContentSizeCategory = true
        descriptionPlaceholder.textColor = Colors.subtleGrayText
        descriptionView.addSubview(descriptionPlaceholder)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor, constant: Layout.spacingXL),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

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
        helperLabel.text = "This is shown on your list."
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

    private func stylePhotoButton(_ button: UIButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(Colors.primaryPink, for: .normal)
        button.contentHorizontalAlignment = .leading
    }

    private func updateNameFieldHeight() {
        let line = nameField.font?.lineHeight ?? 20
        nameFieldHeight?.constant = max(52, ceil(line) + 28)
    }

    //ACTIONS
    @objc private func closeTapped() {
        attemptClose()
    }

    @objc private func saveTapped() {
        view.endEditing(true)
        nameWasEdited = true
        refreshSaveState()
        guard canSave, !isSaving else { return }
        // Saving to the server is the next step.
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
        imageChange = .removed
        showPreview(image: nil)
        refreshPhotoActions()
        refreshSaveState()
    }

    @objc private func nameChanged() {
        nameWasEdited = true
        refreshSaveState()
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

    private func attemptClose() {
        guard !isSaving else { return }
        guard hasChanges else {
            dismiss(animated: true)
            return
        }

        let alert = UIAlertController(
            title: "Discard changes?",
            message: "Your edits will be lost.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Keep Editing", style: .cancel))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    //FUNCTIONS
    private func applyOriginalContent() {
        nameField.text = originalName
        descriptionView.text = originalDescription
        descriptionPlaceholder.isHidden = !originalDescription.isEmpty
    }

    private func loadOriginalImage() {
        guard let originalImageURL else {
            showPreview(image: nil)
            return
        }
        imageTask = Task { [weak self] in
            let image = await self?.imageFunctions.fetchImage(from: originalImageURL)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard let self, case .unchanged = self.imageChange else { return }
                self.showPreview(image: image)
            }
        }
    }

    private func showPreview(image: UIImage?) {
        previewImageView.image = image
        placeholderIcon.isHidden = image != nil
    }

    private func refreshPhotoActions() {
        if hasDisplayImage {
            changePhotoButton.setTitle("Change Photo", for: .normal)
            removePhotoButton.isHidden = false
            removePhotoButton.setTitle("Remove Photo", for: .normal)
        } else {
            changePhotoButton.setTitle("Add Photo", for: .normal)
            removePhotoButton.isHidden = true
        }
    }

    private var hasDisplayImage: Bool {
        switch imageChange {
        case .replaced:
            return true
        case .removed:
            return false
        case .unchanged:
            return originalImageURL != nil
        }
    }

    private var trimmedName: String {
        (nameField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedDescription: String {
        descriptionView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var hasChanges: Bool {
        if trimmedName != originalName { return true }
        if trimmedDescription != originalDescription { return true }
        if case .unchanged = imageChange { return false }
        return true
    }

    private var canSave: Bool {
        hasChanges && !trimmedName.isEmpty
    }

    private func refreshSaveState() {
        let showError = trimmedName.isEmpty && (nameWasEdited || originalName.isEmpty)
        nameErrorLabel.isHidden = !showError
        nameErrorSpacing?.constant = showError ? Layout.spacingXS : 0

        saveButton.isEnabled = canSave && !isSaving
        saveButton.setTitleColor(canSave && !isSaving ? Colors.primaryPink : Colors.subtleGrayText, for: .normal)
        saveButton.setTitleColor(Colors.subtleGrayText, for: .disabled)
        closeButton.isEnabled = !isSaving
        navigationController?.isModalInPresentation = hasChanges || isSaving
    }

    private func scrollFieldIntoView(_ field: UIView) {
        let rect = field.convert(field.bounds, to: scrollView).insetBy(dx: 0, dy: -Layout.spacingL)
        scrollView.scrollRectToVisible(rect, animated: true)
    }

    private static func displayDescription(_ raw: String) -> String {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.caseInsensitiveCompare("this is my new group so cool") == .orderedSame {
            return ""
        }
        return trimmed
    }

    private static func usableImageURL(_ raw: String?) -> String? {
        guard let raw else { return nil }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return nil }
        let lowered = trimmed.lowercased()
        if lowered == "empty" || lowered == "needgroupimage" || lowered == "needgroupname" {
            return nil
        }
        return trimmed
    }
}


extension EditListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionView.becomeFirstResponder()
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollFieldIntoView(textField)
    }
}


extension EditListViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholder.isHidden = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        refreshSaveState()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollFieldIntoView(textView)
    }
}


extension EditListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let image else { return }
            self.imageTask?.cancel()
            self.imageChange = .replaced(image)
            self.showPreview(image: image)
            self.refreshPhotoActions()
            self.refreshSaveState()
        }
    }
}


extension EditListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        attemptClose()
    }
}


extension EditListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var view = touch.view
        while let current = view {
            if current is UIControl { return false }
            view = current.superview
        }
        return true
    }
}
