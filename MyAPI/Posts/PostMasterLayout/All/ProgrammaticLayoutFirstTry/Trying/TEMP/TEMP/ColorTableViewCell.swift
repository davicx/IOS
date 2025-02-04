//
//  ColorTableViewCell.swift
//  TEMP
//
//  Created by David Vasquez on 9/24/24.
//


import UIKit

class ColorTableViewCell: UITableViewCell {
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let blueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Maintain aspect ratio
        return imageView
    }()
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var blueImageViewHeightConstraint: NSLayoutConstraint?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        addSubview(redView)
        addSubview(blueImageView)
        addSubview(greenView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueImageView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        blueImageViewHeightConstraint = blueImageView.heightAnchor.constraint(equalToConstant: 0)
        blueImageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: topAnchor),
            redView.leadingAnchor.constraint(equalTo: leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 40),
            
            blueImageView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            blueImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blueImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            greenView.topAnchor.constraint(equalTo: blueImageView.bottomAnchor),
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 12),
            greenView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage) {
        blueImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        // Update the height constraint
        blueImageViewHeightConstraint?.constant = newHeight
        layoutIfNeeded() // Ensure layout is updated immediately
    }
    
    func configureOriginal(with image: UIImage) {
        blueImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        blueImageView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        
        layoutIfNeeded() // Ensure layout is updated immediately
    }

    
    
    private func setupViewsOriginal() {
        addSubview(redView)
        addSubview(blueImageView)
        addSubview(greenView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueImageView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: topAnchor),
            redView.leadingAnchor.constraint(equalTo: leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 40),
            
            blueImageView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            blueImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blueImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blueImageView.heightAnchor.constraint(equalTo: blueImageView.widthAnchor, multiplier: 0), // Placeholder, will be updated in configure
            
            greenView.topAnchor.constraint(equalTo: blueImageView.bottomAnchor),
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 12),
            greenView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}



//NEW
/*
 class ColorTableViewCell: UITableViewCell {







 }




 */
