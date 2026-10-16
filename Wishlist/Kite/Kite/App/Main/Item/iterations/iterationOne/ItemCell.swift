// Backup of the live Item card before the Option C spacing pass.
// Commented out so this copy is not compiled.

/*
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
    private let itemHeader = ItemHeader()
    private let itemInfo = ItemInfo()
    private let itemFooter = ItemFooter()
    private let itemBody = ItemBody()
    private let divider = UIView()

    var purchaseStyle: ItemPurchaseStyle = .pinkOutline

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
        [itemHeader, itemInfo.mediaRegion, itemFooter, itemBody, itemInfo.productSummary, divider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        divider.backgroundColor = Colors.dividerColor

        NSLayoutConstraint.activate([
            itemHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            itemInfo.mediaRegion.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemInfo.mediaRegion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemInfo.mediaRegion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemInfo.mediaRegion.heightAnchor.constraint(equalTo: itemInfo.mediaRegion.widthAnchor, multiplier: 0.75),

            itemFooter.topAnchor.constraint(equalTo: itemInfo.mediaRegion.bottomAnchor),
            itemFooter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemFooter.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            itemInfo.productSummary.topAnchor.constraint(equalTo: itemBody.bottomAnchor, constant: Layout.spacingS),
            itemInfo.productSummary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemInfo.productSummary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            divider.topAnchor.constraint(equalTo: itemInfo.productSummary.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])

        itemInfo.onPurchaseTapped = { [weak self] post, state in
            self?.handlePurchaseAction(post: post, state: state)
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

*/
