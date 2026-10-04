//
//  ItemInfo.swift
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

final class ItemInfo: UIView {

    //UI COMPONENTS
    private let productImageView = UIImageView()
    private let itemTitleLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let purchaseButton = UIButton(type: .system)

    private var post: Post?
    private var buttonState: PurchaseButtonState = .purchase
    var onPurchaseTapped: ((Post, PurchaseButtonState) -> Void)?

    private let panelCornerRadius: CGFloat = 12

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#F0F1F3")
        layer.cornerRadius = panelCornerRadius
        clipsToBounds = true
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
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
        addSubview(itemTitleLabel)

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

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingS),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingS),
            productImageView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor, constant: -Layout.spacingS),
            productImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44),

            itemTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingM),
            itemTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Layout.spacingM),
            itemTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),

            itemPriceLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: Layout.spacingXS),
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor),

            itemDescriptionLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: Layout.spacingS),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor),

            purchaseButton.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: Layout.spacingM),
            purchaseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            purchaseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),
            purchaseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),
            purchaseButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    //ACTIONS
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
}
