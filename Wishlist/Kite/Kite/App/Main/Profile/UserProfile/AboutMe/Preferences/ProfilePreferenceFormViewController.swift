//
//  ProfilePreferenceFormViewController.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import UIKit


/// Reusable add/edit preference form wired to preference API create/update/delete.
final class ProfilePreferenceFormViewController: UIViewController {

    //LOGIC
    private let mode: PreferenceFormMode
    var userName: String = ""
    private let preferenceDataController = ProfilePreferenceDataController.shared
    private let spinnerHelper = SpinnerHelper()
    private var isSubmitting = false
    private var editingPreference: ProfilePreference?

    //UI COMPONENTS
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let categoryCaption = UILabel()
    private let categoryField = UITextField()

    private let titleCaption = UILabel()
    private let titleField = UITextField()

    private let descriptionCaption = UILabel()
    private let descriptionTextView = UITextView()

    private let primaryButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 12
    private let fieldBackground = Colors.feedBackground

    //MANAGE VIEWS
    init(mode: PreferenceFormMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupNavigation()
        setupViews()
        applyMode()
        updatePrimaryButtonEnabled()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        setupCaption(categoryCaption, text: "Category")
        setupTextField(categoryField, placeholder: "Shoes")
        categoryField.autocapitalizationType = .words
        categoryField.returnKeyType = .next
        categoryField.delegate = self
        categoryField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)

