//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    //HEADER
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    //BODY: Image and Post
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()

    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private var imageViewHeightConstraint: NSLayoutConstraint?

    // New TextImageView
    private let textImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
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
        addSubview(headerView)
        addSubview(postImageView)
        addSubview(textImageView)
        addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        textImageView.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up textImageView
        textImageView.addSubview(myTextLabel)
        
        // Initial height constraint for blueImageView
        imageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 4),

            postImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Set textImageView below ImageView
            textImageView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            textImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Set height for textImageView based on the content
            textImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50), // Adjust as needed
            
            footerView.topAnchor.constraint(equalTo: textImageView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 8),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        postImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        // Update the height constraint
        imageViewHeightConstraint?.constant = newHeight + 8
        
        // Set the label text
        myTextLabel.text = text
        
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}

