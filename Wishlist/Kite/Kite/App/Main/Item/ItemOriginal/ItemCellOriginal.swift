//
//  ItemCellOriginal.swift
//  Kite
//
//  Created by David Vasquez on 9/27/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class ItemCellOriginal: UITableViewCell {

    //UI COMPONENTS
    private let itemHolder = UIView()
    private let itemHeader = ItemHeaderOriginal()
    private let itemBody = ItemBodyOriginal()
    private let itemFooter = ItemFooterOriginal()

    private let holderCornerRadius: CGFloat = 16
    private let holderSideInset: CGFloat = Layout.spacingL * 0.8
    
    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Colors.feedBackground
        contentView.backgroundColor = Colors.feedBackground
        clipsToBounds = false
        contentView.clipsToBounds = false
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupItem() {
        itemHolder.translatesAutoresizingMaskIntoConstraints = false
        itemHolder.backgroundColor = Colors.screenBackground
        itemHolder.layer.cornerRadius = holderCornerRadius
        itemHolder.layer.borderWidth = 1
        itemHolder.layer.borderColor = Colors.separator.cgColor
        itemHolder.clipsToBounds = true
        if #available(iOS 13.0, *) {
            itemHolder.layer.cornerCurve = .continuous
        }
        contentView.addSubview(itemHolder)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false

        [itemHeader, itemBody, itemFooter].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            itemHolder.addSubview($0)
        }

        NSLayoutConstraint.activate([
            itemHolder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingM),
            itemHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: holderSideInset),
            itemHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -holderSideInset),
            itemHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingM),

            itemHeader.topAnchor.constraint(equalTo: itemHolder.topAnchor),
            itemHeader.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemHeader.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemBody.topAnchor.constraint(equalTo: itemHeader.bottomAnchor),
            itemBody.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemBody.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),

            itemFooter.topAnchor.constraint(equalTo: itemBody.bottomAnchor),
            itemFooter.leadingAnchor.constraint(equalTo: itemHolder.leadingAnchor),
            itemFooter.trailingAnchor.constraint(equalTo: itemHolder.trailingAnchor),
            itemFooter.bottomAnchor.constraint(equalTo: itemHolder.bottomAnchor)
        ])

        itemHeader.onPurchaseTapped = { [weak self] post, state in
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

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: itemHolder.frame,
            cornerRadius: holderCornerRadius
        ).cgPath
    }

    //FUNCTIONS
    func configure(with post: Post) {
        itemHeader.configure(with: post)
        itemBody.configure(with: post)
        itemFooter.configure(with: post)
    }
}
