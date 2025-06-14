//
//  PostMasterLayout.swift
//  Posts
//
//  Created by David Vasquez on 4/2/25.
//


import UIKit


class PostMasterLayout {
    
    let postHeaderView: UIView
    let postBodyView: UIView
    
    let headerView: UIView
    let bodyView: UIView
    let footerView: UIView
    let divider: UIView
    let myImageView: UIImageView
    let myCaptionLabel: UILabel
    
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?
    
    init(superview: UIView) {
        // Initialize views
        postHeaderView = UIView()
        postBodyView = UIView()
        headerView = createHeaderView()
        bodyView = createBodyView()
        footerView = createFooterView()
        divider = createDividerView()
        myImageView = createImageHeaderView()
        myCaptionLabel = createLabelView()

        // Configure Post Header View
        postHeaderView.backgroundColor = .blue
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Post Body View
        postBodyView.translatesAutoresizingMaskIntoConstraints = false

        // Add views to the superview
        superview.addSubview(postHeaderView)
        superview.addSubview(postBodyView)

        // Add all views inside postBodyView
        postBodyView.addSubview(headerView)
        postBodyView.addSubview(bodyView)
        postBodyView.addSubview(footerView)
        postBodyView.addSubview(divider)

        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)

        // Disable autoresizing mask translation
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        // Setup constraints
        setupConstraints(superview: superview)
    }
    
    private func setupConstraints(superview: UIView) {
        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)
        postCaptionHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            // PostHeaderView Constraints
            postHeaderView.topAnchor.constraint(equalTo: superview.topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 40),

            // PostBodyView Constraints (below postHeaderView)
            postBodyView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            postBodyView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            postBodyView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            postBodyView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),

            // Header (Image)
            headerView.topAnchor.constraint(equalTo: postBodyView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: postBodyView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: postBodyView.trailingAnchor),

            myImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            myImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            myImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            myImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            // Body (Caption)
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: postBodyView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: postBodyView.trailingAnchor),

            myCaptionLabel.topAnchor.constraint(equalTo: bodyView.topAnchor),
            myCaptionLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 4),
            myCaptionLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -4),
            myCaptionLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor),

            // Footer (Comments)
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leftAnchor.constraint(equalTo: postBodyView.leftAnchor),
            footerView.rightAnchor.constraint(equalTo: postBodyView.rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: divider.topAnchor),

            // Divider
            divider.topAnchor.constraint(equalTo: footerView.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: postBodyView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: postBodyView.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 10),
            divider.bottomAnchor.constraint(equalTo: postBodyView.bottomAnchor)
        ])
    }
    
    func updateLayout(with image: UIImage, caption: String) {
        let imageHeight = getImageHeight(image: image)
        let captionHeight = round(calculateLabelHeight(text: caption))
        
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = image
        myCaptionLabel.text = caption
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
   view.backgroundColor = .red
   
   return view

}

func createBodyView() -> UIView {
   let view = UIView()
   view.backgroundColor = .white
   
   return view
}

func createFooterView() -> UIView {
   let view = UIView()
   view.backgroundColor = .blue
   
   return view
}


func createDividerView() -> UIView {
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
   label.backgroundColor = .green

   
   return label
}
