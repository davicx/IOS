//
//  ItemInfoOriginal.swift
//  Kite
//
//  Created by David Vasquez on 10/4/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemInfoOriginal: UIView {

    //UI COMPONENTS
    private let menuButton = UIButton(type: .system)
    private let productImageView = UIImageView()
    private let itemTitleLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let purchaseButton = UIButton(type: .system)
    private let itemDivider = UIView()

    private var post: Post?
    private var buttonState: PurchaseButtonState = .purchase
    var onPurchaseTapped: ((Post, PurchaseButtonState) -> Void)?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        menuButton.tintColor = Colors.subtleGrayText
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        menuButton.accessibilityLabel = "More"
        addSubview(menuButton)
        setupMenu()

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .clear
        productImageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        productImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        productImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        productImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addSubview(productImageView)

        LabelStyle.itemName(itemTitleLabel)
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.textColor = Colors.primaryGrayText
        itemTitleLabel.numberOfLines = 1
        itemTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(itemTitleLabel)

        menuButton.setContentHuggingPriority(.required, for: .horizontal)
        menuButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        LabelStyle.itemPrice(itemPriceLabel)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.textColor = Colors.primaryGrayText
        addSubview(itemPriceLabel)

        LabelStyle.itemDescription(itemDescriptionLabel)
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.textColor = Colors.primaryGrayText
        itemDescriptionLabel.numberOfLines = 3
        itemDescriptionLabel.adjustsFontSizeToFitWidth = false
        addSubview(itemDescriptionLabel)

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        purchaseButton.imageView?.contentMode = .scaleAspectFit
        purchaseButton.semanticContentAttribute = .forceLeftToRight
        purchaseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        purchaseButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        purchaseButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        Buttons.wishlistPurchaseButtonStyle(button: purchaseButton)
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        addSubview(purchaseButton)

        itemDivider.translatesAutoresizingMaskIntoConstraints = false
        itemDivider.backgroundColor = UIColor(hex: "#D0D0D0")
        addSubview(itemDivider)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingS),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingS),
            productImageView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor, constant: -Layout.spacingS),
            productImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44),

            itemTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            itemTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingS),
            menuButton.centerYAnchor.constraint(equalTo: itemTitleLabel.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 32),
            menuButton.heightAnchor.constraint(equalToConstant: 32),

            itemPriceLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: Layout.spacingXS),
            itemPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingS),

            itemDescriptionLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: Layout.spacingS),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingS),

            purchaseButton.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: Layout.spacingM + 12),
            purchaseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            purchaseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            purchaseButton.bottomAnchor.constraint(equalTo: itemDivider.topAnchor, constant: -Layout.spacingM),
            purchaseButton.heightAnchor.constraint(equalToConstant: 36),

            itemDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemDivider.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemDivider.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemDivider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }

    private func setupMenu() {
        let editAction = UIAction(
            title: "Edit",
            image: UIImage(systemName: "pencil")
        ) { [weak self] _ in
            self?.editTapped()
        }

        let deleteAction = UIAction(
            title: "Delete",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.confirmDelete()
        }

        menuButton.menu = UIMenu(children: [editAction, deleteAction])
        menuButton.showsMenuAsPrimaryAction = true
    }

    //ACTIONS
    private func editTapped() {
        print("edit")
    }

    private func confirmDelete() {
        guard let viewController = findViewController() else { return }

        let name = post?.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        let itemName = (name?.isEmpty == false) ? name! : (post?.postCaption ?? "")
        let label = itemName.isEmpty ? "this item" : "\"\(itemName)\""
        let alert = UIAlertController(
            title: "Delete Item?",
            message: "Are you sure you want to delete \(label)? This cannot be undone.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteItem()
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewController.present(alert, animated: true)
        }
    }

    private func deleteItem() {
        guard let postID = post?.postID else {
            print("Delete Item: missing postID")
            return
        }

        Task {
            let success = await PostLogic.shared.deletePost(postID: postID)
            await MainActor.run {
                if !success {
                    self.showDeleteFailedAlert()
                }
            }
        }
    }

    private func showDeleteFailedAlert() {
        guard let viewController = findViewController() else { return }
        let alert = UIAlertController(
            title: "Couldn’t delete item",
            message: "Something went wrong. Please try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }

    @objc private func purchaseTapped() {
        guard let post else { return }
        onPurchaseTapped?(post, buttonState)
    }

    //FUNCTIONS
    func configure(with post: Post) {
        self.post = post

        if let image = post.postImageData, image.size.width > 0 {
            productImageView.image = image
        } else {
            productImageView.image = nil
        }

        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemTitleLabel.text = (name?.isEmpty == false) ? name : "Untitled"
        productImageView.accessibilityLabel = itemTitleLabel.text

        let price = post.itemPrice?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemPriceLabel.text = (price?.isEmpty == false) ? price : nil

        let description = post.itemDescription?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemDescriptionLabel.text = (description?.isEmpty == false) ? description : nil

        applyPurchaseButtonState(
            purchaseButtonState(post: post, currentUser: PostDataController.shared.currentUser)
        )
    }

    private func applyPurchaseButtonState(_ state: PurchaseButtonState) {
        buttonState = state

        switch state {
        case .hidden:
            purchaseButton.isHidden = true

        case .purchase:
            purchaseButton.isHidden = false
            purchaseButton.setTitle("Purchase", for: .normal)
            purchaseButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
            purchaseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
            Buttons.wishlistPurchaseButtonStyle(button: purchaseButton)

        case .youPurchased:
            purchaseButton.isHidden = false
            purchaseButton.setTitle("You Purchased", for: .normal)
            purchaseButton.setImage(nil, for: .normal)
            purchaseButton.imageEdgeInsets = .zero
            Buttons.buttonGrayStyle(button: purchaseButton)

        case .purchased:
            purchaseButton.isHidden = false
            purchaseButton.setTitle("Purchased", for: .normal)
            purchaseButton.setImage(nil, for: .normal)
            purchaseButton.imageEdgeInsets = .zero
            Buttons.buttonGrayStyle(button: purchaseButton)
        }
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let viewController = next as? UIViewController {
                return viewController
            }
            responder = next
        }
        return nil
    }
}
