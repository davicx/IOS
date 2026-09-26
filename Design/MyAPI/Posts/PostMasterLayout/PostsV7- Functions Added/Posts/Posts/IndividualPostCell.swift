//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()
    let myCaptionLabel = createLabelView()

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
        bodyView.addSubview(myCaptionLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        //imageViewHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint?.isActive = true
 
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 60),
            
            myCaptionLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 8),
            myCaptionLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 8),
            myCaptionLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -8),
            myCaptionLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -8),
            
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

    func updatePost(with currentImage: UIImage, text: String) {
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




func createHeaderView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}

func createBodyView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view
}

func createFooterView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemPink
    
    return view
}

func createLabelView() -> UILabel {
    let label = UILabel()
    label.text = "hi"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .white
    
    return label
}

