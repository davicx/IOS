// Backup of the live Item card before the Option C spacing pass.
// Commented out so this copy is not compiled.

/*
//
//  ItemInfo.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

enum ItemPurchaseStyle {
    case pinkOutline
    case pinkFull
}

final class ItemInfo: UIView {

    //UI COMPONENTS
    let mediaRegion = UIView()
    let productSummary = UIView()

    private let productImageView = UIImageView()
    private let itemTitleLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let purchaseButton = UIButton(type: .system)
    private let textStack = UIStackView()

    private var titleToButton: NSLayoutConstraint!
    private var titleToEdge: NSLayoutConstraint!

    private var post: Post?
    private var buttonState: PurchaseButtonState = .purchase
    var onPurchaseTapped: ((Post, PurchaseButtonState) -> Void)?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        mediaRegion.translatesAutoresizingMaskIntoConstraints = false
        mediaRegion.backgroundColor = Colors.surfaceBackground

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .clear
        mediaRegion.addSubview(productImageView)

        productSummary.translatesAutoresizingMaskIntoConstraints = false
        productSummary.backgroundColor = Colors.screenBackground

        itemTitleLabel.font = Fonts.itemNameFont
        itemTitleLabel.textColor = Colors.primaryText
        itemTitleLabel.numberOfLines = 2
        itemTitleLabel.lineBreakMode = .byTruncatingTail

        itemPriceLabel.font = Fonts.regular14
        itemPriceLabel.textColor = Colors.secondaryText
        itemPriceLabel.numberOfLines = 1

        itemDescriptionLabel.font = Fonts.itemDescriptionFont
        itemDescriptionLabel.textColor = Colors.secondaryText
        itemDescriptionLabel.numberOfLines = 0
        itemDescriptionLabel.isHidden = true

        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = Layout.spacingXS
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(itemTitleLabel)
        textStack.addArrangedSubview(itemPriceLabel)
        productSummary.addSubview(textStack)

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        purchaseButton.setContentHuggingPriority(.required, for: .horizontal)
        purchaseButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        productSummary.addSubview(purchaseButton)

        titleToButton = textStack.trailingAnchor.constraint(equalTo: purchaseButton.leadingAnchor, constant: -Layout.spacingM)
        titleToEdge = textStack.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor, constant: -Layout.spacingM)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: mediaRegion.topAnchor, constant: Layout.spacingS),
            productImageView.leadingAnchor.constraint(equalTo: mediaRegion.leadingAnchor, constant: Layout.spacingS),
            productImageView.trailingAnchor.constraint(equalTo: mediaRegion.trailingAnchor, constant: -Layout.spacingS),
            productImageView.bottomAnchor.constraint(equalTo: mediaRegion.bottomAnchor, constant: -Layout.spacingS),

            textStack.topAnchor.constraint(equalTo: productSummary.topAnchor, constant: Layout.spacingM),
            textStack.leadingAnchor.constraint(equalTo: productSummary.leadingAnchor, constant: Layout.spacingM),
            textStack.bottomAnchor.constraint(equalTo: productSummary.bottomAnchor, constant: -Layout.spacingM),
            titleToButton,

            purchaseButton.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor, constant: -Layout.spacingM),
            purchaseButton.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 44),
            purchaseButton.topAnchor.constraint(greaterThanOrEqualTo: productSummary.topAnchor, constant: Layout.spacingS),
            purchaseButton.bottomAnchor.constraint(lessThanOrEqualTo: productSummary.bottomAnchor, constant: -Layout.spacingS)
        ])
    }

    //ACTIONS
    @objc private func purchaseTapped() {
        guard let post else { return }
        onPurchaseTapped?(post, buttonState)
    }

    //FUNCTIONS
    func prepareForReuse() {
        post = nil
        productImageView.image = nil
        itemTitleLabel.text = nil
        itemPriceLabel.text = nil
        itemDescriptionLabel.text = nil
    }

    func configure(with post: Post, purchaseStyle: ItemPurchaseStyle) {
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
        itemPriceLabel.isHidden = itemPriceLabel.text == nil

        let description = post.itemDescription?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemDescriptionLabel.text = (description?.isEmpty == false) ? description : nil

        applyPurchaseButtonState(
            purchaseButtonState(post: post, currentUser: PostDataController.shared.currentUser),
            purchaseStyle: purchaseStyle
        )
    }

    private func applyPurchaseButtonState(_ state: PurchaseButtonState, purchaseStyle: ItemPurchaseStyle) {
        buttonState = state
        let showsButton = state != .hidden
        purchaseButton.isHidden = !showsButton
        titleToButton.isActive = showsButton
        titleToEdge.isActive = !showsButton

        switch state {
        case .hidden:
            break

        case .purchase:
            if purchaseStyle == .pinkFull {
                Buttons.pinkFullStyle(button: purchaseButton)
            } else {
                Buttons.pinkOutlineStyle(button: purchaseButton)
            }
            purchaseButton.setTitle("Purchase", for: .normal)
            purchaseButton.setImage(nil, for: .normal)

        case .youPurchased:
            Buttons.buttonGrayStyle(button: purchaseButton)
            purchaseButton.setTitle("You Purchased", for: .normal)
            purchaseButton.setImage(nil, for: .normal)

        case .purchased:
            Buttons.buttonGrayStyle(button: purchaseButton)
            purchaseButton.setTitle("Purchased", for: .normal)
            purchaseButton.setImage(nil, for: .normal)
        }
    }
}

*/
