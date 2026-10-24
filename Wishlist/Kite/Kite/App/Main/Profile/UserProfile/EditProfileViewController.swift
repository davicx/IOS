//
//  EditProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 1/12/25.
//

import UIKit


protocol EditProfileViewControllerDelegate: AnyObject {
    //func didUpdateProfile(firstName: String, lastName: String, biography: String)
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) 

}


class EditProfileViewController: UIViewController {
    let profileAPI = ProfileAPI()
    let userDefaultManager = UserDefaultManager()

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userFullNameField: UITextField!
    @IBOutlet weak var userBiographyTextArea: UITextView!
    
    //Incoming Data
    var inputFirstName: String! //First Name
    var inputLastName: String! //Last Name
    var inputBiography: String!
    var inputProfileImage: UIImage?
   
    // Delegate property
    weak var delegate: EditProfileViewControllerDelegate?
    
    var selectedProfileImage: UIImage?
    private var didChooseNewPhoto = false
    private var isSaving = false

    private let screenInset: CGFloat = 20
    private let fieldBackground = UIColor(hex: "#F3F4F6")
    private let imageAspect: CGFloat = 1.0 / 1.85

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let previewView = UIView()
    private let previewImageView = UIImageView()
    private let placeholderIcon = UIImageView()
    private let cameraButton = UIButton(type: .system)
    private let changePhotoButton = UIButton(type: .system)
    private let firstNameLabel = UILabel()
    private let firstNameField = UITextField()
    private let lastNameLabel = UILabel()
    private let lastNameField = UITextField()
    private let biographyLabel = UILabel()
    private let biographyView = UITextView()
    private let helperLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let formSaveButton = UIButton(type: .system)

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.subviews.forEach { $0.isHidden = true }
        view.backgroundColor = Colors.screenBackground
        setupNavigationBar()
        setupForm()
        applyIncomingValues()
    }

    @IBAction func editPhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = false
        present(vc, animated: true)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard !isSaving else { return }
        isSaving = true
        sender.isEnabled = false
        formSaveButton.isEnabled = false
        formSaveButton.setTitleColor(Colors.subtleGrayText, for: .normal)

        let currentUser = userDefaultManager.getLoggedInUser()
        let updatedFirstName = firstNameField.text ?? ""
        let updatedLastName = lastNameField.text ?? ""
        let updatedBiography = biographyView.text ?? ""

         //TYPE 1: Image Not Updated
         if !didChooseNewPhoto || selectedProfileImage == nil {
             print("TYPE 1: Image is the same")
             
             Task {
                 do {
                     let updatedProfileResponse = try await profileAPI.updateUserProfileAPI(
                         currentUser: currentUser,
                         imageName: "currentUser",
                         firstName: updatedFirstName,
                         lastName: updatedLastName,
                         biography: updatedBiography
                     )

                     await MainActor.run {
                         guard updatedProfileResponse.success else {
                             self.failSave(sender: sender, message: updatedProfileResponse.message)
                             return
                         }
                         // Notify the delegate with the updated data
                         self.delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: nil)
                         // Go back to ProfileViewController
                         self.navigationController?.popViewController(animated: true)
                     }
                 
                 } catch {
                     print("Failed to update profile: \(error)")
                     await MainActor.run {
                         self.failSave(sender: sender, message: "Couldn't save your profile. Please try again.")
                     }
                 }
             }
             
         //TYPE 2: Image Updated
         } else {
             print("TYPE 2: Image Changed")
             guard let newProfileImage = selectedProfileImage else {
                  print("No new image selected. Skipping image update.")
                  failSave(sender: sender, message: "Couldn't save your profile. Please try again.")
                  return
              }
             
             Task {
                 do {
                     let updatedProfileResponse = try await profileAPI.updateFullUserProfileAPI(currentUser: currentUser, profileImage: newProfileImage, firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)

                     await MainActor.run {
                         guard updatedProfileResponse.success else {
                             self.failSave(sender: sender, message: updatedProfileResponse.message)
                             return
                         }
                         // Notify the delegate with the updated data
                         //delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)
                         self.delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: newProfileImage)
                         // Go back to ProfileViewController
                         self.navigationController?.popViewController(animated: true)
                     }
                 
                 } catch {
                     print("Failed to update profile: \(error)")
                     await MainActor.run {
                         self.failSave(sender: sender, message: "Couldn't save your profile. Please try again.")
                     }
                 }
             }
         }
     

    }

    private func failSave(sender: UIButton, message: String) {
        isSaving = false
        sender.isEnabled = true
        formSaveButton.isEnabled = true
        formSaveButton.setTitleColor(Colors.primaryPink, for: .normal)
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        let alert = UIAlertController(
            title: "Couldn't save profile",
            message: trimmed.isEmpty ? "Couldn't save your profile. Please try again." : trimmed,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showCrop(for image: UIImage) {
        let crop = ProfileImageCropViewController(image: image)
        crop.modalPresentationStyle = .fullScreen
        crop.onUsePhoto = { [weak self] cropped in
            self?.didChooseNewPhoto = true
            self?.selectedProfileImage = cropped
            self?.userImageView.image = cropped
            self?.showPreview(cropped)
        }
        present(crop, animated: true)
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.screenBackground
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .font: Fonts.semibold20,
            .foregroundColor: Colors.primaryText
        ]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.title = "Edit Profile"
        navigationItem.largeTitleDisplayMode = .never

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = Colors.screenBackground
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

        formSaveButton.setTitle("Save", for: .normal)
        formSaveButton.titleLabel?.font = Fonts.semibold17
        formSaveButton.setTitleColor(Colors.primaryPink, for: .normal)
        formSaveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        formSaveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: formSaveButton)
    }

    private func setupForm() {
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
        scrollView.addGestureRecognizer(dismissTap)

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
        cameraButton.addTarget(self, action: #selector(editPhotoButton(_:)), for: .touchUpInside)
        previewView.addSubview(cameraButton)

        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        changePhotoButton.setTitle("Change Photo", for: .normal)
        changePhotoButton.titleLabel?.font = Fonts.semibold15
        changePhotoButton.setTitleColor(Colors.primaryPink, for: .normal)
        changePhotoButton.contentHorizontalAlignment = .leading
        changePhotoButton.addTarget(self, action: #selector(editPhotoButton(_:)), for: .touchUpInside)
        contentView.addSubview(changePhotoButton)

        styleFieldLabel(firstNameLabel, title: "First name")
        styleTextField(firstNameField)
        styleFieldLabel(lastNameLabel, title: "Last name")
        styleTextField(lastNameField)
        styleFieldLabel(biographyLabel, title: "Biography")

        biographyView.translatesAutoresizingMaskIntoConstraints = false
        biographyView.font = Fonts.regular16
        biographyView.textColor = Colors.primaryText
        biographyView.backgroundColor = fieldBackground
        biographyView.layer.cornerRadius = Layout.cornerMedium
        biographyView.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        contentView.addSubview(biographyView)

        helperLabel.translatesAutoresizingMaskIntoConstraints = false
        helperLabel.text = "This is shown on your profile."
        helperLabel.font = Fonts.regular13
        helperLabel.textColor = Colors.subtleGrayText
        helperLabel.numberOfLines = 0
        contentView.addSubview(helperLabel)

        contentView.addSubview(firstNameLabel)
        contentView.addSubview(firstNameField)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(lastNameField)
        contentView.addSubview(biographyLabel)

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
            cameraButton.heightAnchor.constraint(equalToConstant: 44),

            changePhotoButton.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: Layout.spacingL),
            changePhotoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            changePhotoButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

            firstNameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: Layout.spacingXL),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            firstNameField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: Layout.spacingS),
            firstNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            firstNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            firstNameField.heightAnchor.constraint(equalToConstant: 52),

            lastNameLabel.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: Layout.spacingXL),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            lastNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            lastNameField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: Layout.spacingS),
            lastNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            lastNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),

            biographyLabel.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: Layout.spacingXL),
            biographyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            biographyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),

            biographyView.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: Layout.spacingS),
            biographyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            biographyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            biographyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 128),

            helperLabel.topAnchor.constraint(equalTo: biographyView.bottomAnchor, constant: Layout.spacingM),
            helperLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: screenInset),
            helperLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -screenInset),
            helperLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func styleFieldLabel(_ label: UILabel, title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = Fonts.semibold15
        label.textColor = Colors.primaryText
    }

    private func styleTextField(_ field: UITextField) {
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = Fonts.regular16
        field.textColor = Colors.primaryText
        field.backgroundColor = fieldBackground
        field.layer.cornerRadius = Layout.cornerMedium
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 52))
        field.rightViewMode = .always
    }

    private func applyIncomingValues() {
        let firstName: String = inputFirstName ?? ""
        let lastName: String = inputLastName ?? ""
        let biography: String = inputBiography ?? ""

        firstNameField.text = firstName
        lastNameField.text = lastName
        biographyView.text = biography
        userNameField.text = firstName
        userFullNameField.text = lastName
        userBiographyTextArea.text = biography

        if let profileImage = inputProfileImage {
            userImageView.image = profileImage
            showPreview(profileImage)
        } else {
            showPreview(nil)
        }
    }

    private func showPreview(_ image: UIImage?) {
        previewImageView.image = image
        placeholderIcon.isHidden = image != nil
        changePhotoButton.setTitle(image == nil ? "Add Photo" : "Change Photo", for: .normal)
    }

    @objc private func closeTapped() {
        guard !isSaving else { return }
        navigationController?.popViewController(animated: true)
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

    // New function to handle full profile update when image is changed
    func fullProfileUpdate() {
        print("Updating full profile with new image...")
        // Mock function to handle full profile update
        // You can replace this with the actual API call
    }

}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        print("Here some info DUDE \(info)")
        picker.dismiss(animated: true) { [weak self] in
            guard let selectedImage else { return }
            self?.showCrop(for: selectedImage)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("ah never mind dude!")
        picker.dismiss(animated: true)
    }
}

