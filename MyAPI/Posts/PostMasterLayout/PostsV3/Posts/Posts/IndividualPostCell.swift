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

    //FOOTER:
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private var imageViewHeightConstraint: NSLayoutConstraint?


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
        addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

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

            footerView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 8),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        

    }

    func configure(with image: UIImage, text: String) {
        postImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        print("newHeight \(newHeight)")
        // Update the height constraint
        imageViewHeightConstraint?.constant = newHeight + 8
        
  
        
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
