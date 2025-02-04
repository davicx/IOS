//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    //HEADER
    private let headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView

    }()

    //FOOTER:
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 2),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

    func createPost(with currentImage: UIImage, text: String) {
        headerView.image = currentImage
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = currentImage.size.height / currentImage.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        print("newHeight \(newHeight)")
        // Update the height constraint
        imageViewHeightConstraint?.constant = newHeight
  
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}



