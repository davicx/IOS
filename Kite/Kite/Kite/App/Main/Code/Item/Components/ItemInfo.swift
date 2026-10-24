//
//  ItemInfo.swift
//  Kite
//
//  Created by David Vasquez on 8/29/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

// Right column of ItemBody — title, price, (tags later), description, Purchase.
final class ItemInfo: UIView {

    //UI COMPONENTS
    private let itemTitleView = UIView()
    private let itemTitleLabel = UILabel()

    private let itemPriceView = UIView()
    private let itemPriceLabel = UILabel()

    // Tags slot — height 0 for now; touches price so tags can sit flush later.
    private let itemTagsView = UIView()

    private let itemDescriptionView = UIView()
    private let itemDescriptionLabel = UILabel()

    private let itemPurchaseView = UIView()
    private let purchaseButton = UIButton(type: .system)

    private var post: Post?
    private var buttonState: PurchaseButtonState = .purchase
    var onPurchaseTapped: ((Post, PurchaseButtonState) -> Void)?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        setupTitle()
        setupPrice()
        setupTagsSlot()
        setupDescription()
        setupPurchase()
        activateLayout()
    }

    //LAYOUT and UI
    private func setupTitle() {
        itemTitleView.translatesAutoresizingMaskIntoConstraints = false
        itemTitleView.backgroundColor = .clear
        addSubview(itemTitleView)

        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.font = Fonts.itemNameFont
        itemTitleLabel.textColor = Colors.primaryGrayText
        itemTitleLabel.numberOfLines = 2
        itemTitleLabel.lineBreakMode = .byTruncatingTail
        itemTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        itemTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        itemTitleView.addSubview(itemTitleLabel)

        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: itemTitleView.topAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),
            itemTitleLabel.bottomAnchor.constraint(equalTo: itemTitleView.bottomAnchor)
        ])
    }

    private func setupPrice() {
        itemPriceView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceView.backgroundColor = .clear
        addSubview(itemPriceView)

        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = Fonts.semibold15
        itemPriceLabel.textColor = Colors.primaryGrayText
        itemPriceLabel.numberOfLines = 1
        itemPriceLabel.lineBreakMode = .byTruncatingTail
        itemPriceLabel.setContentHuggingPriority(.required, for: .vertical)
        itemPriceLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        itemPriceView.addSubview(itemPriceLabel)

        NSLayoutConstraint.activate([
            itemPriceLabel.topAnchor.constraint(equalTo: itemPriceView.topAnchor),
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemPriceView.leadingAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemPriceView.trailingAnchor),
            itemPriceLabel.bottomAnchor.constraint(equalTo: itemPriceView.bottomAnchor)
        ])
    }

    private func setupTagsSlot() {
        itemTagsView.translatesAutoresizingMaskIntoConstraints = false
        itemTagsView.backgroundColor = .clear
        itemTagsView.isHidden = true
        addSubview(itemTagsView)
    }

    private func setupDescription() {
        itemDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionView.backgroundColor = .clear
        addSubview(itemDescriptionView)

        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.font = Fonts.itemDescriptionFont
        itemDescriptionLabel.textColor = Colors.primaryGrayText
        itemDescriptionLabel.numberOfLines = 3
        itemDescriptionLabel.lineBreakMode = .byTruncatingTail
        itemDescriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        itemDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        itemDescriptionView.addSubview(itemDescriptionLabel)

        NSLayoutConstraint.activate([
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemDescriptionView.topAnchor),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemDescriptionView.leadingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemDescriptionView.trailingAnchor),
            itemDescriptionLabel.bottomAnchor.constraint(equalTo: itemDescriptionView.bottomAnchor)
        ])
    }

    private func setupPurchase() {
        itemPurchaseView.translatesAutoresizingMaskIntoConstraints = false
        itemPurchaseView.backgroundColor = .clear
        addSubview(itemPurchaseView)

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        purchaseButton.imageView?.contentMode = .scaleAspectFit
        purchaseButton.semanticContentAttribute = .forceLeftToRight
        purchaseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        Buttons.wishlistPurchaseButtonStyle(button: purchaseButton)
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        itemPurchaseView.addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: itemPurchaseView.topAnchor),
            purchaseButton.leadingAnchor.constraint(equalTo: itemPurchaseView.leadingAnchor),
            purchaseButton.trailingAnchor.constraint(equalTo: itemPurchaseView.trailingAnchor),
            purchaseButton.bottomAnchor.constraint(equalTo: itemPurchaseView.bottomAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    private func activateLayout() {
        let inset = Layout.spacingM
        let topInset = inset - 6

        NSLayoutConstraint.activate([
            // Title
            itemTitleView.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            itemTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            itemTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),

            // Price — tight under title
            itemPriceView.topAnchor.constraint(equalTo: itemTitleView.bottomAnchor, constant: Layout.spacingXS),
            itemPriceView.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor),
            itemPriceView.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),

            // Tags slot — touches price (0 gap); collapsed until tags ship
            itemTagsView.topAnchor.constraint(equalTo: itemPriceView.bottomAnchor),
            itemTagsView.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor),
            itemTagsView.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),
            itemTagsView.heightAnchor.constraint(equalToConstant: 0),

            // Description under tags slot
            itemDescriptionView.topAnchor.constraint(equalTo: itemTagsView.bottomAnchor, constant: Layout.spacingS),
            itemDescriptionView.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor),
            itemDescriptionView.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),

            // Purchase pinned to bottom of column (−4pt vs prior spacingM)
            itemPurchaseView.leadingAnchor.constraint(equalTo: itemTitleView.leadingAnchor),
            itemPurchaseView.trailingAnchor.constraint(equalTo: itemTitleView.trailingAnchor),
            itemPurchaseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            itemPurchaseView.topAnchor.constraint(
                greaterThanOrEqualTo: itemDescriptionView.bottomAnchor,
                constant: Layout.spacingS
            )
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

        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemTitleLabel.text = (name?.isEmpty == false) ? name : "Untitled"

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
            // Q5: hide button, keep layout (do not collapse purchase row)
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
