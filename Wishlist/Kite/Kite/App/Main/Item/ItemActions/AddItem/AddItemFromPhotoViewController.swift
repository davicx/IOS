//
//  AddItemFromPhotoViewController.swift
//  Kite
//
//  Created by David Vasquez on 8/21/26.
//

import UIKit


final class AddItemFromPhotoViewController: UIViewController {

    /// Filled here → Review creates the item (Step 7). Do not call create from this screen.
    var draft = ItemDraft.empty(groupID: 0)
    var listName: String = "List"

    // UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerIconBackground = UIView()
    private let headerIconView = UIImageView()
    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    private let photoDropControl = UIControl()
    private let photoDropBorderLayer = CAShapeLayer()
    private let dropIconView = UIImageView()
    private let dropTitleLabel = UILabel()
    private let dropSubtitleLabel = UILabel()
    private let photoPreviewImageView = UIImageView()

    private let continueButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 14
    private let dropMinHeight: CGFloat = 220

    // MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Photo"
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
        updatePhotoUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDropBorderPath()
    }

    // LAYOUT
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        setupHeader()
        setupPhotoDrop()
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

            headerIconBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            headerIconBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            headerIconBackground.widthAnchor.constraint(equalToConstant: 36),
            headerIconBackground.heightAnchor.constraint(equalToConstant: 36),

            headerIconView.centerXAnchor.constraint(equalTo: headerIconBackground.centerXAnchor),
            headerIconView.centerYAnchor.constraint(equalTo: headerIconBackground.centerYAnchor),
            headerIconView.widthAnchor.constraint(equalToConstant: 18),
            headerIconView.heightAnchor.constraint(equalToConstant: 18),

            headerTitleLabel.leadingAnchor.constraint(equalTo: headerIconBackground.trailingAnchor, constant: Layout.spacingS),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerIconBackground.centerYAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            headerSubtitleLabel.topAnchor.constraint(equalTo: headerIconBackground.bottomAnchor, constant: Layout.spacingS),
            headerSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            headerSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            photoDropControl.topAnchor.constraint(equalTo: headerSubtitleLabel.bottomAnchor, constant: Layout.spacingXL),
            photoDropControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            photoDropControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            photoDropControl.heightAnchor.constraint(greaterThanOrEqualToConstant: dropMinHeight),

            continueButton.topAnchor.constraint(equalTo: photoDropControl.bottomAnchor, constant: Layout.spacingXXL),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    private func setupHeader() {
        headerIconBackground.translatesAutoresizingMaskIntoConstraints = false
        headerIconBackground.backgroundColor = Colors.newItemPhotoIconBackground
        headerIconBackground.layer.cornerRadius = 18
        contentView.addSubview(headerIconBackground)

        headerIconView.translatesAutoresizingMaskIntoConstraints = false
        headerIconView.image = UIImage(systemName: "camera")
        headerIconView.tintColor = Colors.primaryBlue
        headerIconView.contentMode = .scaleAspectFit
        headerIconBackground.addSubview(headerIconView)

        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLabel.text = "Add from a photo"
        headerTitleLabel.font = Fonts.semibold17
        headerTitleLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(headerTitleLabel)

        headerSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerSubtitleLabel.text = "Upload a screenshot or product photo. You’ll fill in the details on the next screen."
        headerSubtitleLabel.font = Fonts.regular14
        headerSubtitleLabel.textColor = Colors.subtleGrayText
        headerSubtitleLabel.numberOfLines = 0
        contentView.addSubview(headerSubtitleLabel)
    }

    private func setupPhotoDrop() {
        photoDropControl.translatesAutoresizingMaskIntoConstraints = false
        photoDropControl.backgroundColor = Colors.newItemPhotoCardBackground
        photoDropControl.layer.cornerRadius = fieldCornerRadius
        photoDropControl.clipsToBounds = true
        photoDropControl.addTarget(self, action: #selector(choosePhotoTapped), for: .touchUpInside)
        contentView.addSubview(photoDropControl)

        photoDropBorderLayer.strokeColor = Colors.primaryBlue.cgColor
        photoDropBorderLayer.fillColor = UIColor.clear.cgColor
        photoDropBorderLayer.lineWidth = 2
        photoDropBorderLayer.lineDashPattern = [8, 6]
        photoDropControl.layer.addSublayer(photoDropBorderLayer)

        dropIconView.translatesAutoresizingMaskIntoConstraints = false
        dropIconView.image = UIImage(systemName: "camera.fill")
        dropIconView.tintColor = Colors.primaryBlue
        dropIconView.contentMode = .scaleAspectFit
        dropIconView.isUserInteractionEnabled = false
        photoDropControl.addSubview(dropIconView)

        dropTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dropTitleLabel.text = "Choose a photo"
        dropTitleLabel.font = Fonts.semibold16
        dropTitleLabel.textColor = Colors.primaryGrayText
        dropTitleLabel.textAlignment = .center
        dropTitleLabel.isUserInteractionEnabled = false
        photoDropControl.addSubview(dropTitleLabel)

        dropSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dropSubtitleLabel.text = "Take a photo or select from your library."
        dropSubtitleLabel.font = Fonts.regular13
        dropSubtitleLabel.textColor = Colors.subtleGrayText
        dropSubtitleLabel.textAlignment = .center
        dropSubtitleLabel.numberOfLines = 0
        dropSubtitleLabel.isUserInteractionEnabled = false
        photoDropControl.addSubview(dropSubtitleLabel)

        photoPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        photoPreviewImageView.contentMode = .scaleAspectFill
        photoPreviewImageView.clipsToBounds = true
        photoPreviewImageView.isHidden = true
        photoPreviewImageView.isUserInteractionEnabled = false
        photoDropControl.addSubview(photoPreviewImageView)

        NSLayoutConstraint.activate([
            dropIconView.centerXAnchor.constraint(equalTo: photoDropControl.centerXAnchor),
            dropIconView.centerYAnchor.constraint(equalTo: photoDropControl.centerYAnchor, constant: -28),
            dropIconView.widthAnchor.constraint(equalToConstant: 36),
            dropIconView.heightAnchor.constraint(equalToConstant: 36),

            dropTitleLabel.topAnchor.constraint(equalTo: dropIconView.bottomAnchor, constant: Layout.spacingM),
            dropTitleLabel.leadingAnchor.constraint(equalTo: photoDropControl.leadingAnchor, constant: Layout.spacingL),
            dropTitleLabel.trailingAnchor.constraint(equalTo: photoDropControl.trailingAnchor, constant: -Layout.spacingL),

            dropSubtitleLabel.topAnchor.constraint(equalTo: dropTitleLabel.bottomAnchor, constant: Layout.spacingXS),
            dropSubtitleLabel.leadingAnchor.constraint(equalTo: photoDropControl.leadingAnchor, constant: Layout.spacingL),
            dropSubtitleLabel.trailingAnchor.constraint(equalTo: photoDropControl.trailingAnchor, constant: -Layout.spacingL),

            photoPreviewImageView.topAnchor.constraint(equalTo: photoDropControl.topAnchor),
            photoPreviewImageView.leadingAnchor.constraint(equalTo: photoDropControl.leadingAnchor),
            photoPreviewImageView.trailingAnchor.constraint(equalTo: photoDropControl.trailingAnchor),
            photoPreviewImageView.bottomAnchor.constraint(equalTo: photoDropControl.bottomAnchor)
        ])
    }

    private func setupContinueButton() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue to Review", for: .normal)
        if let sparkles = UIImage(systemName: "sparkles") {
            continueButton.setImage(sparkles, for: .normal)
            continueButton.tintColor = .white
            continueButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        }
        Buttons.buttonPinkStyle(button: continueButton)
        continueButton.layer.cornerRadius = 14
        continueButton.titleLabel?.font = Fonts.semibold16
        continueButton.addTarget(self, action: #selector(continueToReviewTapped), for: .touchUpInside)
        contentView.addSubview(continueButton)
    }

    private func updateDropBorderPath() {
        let inset: CGFloat = 1
        let rect = photoDropControl.bounds.insetBy(dx: inset, dy: inset)
        photoDropBorderLayer.frame = photoDropControl.bounds
        photoDropBorderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: fieldCornerRadius - inset).cgPath
    }

    private func updatePhotoUI() {
        let hasPhoto = draft.localImage != nil
        photoPreviewImageView.image = draft.localImage
        photoPreviewImageView.isHidden = !hasPhoto
        dropIconView.isHidden = hasPhoto
        dropTitleLabel.isHidden = hasPhoto
        dropSubtitleLabel.isHidden = hasPhoto
        photoDropBorderLayer.isHidden = hasPhoto

        if hasPhoto {
            dropTitleLabel.text = "Change photo"
        } else {
            dropTitleLabel.text = "Choose a photo"
        }
    }

    // DRAFT
    func makeDraft() -> ItemDraft {
        draft
    }

    // ACTIONS
    @objc private func choosePhotoTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @objc private func continueToReviewTapped() {
        guard draft.localImage != nil else {
            photoDropBorderLayer.strokeColor = Colors.primaryPink.cgColor
            return
        }
        photoDropBorderLayer.strokeColor = Colors.primaryBlue.cgColor

        let review = ReviewItemViewController()
        review.draft = makeDraft()
        review.listName = listName
        navigationController?.pushViewController(review, animated: true)
    }
}

extension AddItemFromPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        draft.localImage = image
        updatePhotoUI()
        photoDropBorderLayer.strokeColor = Colors.primaryBlue.cgColor
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
