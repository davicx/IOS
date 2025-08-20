//
//  ItemCell.swift
//  AddRows
//
//  Created by David Vasquez on 8/18/25.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func didTapAddStore(on cell: ItemCell)
}


class ItemCell: UITableViewCell {
    
    weak var delegate: ItemCellDelegate?
    
    private let itemImageView = UIImageView()
    private let storesStackView = UIStackView()
    private let availableAtLabel = UILabel()
    private var addButton: UIButton?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemImageView)
        
        storesStackView.axis = .vertical
        storesStackView.spacing = 4
        storesStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storesStackView)
        
        availableAtLabel.text = "Available at"
        availableAtLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            itemImageView.widthAnchor.constraint(equalToConstant: 60),
            itemImageView.heightAnchor.constraint(equalToConstant: 60),
            
            storesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            storesStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            storesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            storesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with item: Item) {
        itemImageView.image = item.image
        
        // Clear old views
        storesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add "Available at" label
        storesStackView.addArrangedSubview(availableAtLabel)
        
        // Add store labels
        for store in item.stores {
            let label = UILabel()
            label.text = "• \(store.name)"
            label.font = UIFont.systemFont(ofSize: 14)
            storesStackView.addArrangedSubview(label)
        }
        
        // Add "Add new store" button
        let addButton = UIButton(type: .system)
        addButton.setTitle("➕ Add a new store", for: .normal)
        addButton.contentHorizontalAlignment = .leading
        addButton.addTarget(self, action: #selector(addStoreTapped), for: .touchUpInside)
        storesStackView.addArrangedSubview(addButton)
        self.addButton = addButton
    }
    
    @objc private func addStoreTapped() {
        delegate?.didTapAddStore(on: self)
    }
}
