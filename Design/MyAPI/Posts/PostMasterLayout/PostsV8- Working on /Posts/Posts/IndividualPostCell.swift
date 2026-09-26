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
    let myImageView = createImageHeaderView()
    //let myCaptionLabel = createLabelView()

    var postImageHeightConstraint: NSLayoutConstraint?

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
        headerView.addSubview(myImageView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false


        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true
 
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 100),
            
            myImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            myImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0),
            myImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -0),
            myImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -0),
            
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 10),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

    func updatePost(with currentImage: UIImage, text: String) {
        //headerView.image = currentImage
        
        // Update the imageView height based on image aspect ratio
        //let aspectRatio = currentImage.size.height / currentImage.size.width
        //let newHeight = UIScreen.main.bounds.width * aspectRatio
        let newHeight = getImageHeight(image: currentImage)
        print("newHeight \(newHeight)")
        postImageHeightConstraint?.constant = newHeight
        // Update the height constraint
        //imageViewHeightConstraint?.constant = newHeight
        myImageView.image = currentImage

  
        layoutIfNeeded() // Ensure layout is updated immediately
    }
}


func createImageHeaderView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}


func createHeaderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view

}
func createBodyView() -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
}

func createFooterView() -> UIView {
    let view = UIView()
    view.backgroundColor = .black
    
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
