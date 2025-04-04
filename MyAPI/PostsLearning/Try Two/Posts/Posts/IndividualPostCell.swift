//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit

class IndividualPostCell: UITableViewCell {
    
    var postLayout: PostMasterLayout!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postLayout = PostMasterLayout(superview: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePost(with currentImage: UIImage, postCaption: String) {
        postLayout.updateLayout(with: currentImage, caption: postCaption)
        layoutIfNeeded()
    }
}


/*
class IndividualPostCell: UITableViewCell {
    
    let postHeaderView = UIView() // New header view
    let postBodyView = UIView()   // Existing body container

    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()
    let divider = createDividerView()
    
    let myImageView = createImageHeaderView()
    let myCaptionLabel = createLabelView()

    // Post and Image Constraints
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        // Configure postHeaderView
        postHeaderView.backgroundColor = .systemPink
        postHeaderView.translatesAutoresizingMaskIntoConstraints = false

        // Add `postHeaderView` and `postBodyView` to the cell
        addSubview(postHeaderView)
        addSubview(postBodyView)

        postBodyView.translatesAutoresizingMaskIntoConstraints = false

        // Add all views inside `postBodyView`
        postBodyView.addSubview(headerView)
        postBodyView.addSubview(bodyView)
        postBodyView.addSubview(footerView)
        postBodyView.addSubview(divider)
        
        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            // PostHeaderView Constraints
            postHeaderView.topAnchor.constraint(equalTo: topAnchor),
            postHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postHeaderView.heightAnchor.constraint(equalToConstant: 40),

            // PostBodyView Constraints (below postHeaderView)
            postBodyView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            postBodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postBodyView.bottomAnchor.constraint(equalTo: bottomAnchor),

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

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = currentImage
        myCaptionLabel.text = postCaption

        layoutIfNeeded() // Ensure layout is updated immediately
    }
}
*/

 

//WORKS
/*
class IndividualPostCell: UITableViewCell {
    
    let postBodyView = UIView() // New container view
    
    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()
    let divider = createDividerView()
    
    let myImageView = createImageHeaderView()
    let myCaptionLabel = createLabelView()

    // Post and Image Constraints
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        // Add `postBodyView` first
        addSubview(postBodyView)
        postBodyView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add all views inside `postBodyView`
        postBodyView.addSubview(headerView)
        postBodyView.addSubview(bodyView)
        postBodyView.addSubview(footerView)
        postBodyView.addSubview(divider)
        
        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            // PostBodyView Constraints
            postBodyView.topAnchor.constraint(equalTo: topAnchor),
            postBodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postBodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postBodyView.bottomAnchor.constraint(equalTo: bottomAnchor),

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

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = currentImage
        myCaptionLabel.text = postCaption

        layoutIfNeeded() // Ensure layout is updated immediately
    }
}
*/

/*
class IndividualPostCell: UITableViewCell {
    
    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()
    let divider = createDividerView()
    
    let myImageView = createImageHeaderView()
    let myCaptionLabel = createLabelView()

    //Post and Image Constraints
    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        //POST:
        addSubview(headerView)
        addSubview(bodyView)
        addSubview(footerView)
        addSubview(divider)
        
        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
 
        NSLayoutConstraint.activate([
            
            //Image
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            myImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            myImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0),
            myImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -0),
            myImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -0),

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
        ])
        
    }

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = currentImage
        myCaptionLabel.text = postCaption

        layoutIfNeeded() // Ensure layout is updated immediately
    }
}

*/