        setupCaption(titleCaption, text: "Title")
        setupTextField(titleField, placeholder: "Men’s 12")
        titleField.autocapitalizationType = .sentences
        titleField.returnKeyType = .next
        titleField.delegate = self
        titleField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)

        setupCaption(descriptionCaption, text: "Description (optional)")
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = Fonts.regular16
        descriptionTextView.textColor = Colors.primaryGrayText
        descriptionTextView.backgroundColor = fieldBackground
        descriptionTextView.layer.cornerRadius = fieldCornerRadius
        descriptionTextView.clipsToBounds = true
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        descriptionTextView.delegate = self
        contentView.addSubview(descriptionTextView)

        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.setTitle("Add Preference", for: .normal)
        primaryButton.backgroundColor = Colors.primaryBlue
        primaryButton.setTitleColor(.white, for: .normal)
        primaryButton.titleLabel?.font = Fonts.semibold17
        primaryButton.layer.cornerRadius = 14
        primaryButton.clipsToBounds = true
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)
        contentView.addSubview(primaryButton)

        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete Preference", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.titleLabel?.font = Fonts.semibold16
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        contentView.addSubview(deleteButton)

        let side = Layout.spacingL
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

            categoryCaption.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            categoryCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            categoryCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            categoryField.topAnchor.constraint(equalTo: categoryCaption.bottomAnchor, constant: Layout.spacingS),
            categoryField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            categoryField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            categoryField.heightAnchor.constraint(equalToConstant: 48),

            titleCaption.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: Layout.spacingL),
            titleCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            titleField.topAnchor.constraint(equalTo: titleCaption.bottomAnchor, constant: Layout.spacingS),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            titleField.heightAnchor.constraint(equalToConstant: 48),

            descriptionCaption.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: Layout.spacingL),
            descriptionCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            descriptionCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            descriptionTextView.topAnchor.constraint(equalTo: descriptionCaption.bottomAnchor, constant: Layout.spacingS),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),

            primaryButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: Layout.spacingXXL),
            primaryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            primaryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            primaryButton.heightAnchor.constraint(equalToConstant: 52),

            deleteButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: Layout.spacingL),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    private func setupCaption(_ label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = Fonts.semibold16
        label.textColor = Colors.subtleGrayText
        contentView.addSubview(label)
    }

    private func setupTextField(_ field: UITextField, placeholder: String) {
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = placeholder
        field.font = Fonts.regular16
        field.textColor = Colors.primaryGrayText
        field.backgroundColor = fieldBackground
        field.layer.cornerRadius = fieldCornerRadius
        field.clipsToBounds = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        field.rightViewMode = .always
        contentView.addSubview(field)
    }

    private func applyMode() {
        switch mode {
        case .add:
            title = "New Preference"
            primaryButton.setTitle("Add Preference", for: .normal)
            deleteButton.isHidden = true

        case .edit(let preference):
            title = "Edit Preference"
            primaryButton.setTitle("Save Changes", for: .normal)
            deleteButton.isHidden = false
            editingPreference = preference
            categoryField.text = preference.preferenceCategory
            titleField.text = preference.preferenceTitle
            descriptionTextView.text = preference.preferenceDescription
        }
    }

    //ACTIONS
    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func textFieldsChanged() {
        updatePrimaryButtonEnabled()
    }

    @objc private func primaryTapped() {
        switch mode {
        case .add:
            submitAdd()
        case .edit:
            submitEdit()
        }
    }

    @objc private func deleteTapped() {
        guard case .edit(let preference) = mode else { return }

        let alert = UIAlertController(
            title: "Delete Preference?",
            message: "This will remove “\(preference.preferenceCategory)” from Clothing & Sizes.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.submitDelete(preference: preference)
        })
        present(alert, animated: true)
    }

    private func trimmedFields() -> (category: String, title: String, description: String)? {
        let category = (categoryField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let titleText = (titleField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let description = (descriptionTextView.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !category.isEmpty, !titleText.isEmpty else {
            updatePrimaryButtonEnabled()
            return nil
        }
        guard category.count <= profilePreferenceFunctions.categoryMax,
              titleText.count <= profilePreferenceFunctions.titleMax,
              description.count <= profilePreferenceFunctions.descriptionMax else {
            showSimpleAlert(
                title: "Too long",
                message: "Category max \(profilePreferenceFunctions.categoryMax), title max \(profilePreferenceFunctions.titleMax), description max \(profilePreferenceFunctions.descriptionMax)."
            )
            return nil
        }
        return (category, titleText, description)
    }

    private func submitAdd() {
        guard !isSubmitting else { return }
        guard let fields = trimmedFields() else { return }

        isSubmitting = true
        primaryButton.isEnabled = false
        spinnerHelper.show(in: view, delay: 0)

        Task {
            let created = await preferenceDataController.createPreference(
                preferenceCategory: fields.category,
                preferenceTitle: fields.title,
                preferenceDescription: fields.description
            )

            await MainActor.run {
                self.spinnerHelper.hide()
                self.isSubmitting = false
                self.updatePrimaryButtonEnabled()

                if created != nil {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showSimpleAlert(
                        title: "Couldn’t add preference",
                        message: "Something went wrong. Please try again."
                    )
                }
            }
        }
    }

    private func submitEdit() {
        guard !isSubmitting else { return }
        guard let preference = editingPreference else { return }
        guard let fields = trimmedFields() else { return }

        isSubmitting = true
        primaryButton.isEnabled = false
        deleteButton.isEnabled = false
        spinnerHelper.show(in: view, delay: 0)

        Task {
            let updated = await preferenceDataController.updatePreference(
                userPreferenceID: preference.userPreferenceID,
                preferenceCategory: fields.category,
                preferenceTitle: fields.title,
                preferenceDescription: fields.description,
                displayOrder: preference.displayOrder
            )

            await MainActor.run {
                self.spinnerHelper.hide()
                self.isSubmitting = false
                self.deleteButton.isEnabled = true
                self.updatePrimaryButtonEnabled()

                if updated != nil {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showSimpleAlert(
                        title: "Couldn’t save changes",
                        message: "Something went wrong. Please try again."
                    )
                }
            }
        }
    }

    private func submitDelete(preference: ProfilePreference) {
        guard !isSubmitting else { return }

        isSubmitting = true
        primaryButton.isEnabled = false
        deleteButton.isEnabled = false
        spinnerHelper.show(in: view, delay: 0)

        let owner = preference.userName.isEmpty ? userName : preference.userName

        Task {
            let success = await preferenceDataController.removePreference(
                userPreferenceID: preference.userPreferenceID,
                userName: owner
            )

            await MainActor.run {
                self.spinnerHelper.hide()
                self.isSubmitting = false
                self.deleteButton.isEnabled = true
                self.updatePrimaryButtonEnabled()

                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showSimpleAlert(
                        title: "Couldn’t delete preference",
                        message: "Something went wrong. Please try again."
                    )
                }
            }
        }
    }

    private func updatePrimaryButtonEnabled() {
        let category = (categoryField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let titleText = (titleField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let valid = !category.isEmpty && !titleText.isEmpty && !isSubmitting
        primaryButton.isEnabled = valid
        primaryButton.alpha = valid ? 1.0 : 0.45
    }

    private func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func keyboardWillChange(_ notification: Notification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }

        let keyboardInView = view.convert(frame, from: nil)
        let overlap = max(0, view.bounds.maxY - keyboardInView.origin.y)
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = overlap
            self.scrollView.verticalScrollIndicatorInsets.bottom = overlap
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = 0
            self.scrollView.verticalScrollIndicatorInsets.bottom = 0
        }
    }
}

extension ProfilePreferenceFormViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === categoryField {
            titleField.becomeFirstResponder()
        } else if textField === titleField {
            descriptionTextView.becomeFirstResponder()
        }
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        updatePrimaryButtonEnabled()
    }
}
