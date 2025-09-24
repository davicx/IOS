//
//  ItemCell.swift
//  Kite
//
//  Created by David Vasquez on 8/13/25.
//

import UIKit

class ItemCell: UITableViewCell {
    
    //MAIN VIEWS
    let productContainerView = componentFunctions.createUIView(backgroundColor: .white)
    let closeButtonView = componentFunctions.createUIView(backgroundColor: .clear)
    let closeButton = UIImageView()
    
    //PRODUCT IMAGE SECTION
    let productImageView = componentFunctions.createUIView(backgroundColor: .clear)
    let productImage = UIImageView()
    
    //PRODUCT INFO SECTION
    let productInfoView = componentFunctions.createUIView(backgroundColor: .clear)
    let productPriceLabel = UILabel()
    let productNameLabel = UILabel()
    let productBrandLabel = UILabel()
    let addToCartButton = UIButton()
    
    //SETUP
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Setup main container
        productContainerView.translatesAutoresizingMaskIntoConstraints = false
        productContainerView.layer.cornerRadius = 8
        productContainerView.layer.borderWidth = 1
        productContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Setup close button
        closeButtonView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.image = UIImage(systemName: "xmark")
        closeButton.tintColor = .darkGray
        closeButton.contentMode = .scaleAspectFit
        
        // Setup product image
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = UIImage(named: "background")
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        productImage.layer.cornerRadius = 4
        
        // Setup product info
        productInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.text = "$4.99"
        productPriceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        productPriceLabel.textColor = .black
        productPriceLabel.backgroundColor = .clear
        
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.text = "Upright Lunch Bag -"
        productNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        productNameLabel.textColor = .black
        productNameLabel.backgroundColor = .clear
        
        productBrandLabel.translatesAutoresizingMaskIntoConstraints = false
        productBrandLabel.text = "Embark™ Tan"
        productBrandLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        productBrandLabel.textColor = .black
        productBrandLabel.backgroundColor = .clear
        
        // Setup add to cart button
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        addToCartButton.backgroundColor = UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0) // Reddish-brown
        addToCartButton.layer.cornerRadius = 6
        
        // Add views
        contentView.addSubview(productContainerView)
        productContainerView.addSubview(closeButtonView)
        closeButtonView.addSubview(closeButton)
        productContainerView.addSubview(productImageView)
        productImageView.addSubview(productImage)
        productContainerView.addSubview(productInfoView)
        productInfoView.addSubview(productPriceLabel)
        productInfoView.addSubview(productNameLabel)
        productInfoView.addSubview(productBrandLabel)
        productInfoView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            // Main container
            productContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            productContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            // Close button
            closeButtonView.topAnchor.constraint(equalTo: productContainerView.topAnchor, constant: 8),
            closeButtonView.trailingAnchor.constraint(equalTo: productContainerView.trailingAnchor, constant: -8),
            closeButtonView.widthAnchor.constraint(equalToConstant: 24),
            closeButtonView.heightAnchor.constraint(equalToConstant: 24),
            
            closeButton.centerXAnchor.constraint(equalTo: closeButtonView.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: closeButtonView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            
            // Product image (left side)
            productImageView.leadingAnchor.constraint(equalTo: productContainerView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: productContainerView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            productImage.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            productImage.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            
            // Product info (right side)
            productInfoView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productInfoView.trailingAnchor.constraint(equalTo: productContainerView.trailingAnchor, constant: -16),
            productInfoView.centerYAnchor.constraint(equalTo: productContainerView.centerYAnchor),
            productInfoView.heightAnchor.constraint(equalToConstant: 80),
            
            // Price label
            productPriceLabel.topAnchor.constraint(equalTo: productInfoView.topAnchor),
            productPriceLabel.leadingAnchor.constraint(equalTo: productInfoView.leadingAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: productInfoView.trailingAnchor),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 22),
            
            // Product name label
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4),
            productNameLabel.leadingAnchor.constraint(equalTo: productInfoView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: productInfoView.trailingAnchor),
            productNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // Brand label
            productBrandLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            productBrandLabel.leadingAnchor.constraint(equalTo: productInfoView.leadingAnchor),
            productBrandLabel.trailingAnchor.constraint(equalTo: productInfoView.trailingAnchor),
            productBrandLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // Add to cart button
            addToCartButton.topAnchor.constraint(equalTo: productBrandLabel.bottomAnchor, constant: 8),
            addToCartButton.leadingAnchor.constraint(equalTo: productInfoView.leadingAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 100),
            addToCartButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
}
