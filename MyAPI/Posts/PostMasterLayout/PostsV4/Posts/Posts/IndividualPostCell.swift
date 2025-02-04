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
        view.backgroundColor = .blue
        return view
    }()


    //BODY: Image and Post
    private let bodyView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
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
        addSubview(bodyView)
        addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        imageViewHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        

    }

    func configure(with image: UIImage, text: String) {
        bodyView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        print("newHeight \(newHeight)")
        // Update the height constraint
        imageViewHeightConstraint?.constant = newHeight + 8
  
        
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}



