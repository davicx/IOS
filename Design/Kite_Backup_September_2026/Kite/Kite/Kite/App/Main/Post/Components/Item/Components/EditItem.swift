//
//  EditItem.swift
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

// EditItem is the ••• menu for a wishlist item post.

final class EditItem: UIView {

    //LOGIC
    private var postID: Int?
    private var itemName: String = ""

    //UI COMPONENTS
    private let menuButton = UIButton(type: .system)

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
        setupMenuButton()
        setupMenu()
    }

    //LAYOUT and UI
    private func setupMenuButton() {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(UIImage(named: "menu-horizontal"), for: .normal)
        menuButton.tintColor = Colors.primaryGrayText
        menuButton.imageView?.contentMode = .scaleAspectFit
        addSubview(menuButton)

        // 28pt icon (20 + 8).
        let menuSize: CGFloat = 28
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: menuSize),
            heightAnchor.constraint(equalToConstant: menuSize),

            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: menuSize),
            menuButton.heightAnchor.constraint(equalToConstant: menuSize)
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
        guard let postID else {
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

    //FUNCTIONS
    func configure(with post: Post) {
        postID = post.postID
        let name = post.itemName?.trimmingCharacters(in: .whitespacesAndNewlines)
        itemName = (name?.isEmpty == false) ? name! : (post.postCaption ?? "")
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
