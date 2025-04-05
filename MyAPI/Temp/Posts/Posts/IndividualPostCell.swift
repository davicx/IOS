//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit

//GO TO HERE
//GO TO HERE
//GO TO HERE
//GO TO HERE
//GO TO HERE
//GO TO HERE

class IndividualPostCell: UITableViewCell {
    
    //USER
    let postUserView = createHeaderView()
    //let bodyView = createBodyView()
    //let footerView = createFooterView()
    //let divider = createDividerView()
    
    let postImageView = createImageHeaderView()
    //let myCaptionLabel = createLabelView()

    var postImageHeightConstraint: NSLayoutConstraint?
    //var postCaptionHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(postUserView)
        //addSubview(bodyView)
        //addSubview(footerView)
        //addSubview(divider)
        
        postUserView.addSubview(postImageView)
        //bodyView.addSubview(myCaptionLabel)
        
        postUserView.translatesAutoresizingMaskIntoConstraints = false
        
        //bodyView.translatesAutoresizingMaskIntoConstraints = false
        //footerView.translatesAutoresizingMaskIntoConstraints = false
        
        //divider.translatesAutoresizingMaskIntoConstraints = false
        
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        //myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = postUserView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        //postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        //postCaptionHeightConstraint?.isActive = true
        
 
        NSLayoutConstraint.activate([
            
            //Image
            postUserView.topAnchor.constraint(equalTo: topAnchor),
            postUserView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postUserView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            postImageView.topAnchor.constraint(equalTo: postUserView.topAnchor, constant: 0),
            postImageView.leftAnchor.constraint(equalTo: postUserView.leftAnchor, constant: 0),
            postImageView.rightAnchor.constraint(equalTo: postUserView.rightAnchor, constant: -0),
            postImageView.bottomAnchor.constraint(equalTo: postUserView.bottomAnchor, constant: -0),

            /*
            //Text
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            myCaptionLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 0),
            myCaptionLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 4),
            myCaptionLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -4),
            myCaptionLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -0),
            
            //Comments
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -0),
            
            //Divider
            divider.topAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 0),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 10),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
             */
        ])
        
    }

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postImageHeightConstraint?.constant = imageHeight
        //postCaptionHeightConstraint?.constant = captionHeight
        postImageView.image = currentImage
        //myCaptionLabel.text = postCaption

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

