//
//  ColorTableViewCell.swift
//  TEMP
//
//  Created by David Vasquez on 9/24/24.
//


import UIKit

class ColorTableViewCell: UITableViewCell {
    
    //TOP
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let blueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var blueImageViewHeightConstraint: NSLayoutConstraint?

    // New TextImageView
    private let textImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // Allows multiple lines
        return label
    }()
    
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
        addSubview(textImageView)
        addSubview(greenView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueImageView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        textImageView.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up textImageView
        textImageView.addSubview(myTextLabel)
        
        // Initial height constraint for blueImageView
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

            // Set textImageView below blueImageView
            textImageView.topAnchor.constraint(equalTo: blueImageView.bottomAnchor, constant: 8),
            textImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Set height for textImageView based on the content
            textImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50), // Adjust as needed
            
            greenView.topAnchor.constraint(equalTo: textImageView.bottomAnchor, constant: 8),
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 12),
            greenView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Label constraints
        NSLayoutConstraint.activate([
            myTextLabel.topAnchor.constraint(equalTo: textImageView.topAnchor),
            myTextLabel.leadingAnchor.constraint(equalTo: textImageView.leadingAnchor),
            myTextLabel.trailingAnchor.constraint(equalTo: textImageView.trailingAnchor),
            myTextLabel.bottomAnchor.constraint(equalTo: textImageView.bottomAnchor)
        ])
    }

    func configure(with image: UIImage, text: String) {
        blueImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        // Update the height constraint
        blueImageViewHeightConstraint?.constant = newHeight
        
        // Set the label text
        myTextLabel.text = text
        
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}

