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
    private let linkButton = UIButton(type: .system)
    private let textStack = UIStackView()
    private let summaryRow = UIView()

    private var titleToButton: NSLayoutConstraint!
    private var titleToEdge: NSLayoutConstraint!
    private var linkTop: NSLayoutConstraint!
    private var linkHeight: NSLayoutConstraint!
    private var rowBottom: NSLayoutConstraint!
    private var linkURL: String?

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
        mediaRegion.backgroundColor = Colors.screenBackground

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .clear
        mediaRegion.addSubview(productImageView)

        productSummary.translatesAutoresizingMaskIntoConstraints = false
        productSummary.backgroundColor = UIColor(hex: "#E6E6EA")
        productSummary.layer.cornerRadius = 12
        productSummary.clipsToBounds = true

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

        summaryRow.translatesAutoresizingMaskIntoConstraints = false
        productSummary.addSubview(summaryRow)
        summaryRow.addSubview(textStack)

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        purchaseButton.setContentHuggingPriority(.required, for: .horizontal)
        purchaseButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        summaryRow.addSubview(purchaseButton)

        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.tintColor = Colors.primaryBlue
        linkButton.setTitleColor(Colors.primaryBlue, for: .normal)
        linkButton.titleLabel?.font = Fonts.itemLinkFont
        linkButton.titleLabel?.lineBreakMode = .byTruncatingTail
        linkButton.contentHorizontalAlignment = .leading
        linkButton.titleLabel?.numberOfLines = 1
        linkButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        linkButton.setContentHuggingPriority(.defaultLow, for: .vertical)
        linkButton.setImage(UIImage(systemName: "link"), for: .normal)
        linkButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
        linkButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        linkButton.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        linkButton.isHidden = true
        productSummary.addSubview(linkButton)

        titleToButton = textStack.trailingAnchor.constraint(equalTo: purchaseButton.leadingAnchor, constant: -Layout.spacingM)
        titleToEdge = textStack.trailingAnchor.constraint(equalTo: summaryRow.trailingAnchor, constant: 0)
        linkTop = linkButton.topAnchor.constraint(equalTo: summaryRow.bottomAnchor, constant: 0)
        linkHeight = linkButton.heightAnchor.constraint(equalToConstant: 0)
        rowBottom = summaryRow.bottomAnchor.constraint(equalTo: productSummary.bottomAnchor, constant: -Layout.spacingM)
        rowBottom.isActive = true

        let textBottom = textStack.bottomAnchor.constraint(equalTo: summaryRow.bottomAnchor)
        textBottom.priority = .defaultHigh
        textBottom.isActive = true

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: mediaRegion.topAnchor, constant: Layout.spacingS),
            productImageView.leadingAnchor.constraint(equalTo: mediaRegion.leadingAnchor, constant: Layout.spacingS),
            productImageView.trailingAnchor.constraint(equalTo: mediaRegion.trailingAnchor, constant: -Layout.spacingS),
            productImageView.bottomAnchor.constraint(equalTo: mediaRegion.bottomAnchor),

            summaryRow.topAnchor.constraint(equalTo: productSummary.topAnchor, constant: Layout.spacingM),
            summaryRow.leadingAnchor.constraint(equalTo: productSummary.leadingAnchor, constant: Layout.spacingM),
            summaryRow.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor, constant: -Layout.spacingM),
            summaryRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

            textStack.topAnchor.constraint(equalTo: summaryRow.topAnchor),
            textStack.leadingAnchor.constraint(equalTo: summaryRow.leadingAnchor),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: summaryRow.bottomAnchor),
            titleToButton,

            purchaseButton.trailingAnchor.constraint(equalTo: summaryRow.trailingAnchor),
            purchaseButton.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 44),
            purchaseButton.topAnchor.constraint(greaterThanOrEqualTo: summaryRow.topAnchor),
            purchaseButton.bottomAnchor.constraint(lessThanOrEqualTo: summaryRow.bottomAnchor),

            linkTop,
            linkButton.leadingAnchor.constraint(equalTo: productSummary.leadingAnchor, constant: Layout.spacingM),
            linkButton.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor, constant: -Layout.spacingM),
            linkButton.bottomAnchor.constraint(equalTo: productSummary.bottomAnchor, constant: -Layout.spacingM),
            linkHeight
        ])
    }

    //ACTIONS
    @objc private func purchaseTapped() {
        guard let post else { return }
        onPurchaseTapped?(post, buttonState)
    }

    @objc private func linkTapped() {
        guard let destination = openableURL(from: linkURL) else { return }
        UIApplication.shared.open(destination)
    }

    //FUNCTIONS
    func prepareForReuse() {
        post = nil
        productImageView.image = nil
        itemTitleLabel.text = nil
        itemPriceLabel.text = nil
        itemDescriptionLabel.text = nil
        linkURL = nil
        linkButton.setTitle(nil, for: .normal)
        linkButton.isHidden = true
        showLinkRow(false)
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

        let linkTitle = displayLinkTitle(name: post.itemLinkName, url: post.itemLink)
        linkURL = usableLink(post.itemLink)
        linkButton.setTitle(linkTitle, for: .normal)
        linkButton.isHidden = linkTitle == nil
        showLinkRow(linkTitle != nil)

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

    private func showLinkRow(_ show: Bool) {
        linkTop.constant = show ? Layout.spacingS : 0
        linkHeight.constant = show ? 32 : 0
        linkButton.isHidden = !show
        rowBottom.isActive = !show
    }

    private func usableLink(_ raw: String?) -> String? {
        let trimmed = raw?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmed.isEmpty { return nil }
        if trimmed.caseInsensitiveCompare("item_link") == .orderedSame { return nil }
        return trimmed
    }

    private func displayLinkTitle(name: String?, url: String?) -> String? {
        guard usableLink(url) != nil else { return nil }
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let label = trimmedName.isEmpty ? hostLabel(from: url ?? "") : trimmedName
        guard !label.isEmpty else { return nil }
        return "\(label) ↗"
    }

    private func hostLabel(from raw: String) -> String {
        guard let host = openableURL(from: raw)?.host?.lowercased(), !host.isEmpty else { return "" }
        if host.hasPrefix("www.") {
            return String(host.dropFirst(4))
        }
        return host
    }

    private func openableURL(from raw: String?) -> URL? {
        let trimmed = raw?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmed.isEmpty { return nil }
        let candidate = trimmed.lowercased().hasPrefix("http") ? trimmed : "https://\(trimmed)"
        return URL(string: candidate)
    }
}
