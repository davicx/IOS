//
//  ViewController.swift
//  AddRows
//
//  Created by David Vasquez on 8/18/25.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    // Main scrollable container
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupContent()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // StackView to hold items
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32) // keep padding
        ])
    }
    
    private func setupContent() {
        // Example items
        let item1 = createItemView(title: "Item 1", stores: ["Target", "Amazon"])
        let item2 = createItemView(title: "Item 2", stores: ["Target", "Amazon", "Walmart"])
        
        contentStackView.addArrangedSubview(item1)
        contentStackView.addArrangedSubview(item2)
    }
    
    private func createItemView(title: String, stores: [String]) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.backgroundColor = UIColor(white: 0.95, alpha: 1)
        container.layer.cornerRadius = 12
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        // Image placeholder
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // Title
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Stores list
        let storesStack = UIStackView()
        storesStack.axis = .vertical
        storesStack.spacing = 4
        
        for store in stores {
            let label = UILabel()
            label.text = "• \(store)"
            label.font = UIFont.systemFont(ofSize: 16)
            storesStack.addArrangedSubview(label)
        }
        
        // Add new store button
        let addButton = UIButton(type: .system)
        addButton.setTitle("➕ Add a new store", for: .normal)
        addButton.addAction(UIAction { _ in
            let newStoreLabel = UILabel()
            newStoreLabel.text = "• New Store"
            newStoreLabel.font = UIFont.systemFont(ofSize: 16)
            storesStack.addArrangedSubview(newStoreLabel)
        }, for: .touchUpInside)
        
        // Build hierarchy
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(storesStack)
        container.addArrangedSubview(addButton)
        
        return container
    }
}

