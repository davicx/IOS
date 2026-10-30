//
//  ItemCell.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemCell: UITableViewCell {

    //UI COMPONENTS
    private let itemHolder = UIView()
    private let itemInfo = ItemInfo()
    private let itemFooter = ItemFooter()
    private let itemBody = ItemBody()
    private let divider = UIView()

    private var holderLeading: NSLayoutConstraint!
    private var holderTrailing: NSLayoutConstraint!
    private var holderBottom: NSLayoutConstraint!
    private var dividerHeight: NSLayoutConstraint!
    private var mediaHeight: NSLayoutConstraint!
    private var mediaHeightZero: NSLayoutConstraint!
    private var summaryHeightZero: NSLayoutConstraint!
    private var footerTop: NSLayoutConstraint!

    var purchaseStyle: ItemPurchaseStyle = .pinkOutline
    var showsCommentsLink = true
    var usesFeedCard = false {
        didSet {
            guard oldValue != usesFeedCard else { return }
            applyCardStyle()
        }
    }

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.screenBackground
        contentView.backgroundColor = Colors.screenBackground
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupItem() {
        itemHolder.translatesAutoresizingMaskIntoConstraints = false
        itemHolder.backgroundColor = Colors.screenBackground
        contentView.addSubview(itemHolder)

        [itemInfo.productSummary, itemInfo.mediaRegion, itemFooter, itemBody, divider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            itemHolder.addSubview($0)
        }

        divider.backgroundColor = UIColor(hex: "#B0B4BC")
        dividerHeight = divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        holderLeading = itemHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        holderTrailing = itemHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        holderBottom = itemHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        mediaHeight = itemInfo.mediaRegion.heightAnchor.constraint(equalTo: itemInfo.mediaRegion.widthAnchor, multiplier: 0.75)
        mediaHeightZero = itemInfo.mediaRegion.heightAnchor.constraint(equalToConstant: 0)
        summaryHeightZero = itemInfo.productSummary.heightAnchor.constraint(equalToConstant: 0)
        footerTop = itemFooter.topAnchor.constraint(equalTo: itemInfo.mediaRegion.bottomAnchor)

        NSLayoutConstraint.activate([
            itemHolder.topAnchor.constraint(equalTo: contentView.topAnchor),
            holderLeading,
            holderTrailing,
            holderBottom,

            itemInfo.productSummary.topAnchor.constraint(equalTo: itemHolder.topAnchor),
            itemInfo.productSummary.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemInfo.productSummary.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemInfo.mediaRegion.topAnchor.constraint(equalTo: itemInfo.productSummary.bottomAnchor),
            itemInfo.mediaRegion.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemInfo.mediaRegion.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),
            mediaHeight,

            footerTop,
            itemFooter.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemFooter.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            divider.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: itemHolder.bottomAnchor),
            dividerHeight
        ])

        itemInfo.onPurchaseTapped = { [weak self] post, state in
            self?.handlePurchaseAction(post: post, state: state)
        }

        applyCardStyle()
    }

    private func applyCardStyle() {
        if usesFeedCard {
            backgroundColor = .clear
            contentView.backgroundColor = .clear
            itemHolder.layer.cornerRadius = 16
            itemHolder.layer.masksToBounds = true
            divider.isHidden = true
            dividerHeight.constant = 0
            holderLeading.constant = 8
            holderTrailing.constant = -8
            holderBottom.constant = -12
        } else {
            backgroundColor = Colors.screenBackground
            contentView.backgroundColor = Colors.screenBackground
            itemHolder.layer.cornerRadius = 0
            itemHolder.layer.masksToBounds = false
            divider.isHidden = false
            dividerHeight.constant = 1 / UIScreen.main.scale
            holderLeading.constant = 0
            holderTrailing.constant = 0
            holderBottom.constant = 0
        }
    }

    //ACTIONS
    private func handlePurchaseAction(post: Post, state: PurchaseButtonState) {
        guard let presentingVC = findViewController() else { return }

        switch state {
        case .hidden:
            break

        case .purchase:
            let storyboard = UIStoryboard(name: "Post", bundle: nil)
            guard let itemPurchaseVC = storyboard.instantiateViewController(withIdentifier: "ItemPurchaseViewControllerID") as? ItemPurchaseViewController else { return }
            itemPurchaseVC.post = post
            itemPurchaseVC.groupID = post.groupID
            itemPurchaseVC.modalPresentationStyle = .pageSheet
            presentingVC.present(itemPurchaseVC, animated: true)

        case .youPurchased:
            let alert = UIAlertController(
                title: nil,
                message: "Cancel this purchase?",
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(title: "Cancel Purchase", style: .destructive) { _ in
                let groupID = post.groupID ?? 0
                Task {
                    await PostLogic.shared.removeItem(post: post, groupID: groupID)
                }
            })
            alert.addAction(UIAlertAction(title: "Keep", style: .cancel))
            if let popover = alert.popoverPresentationController {
                popover.sourceView = self
                popover.sourceRect = bounds
            }
            presentingVC.present(alert, animated: true)

        case .purchased(let by):
            let alert = UIAlertController(
                title: nil,
                message: "\(by) purchased this item already.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            presentingVC.present(alert, animated: true)
        }
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        purchaseStyle = .pinkOutline
        showsCommentsLink = true
        usesFeedCard = false
        applyItemLayout(showDetails: true, showImage: true)
        itemInfo.prepareForReuse()
        itemBody.prepareForReuse()
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let showDetails = hasDetails(post)
        let showImage = hasRealImage(post)
        applyItemLayout(showDetails: showDetails, showImage: showImage)
        itemInfo.configure(with: post, purchaseStyle: purchaseStyle, showsProduct: showDetails)
        itemFooter.configure(with: post)
        itemBody.configure(with: post, simple: !showDetails && !showImage, showsMenu: !showDetails, showsComments: showsCommentsLink)
    }

    private func applyItemLayout(showDetails: Bool, showImage: Bool) {
        summaryHeightZero.isActive = !showDetails
        if showImage {
            mediaHeightZero.isActive = false
            mediaHeight.isActive = true
        } else {
            mediaHeight.isActive = false
            mediaHeightZero.isActive = true
        }
        footerTop.constant = showImage ? -4 : 0
        itemInfo.productSummary.isHidden = !showDetails
        itemInfo.mediaRegion.isHidden = !showImage
    }

    private func hasDetails(_ post: Post) -> Bool {
        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !name.isEmpty { return true }
        if !isBlankPrice(post.itemPrice) { return true }
        let link = post.itemLink?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if link.isEmpty { return false }
        return link.caseInsensitiveCompare("item_link") != .orderedSame
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

    private func hasRealImage(_ post: Post) -> Bool {
        if let image = post.postImageData, image.size.width > 0 {
            return true
        }
        let candidates = [post.fileUrl, post.cloudKey, post.fileName, post.fileNameServer]
        for value in candidates {
            let text = (value ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            if text.isEmpty || text == "empty" || text == "no_cloud_key" || text == "local_cloud_key" {
                continue
            }
            if text.hasSuffix("background.jpg") || text.contains("postimage-1759360291801") {
                continue
            }
            return true
        }
        return false
    }
}
