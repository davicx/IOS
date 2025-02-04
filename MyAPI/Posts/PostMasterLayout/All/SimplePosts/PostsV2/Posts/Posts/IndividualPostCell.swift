//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit



class IndividualPostCell: UITableViewCell {

    private var imageViewHeightConstraint: NSLayoutConstraint?

    // Header
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    // Image View
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    
    // View Setup
    private func setupViews() {
        addSubview(headerView)
        addSubview(postImageView)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false

        // Setup headerView constraints
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100), // Default height for header
        ])

        // Setup postImageView constraints
        imageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor)
        ])
    }

    // Configure
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure cell with image and caption
    func setPost(with image: UIImage, postCaption: String) {
        postImageView.image = image

        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio

        imageViewHeightConstraint?.constant = newHeight
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}


/*

class IndividualPostCell: UITableViewCell {

    private var imageViewHeightConstraint: NSLayoutConstraint?

    //HEADER
    //Post Image Holder
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //Image View
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    
    //BODY
    
    //VIEW SETUP
    private func setupViews() {
        addSubview(headerView)
        addSubview(postImageView)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //Header:
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),
            
            postImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
        ])
        
    }

    //CONFIGURE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //NEED TO ADD BELOW
    // Configure cell with image and caption
    func setPost(with image: UIImage, postCaption: String) {
        postImageView.image = image
        
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        print("newHeight \(newHeight)")
        // Update the height constraint
        imageViewHeightConstraint?.constant = newHeight + 0
        
        layoutIfNeeded() // Ensure layout is updated immediately
        print("CONFIGURE \(postCaption)")
    }
    

}

 */
