//
//  NewItemViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/15/26.
//

import UIKit


final class NewItemViewController: UIViewController {

    // LOGIC
    var groupID: Int = 0

    // UI COMPONENTS
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let cardsStack = UIStackView()
    private let pasteCard = NewItemOptionView()
    private let photoCard = NewItemOptionView()
    private let manualCard = NewItemOptionView()

    private let privacyInfoView = UIView()
    private let privacyIconView = UIImageView()
    private let privacyLabel = UILabel()

    // MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        setupNavigation()
        setupViews()
        configureCards()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "NewItemViewController")
    }

    // LAYOUT
    private func setupNavigation() {
        title = "New Item"
        navigationItem.largeTitleDisplayMode = .never

        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeTapped)
        )
        closeButton.tintColor = Colors.primaryPink
        navigationItem.leftBarButtonItem = closeButton
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "How do you want\nto add this item?"
        titleLabel.font = Fonts.newItemIntroTitleFont
        titleLabel.textColor = Colors.primaryText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "We’ll pull out the item details for you."
        subtitleLabel.font = Fonts.newItemIntroSubtitleFont
        subtitleLabel.textColor = Colors.secondaryText
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)

        cardsStack.translatesAutoresizingMaskIntoConstraints = false
        cardsStack.axis = .vertical
        cardsStack.spacing = Layout.spacingL
        cardsStack.alignment = .fill
        contentView.addSubview(cardsStack)

        cardsStack.addArrangedSubview(pasteCard)
        cardsStack.addArrangedSubview(photoCard)
        cardsStack.addArrangedSubview(manualCard)

        setupPrivacyInfoView()

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

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXXL),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingXXL),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingXXL),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.spacingM),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingXXL),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingXXL),

            cardsStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Layout.spacingXXL),
            cardsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingXXL),
            cardsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingXXL),

            privacyInfoView.topAnchor.constraint(equalTo: cardsStack.bottomAnchor, constant: Layout.spacingXXL),
            privacyInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingXXL),
            privacyInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingXXL),
            privacyInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXL)
        ])
    }

    private func setupPrivacyInfoView() {
        privacyInfoView.translatesAutoresizingMaskIntoConstraints = false
        privacyInfoView.backgroundColor = Colors.newItemInfoBackground
        privacyInfoView.layer.cornerRadius = 14
        privacyInfoView.clipsToBounds = true
        contentView.addSubview(privacyInfoView)

        privacyIconView.translatesAutoresizingMaskIntoConstraints = false
        privacyIconView.image = UIImage(systemName: "lock.fill")
        privacyIconView.tintColor = Colors.secondaryText
        privacyIconView.contentMode = .scaleAspectFit
        privacyInfoView.addSubview(privacyIconView)

        privacyLabel.translatesAutoresizingMaskIntoConstraints = false
        privacyLabel.text = "Nothing is posted yet. You’ll review\neverything before adding to your list."
        privacyLabel.font = Fonts.newItemInfoFont
        privacyLabel.textColor = Colors.secondaryText
        privacyLabel.numberOfLines = 0
        privacyInfoView.addSubview(privacyLabel)

        NSLayoutConstraint.activate([
            privacyIconView.leadingAnchor.constraint(equalTo: privacyInfoView.leadingAnchor, constant: Layout.spacingL),
            privacyIconView.centerYAnchor.constraint(equalTo: privacyInfoView.centerYAnchor),
            privacyIconView.widthAnchor.constraint(equalToConstant: 16),
            privacyIconView.heightAnchor.constraint(equalToConstant: 16),

            privacyLabel.topAnchor.constraint(equalTo: privacyInfoView.topAnchor, constant: Layout.spacingL),
            privacyLabel.leadingAnchor.constraint(equalTo: privacyIconView.trailingAnchor, constant: Layout.spacingS),
            privacyLabel.trailingAnchor.constraint(equalTo: privacyInfoView.trailingAnchor, constant: -Layout.spacingL),
            privacyLabel.bottomAnchor.constraint(equalTo: privacyInfoView.bottomAnchor, constant: -Layout.spacingL)
        ])
    }

    private func configureCards() {
        pasteCard.configure(
            title: "Paste item details",
            subtitle: "Paste a product link, description,\nor anything you have.",
            iconName: "link",
            iconTintColor: Colors.primaryPink,
            iconBackgroundColor: Colors.newItemPasteIconBackground,
            backgroundColor: Colors.newItemPasteCardBackground,
            action: { [weak self] in self?.openPaste() }
        )

        photoCard.configure(
            title: "Add a photo",
            subtitle: "Upload a screenshot or photo\nand we’ll extract the details.",
            iconName: "camera",
            iconTintColor: Colors.primaryBlue,
            iconBackgroundColor: Colors.newItemPhotoIconBackground,
            backgroundColor: Colors.newItemPhotoCardBackground,
            action: { [weak self] in self?.openPhoto() }
        )

        manualCard.configure(
            title: "Enter manually",
            subtitle: "Fill everything out yourself\nstep by step.",
            iconName: "pencil",
            iconTintColor: Colors.primaryText,
            iconBackgroundColor: Colors.newItemManualIconBackground,
            backgroundColor: Colors.newItemManualCardBackground,
            action: { [weak self] in self?.openManual() }
        )
    }

    // ACTIONS
    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    private func openPaste() {
        let vc = AddItemFromTextViewController()
        vc.groupID = groupID
        navigationController?.pushViewController(vc, animated: true)
    }

    private func openPhoto() {
        let vc = AddItemFromPhotoViewController()
        vc.groupID = groupID
        navigationController?.pushViewController(vc, animated: true)
    }

    private func openManual() {
        let vc = AddItemManuallyViewController()
        vc.groupID = groupID
        navigationController?.pushViewController(vc, animated: true)
    }
}
