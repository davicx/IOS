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
    private let itemHeader = ItemHeader()
    private let itemInfo = ItemInfo()
    private let itemFooter = ItemFooter()
    private let itemBody = ItemBody()
    private let divider = UIView()

    private var holderLeading: NSLayoutConstraint!
    private var holderTrailing: NSLayoutConstraint!
    private var holderBottom: NSLayoutConstraint!
    private var dividerHeight: NSLayoutConstraint!

    var purchaseStyle: ItemPurchaseStyle = .pinkOutline
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

        [itemHeader, itemInfo.mediaRegion, itemFooter, itemBody, itemInfo.productSummary, divider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            itemHolder.addSubview($0)
        }

        divider.backgroundColor = UIColor(hex: "#B0B4BC")
        dividerHeight = divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        holderLeading = itemHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        holderTrailing = itemHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        holderBottom = itemHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        NSLayoutConstraint.activate([
            itemHolder.topAnchor.constraint(equalTo: contentView.topAnchor),
            holderLeading,
            holderTrailing,
            holderBottom,

            itemHeader.topAnchor.constraint(equalTo: itemHolder.topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemInfo.mediaRegion.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemInfo.mediaRegion.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemInfo.mediaRegion.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),
            itemInfo.mediaRegion.heightAnchor.constraint(equalTo: itemInfo.mediaRegion.widthAnchor, multiplier: 0.75),

            itemFooter.topAnchor.constraint(equalTo: itemInfo.mediaRegion.bottomAnchor),
            itemFooter.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemFooter.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemInfo.productSummary.topAnchor.constraint(equalTo: itemBody.bottomAnchor, constant: Layout.spacingM),
            itemInfo.productSummary.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor, constant: Layout.spacingM),
            itemInfo.productSummary.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor, constant: -Layout.spacingM),

            divider.topAnchor.constraint(equalTo: itemInfo.productSummary.bottomAnchor, constant: Layout.spacingM),
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
        usesFeedCard = false
        itemHeader.prepareForReuse()
        itemInfo.prepareForReuse()
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemHeader.configure(with: post)
        itemInfo.configure(with: post, purchaseStyle: purchaseStyle)
        itemFooter.configure(with: post)
        itemBody.configure(with: post)
    }
}
