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
    private let accentBar = UIView()
    private let headerRule = UIView()
    private let column = UIStackView()
    private let itemTitleLabel = UILabel()
    private let metaRow = UIStackView()
    private let itemPriceLabel = UILabel()
    private let purchaseHolder = UIView()
    private let purchaseButton = UIButton(type: .system)
    private let linkButton = UIButton(type: .system)
    private let overflowMenu = ItemOverflowMenu()

    private var purchaseHeight: NSLayoutConstraint!
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

        let imageTop = productImageView.topAnchor.constraint(equalTo: mediaRegion.topAnchor, constant: Layout.spacingS)
        imageTop.priority = UILayoutPriority(999)

        productSummary.translatesAutoresizingMaskIntoConstraints = false
        productSummary.backgroundColor = Colors.screenBackground
        productSummary.clipsToBounds = true

        accentBar.translatesAutoresizingMaskIntoConstraints = false
        accentBar.backgroundColor = Colors.primaryBlue
        accentBar.layer.cornerRadius = 1.5
        productSummary.addSubview(accentBar)

        headerRule.translatesAutoresizingMaskIntoConstraints = false
        headerRule.backgroundColor = Colors.primaryBlue
        productSummary.addSubview(headerRule)

        itemTitleLabel.font = Fonts.itemNameFont
        itemTitleLabel.textColor = Colors.primaryText
        itemTitleLabel.numberOfLines = 1
        itemTitleLabel.lineBreakMode = .byTruncatingTail

        linkButton.tintColor = Colors.primaryBlue
        linkButton.setTitleColor(Colors.primaryBlue, for: .normal)
        linkButton.titleLabel?.font = Fonts.itemLinkFont
        linkButton.titleLabel?.lineBreakMode = .byTruncatingTail
        linkButton.contentHorizontalAlignment = .leading
        linkButton.titleLabel?.numberOfLines = 1
        linkButton.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        linkButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        linkButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        linkButton.isHidden = true

        itemPriceLabel.font = Fonts.regular14
        itemPriceLabel.textColor = Colors.secondaryText
        itemPriceLabel.numberOfLines = 1
        itemPriceLabel.setContentHuggingPriority(.required, for: .horizontal)
        itemPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        itemPriceLabel.isHidden = true

        let metaSpacer = UIView()
        metaSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        metaSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        metaRow.axis = .horizontal
        metaRow.alignment = .center
        metaRow.spacing = Layout.spacingS
        metaRow.addArrangedSubview(linkButton)
        metaRow.addArrangedSubview(metaSpacer)
        metaRow.addArrangedSubview(itemPriceLabel)
        metaRow.isHidden = true

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        purchaseButton.setContentHuggingPriority(.required, for: .horizontal)
        purchaseButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        purchaseHolder.translatesAutoresizingMaskIntoConstraints = false
        purchaseHolder.addSubview(purchaseButton)
        purchaseHolder.isHidden = true

        purchaseHeight = purchaseButton.heightAnchor.constraint(equalToConstant: 44)
        purchaseHeight.priority = UILayoutPriority(999)

        column.axis = .vertical
        column.alignment = .fill
        column.spacing = Layout.spacingS
        column.translatesAutoresizingMaskIntoConstraints = false
        column.addArrangedSubview(itemTitleLabel)
        column.addArrangedSubview(metaRow)
        column.addArrangedSubview(purchaseHolder)
        column.setCustomSpacing(2, after: itemTitleLabel)
        productSummary.addSubview(column)
        productSummary.addSubview(overflowMenu.button)

        let menuHeight = overflowMenu.button.heightAnchor.constraint(equalToConstant: 44)
        menuHeight.priority = UILayoutPriority(999)

        let columnTop = column.topAnchor.constraint(equalTo: productSummary.topAnchor, constant: Layout.spacingM)
        let columnBottom = column.bottomAnchor.constraint(equalTo: headerRule.topAnchor, constant: -Layout.spacingS)
        let accentTop = accentBar.topAnchor.constraint(equalTo: column.topAnchor)
        let accentBottom = accentBar.bottomAnchor.constraint(equalTo: column.bottomAnchor)
        let ruleHeight = headerRule.heightAnchor.constraint(equalToConstant: 2)
        columnTop.priority = UILayoutPriority(999)
        columnBottom.priority = UILayoutPriority(999)
        accentTop.priority = UILayoutPriority(999)
        accentBottom.priority = UILayoutPriority(999)
        ruleHeight.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            imageTop,
            productImageView.leadingAnchor.constraint(equalTo: mediaRegion.leadingAnchor, constant: Layout.spacingS),
            productImageView.trailingAnchor.constraint(equalTo: mediaRegion.trailingAnchor, constant: -Layout.spacingS),
            productImageView.bottomAnchor.constraint(equalTo: mediaRegion.bottomAnchor),

            accentBar.leadingAnchor.constraint(equalTo: productSummary.leadingAnchor, constant: Layout.spacingL),
            accentBar.widthAnchor.constraint(equalToConstant: 3),
            accentTop,
            accentBottom,

            column.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: Layout.spacingS),
            column.trailingAnchor.constraint(equalTo: overflowMenu.button.leadingAnchor),
            columnTop,
            columnBottom,

            overflowMenu.button.topAnchor.constraint(equalTo: productSummary.topAnchor),
            overflowMenu.button.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor, constant: -Layout.spacingXS),
            overflowMenu.button.widthAnchor.constraint(equalToConstant: 44),
            menuHeight,

            purchaseButton.leadingAnchor.constraint(equalTo: purchaseHolder.leadingAnchor),
            purchaseButton.topAnchor.constraint(equalTo: purchaseHolder.topAnchor),
            purchaseButton.bottomAnchor.constraint(equalTo: purchaseHolder.bottomAnchor),
            purchaseButton.trailingAnchor.constraint(lessThanOrEqualTo: purchaseHolder.trailingAnchor),
            purchaseHeight,

            headerRule.leadingAnchor.constraint(equalTo: productSummary.leadingAnchor),
            headerRule.trailingAnchor.constraint(equalTo: productSummary.trailingAnchor),
            headerRule.bottomAnchor.constraint(equalTo: productSummary.bottomAnchor),
            ruleHeight
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
        itemTitleLabel.isHidden = true
        itemPriceLabel.text = nil
        itemPriceLabel.isHidden = true
        linkURL = nil
        linkButton.setTitle(nil, for: .normal)
        linkButton.isHidden = true
        metaRow.isHidden = true
        purchaseHolder.isHidden = true
        overflowMenu.prepareForReuse()
        mediaRegion.isHidden = false
        productSummary.isHidden = false
    }

    func configure(with post: Post, purchaseStyle: ItemPurchaseStyle, showsProduct: Bool = true) {
        self.post = post
        overflowMenu.configure(with: post)

        if !showsProduct {
            productImageView.image = nil
            itemTitleLabel.text = nil
            itemTitleLabel.isHidden = true
            itemPriceLabel.text = nil
            itemPriceLabel.isHidden = true
            linkURL = nil
            linkButton.setTitle(nil, for: .normal)
            linkButton.isHidden = true
            metaRow.isHidden = true
            purchaseHolder.isHidden = true
            mediaRegion.isHidden = true
            productSummary.isHidden = true
            return
        }

        productSummary.isHidden = false

        if let image = post.postImageData, image.size.width > 0 {
            productImageView.image = image
            mediaRegion.isHidden = false
        } else {
            productImageView.image = nil
        }

        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        itemTitleLabel.text = name
        itemTitleLabel.isHidden = name.isEmpty
        productImageView.accessibilityLabel = name

        let price = post.itemPrice?.trimmingCharacters(in: .whitespacesAndNewlines)
        let showPrice = price != nil && !isBlankPrice(price)
        itemPriceLabel.text = showPrice ? price : nil
        itemPriceLabel.isHidden = !showPrice

        let linkTitle = displayLinkTitle(name: post.itemLinkName, url: post.itemLink)
        linkURL = usableLink(post.itemLink)
        linkButton.setTitle(linkTitle, for: .normal)
        linkButton.isHidden = linkTitle == nil
        metaRow.isHidden = linkTitle == nil && !showPrice

        applyPurchaseButtonState(
            purchaseButtonState(post: post, currentUser: PostDataController.shared.currentUser),
            purchaseStyle: purchaseStyle
        )
    }

    private func applyPurchaseButtonState(_ state: PurchaseButtonState, purchaseStyle: ItemPurchaseStyle) {
        buttonState = state
        let showsButton = state != .hidden
        purchaseHolder.isHidden = !showsButton
        purchaseHeight.constant = showsButton ? 44 : 0

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

    private func isBlankPrice(_ price: String?) -> Bool {
        let trimmed = price?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if trimmed.isEmpty { return true }
        let digits = trimmed.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")
        if let value = Double(digits) {
            return value == 0
        }
        return false
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
