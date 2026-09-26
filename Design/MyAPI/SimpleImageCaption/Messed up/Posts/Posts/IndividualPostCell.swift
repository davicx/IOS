//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    //VIEWS
    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()

    /*
    let divider = createDividerView()
    
    //UI ELEMENTS
    let myImageView = createImageHeaderView()
    let myCaptionLabel = createLabelView()
    
    //Variable Heights
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?
     */
    
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
        
        /*
        addSubview(divider)
        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)
        */
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        /*
        divider.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        */
 
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 40),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bodyView.heightAnchor.constraint(equalToConstant: 40),
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
            footerView.heightAnchor.constraint(equalToConstant: 40),
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
            //myImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            //myImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0),
            //myImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -0),
            //myImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -0),

       
            //myCaptionLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 0),
            //myCaptionLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 4),
            //myCaptionLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -4),
            //myCaptionLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -0),
            

            //Divider
            //divider.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            //divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            //divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            //divider.heightAnchor.constraint(equalToConstant: 10),
            //divider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        print(postCaption)
        
        /*
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = currentImage
        myCaptionLabel.text = postCaption

        layoutIfNeeded() // Ensure layout is updated immediately
         */
    }
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





/*
func createImageHeaderView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}



func createDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .black
    
    return view
}

func createLabelView() -> UILabel {
    let label = UILabel()
    label.text = "hi"
    label.backgroundColor = .blue
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    //label.backgroundColor = .green

    
    return label
}

*/
