//
//  IndividualPostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/26/25.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    //Post User
    let postUserView = createPostUserView()
    let postFromLabel = createPostUserName()
    
    //Post Image
    let postImageView = createPostImageView()
    let postImage = createPostImage()
    
    //Post Socials
    let postSocialsView = createPostSocialsView()
    let postSocialsLabel = createPostSocialsText()
    
    //Post Caption
    let postCaptionView = createPostCaptionView()
    let postCaptionLabel = createPostCaptionText()
    
    //Post Divider
    let postDividerView = createPostDividerView()
    
    //Heights for Dynamic Content
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
        
        //POST: User View
        postUserView.translatesAutoresizingMaskIntoConstraints = false
        postFromLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postUserView)
        postUserView.addSubview(postFromLabel)
        
        //POST: Post Image
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postImageView)
        postImageView.addSubview(postImage)
        
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true
        
        //POST: Post Socials
        postSocialsView.translatesAutoresizingMaskIntoConstraints = false
        postSocialsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postSocialsView)
        postSocialsView.addSubview(postSocialsLabel)
        
        //POST: Post Caption
        postCaptionView.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(postCaptionView)
        postCaptionView.addSubview(postCaptionLabel)
        
        postCaptionHeightConstraint = postCaptionView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
        //POST: Divider
        postDividerView.translatesAutoresizingMaskIntoConstraints = false
   
        addSubview(postDividerView)
        
        NSLayoutConstraint.activate([
            
            //Post User View
            postUserView.topAnchor.constraint(equalTo: topAnchor),
            postUserView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postUserView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postUserView.heightAnchor.constraint(equalToConstant: 40),
   
            postFromLabel.topAnchor.constraint(equalTo: postUserView.topAnchor, constant: 0),
            postFromLabel.leftAnchor.constraint(equalTo: postUserView.leftAnchor, constant: 0),
            postFromLabel.rightAnchor.constraint(equalTo: postUserView.rightAnchor, constant: -0),
            postFromLabel.bottomAnchor.constraint(equalTo: postUserView.bottomAnchor, constant: -0),
            
            //Post Image View
            postImageView.topAnchor.constraint(equalTo: postUserView.bottomAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postImage.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            postImage.leftAnchor.constraint(equalTo: postImageView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: postImageView.rightAnchor, constant: -0),
            postImage.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -0),
            
            //Post Socials View
            postSocialsView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 0),
            postSocialsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postSocialsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postSocialsView.heightAnchor.constraint(equalToConstant: 40),
           
            postSocialsLabel.topAnchor.constraint(equalTo: postSocialsView.topAnchor, constant: 0),
            postSocialsLabel.leftAnchor.constraint(equalTo: postSocialsView.leftAnchor, constant: 0),
            postSocialsLabel.rightAnchor.constraint(equalTo: postSocialsView.rightAnchor, constant: -0),
            postSocialsLabel.bottomAnchor.constraint(equalTo: postSocialsView.bottomAnchor, constant: -0),
            
            //Post Caption View
            postCaptionView.topAnchor.constraint(equalTo: postSocialsLabel.bottomAnchor, constant: 0),
            postCaptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postCaptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            postCaptionLabel.topAnchor.constraint(equalTo: postCaptionView.topAnchor, constant: 0),
            postCaptionLabel.leftAnchor.constraint(equalTo: postCaptionView.leftAnchor, constant: 0),
            postCaptionLabel.rightAnchor.constraint(equalTo: postCaptionView.rightAnchor, constant: -0),
            postCaptionLabel.bottomAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: -0),
            
            //Post Divider View
            postDividerView.topAnchor.constraint(equalTo: postCaptionView.bottomAnchor, constant: 0),
            postDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postDividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postDividerView.heightAnchor.constraint(equalToConstant: 5),
            
            //Chat Maybe
            //postDividerView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
        
    }
    
    //CELL SETUP
    func updatePost(with post: Post) {
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        let postCaption = post.postCaption ?? "no caption"
        
        let imageHeight = getImageHeight(image: currentImage)
        postImageHeightConstraint?.constant = imageHeight
        postImage.image = currentImage
        
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        postCaptionHeightConstraint?.constant = captionHeight
        postCaptionLabel.text = postCaption
        
        postSocialsLabel.text = "Post Like Count: \(post.simpleLikesArray?.count ?? 0)"
        
        layoutIfNeeded()
    }


}


//POST: Post User
func createPostUserView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemRed
    
    return view

}

func createPostUserName() -> UILabel {
    let label = UILabel()
    label.text = "Garden Party"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .white
    
    return label
}


//POST: Post Image
func createPostImageView() -> UIView {
    let view = UIView()
    view.backgroundColor = .lightGray
    
    return view

}

func createPostImage() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}

//POST: Post Socials
func createPostSocialsView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

}

func createPostSocialsText() -> UILabel {
    let label = UILabel()
    label.text = "SOCIALS: Post User"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .blue
    
    return label
}

//POST: Post Caption
func createPostCaptionView() -> UIView {
    let view = UIView()
    view.backgroundColor = .green
    
    return view

}

func createPostCaptionText() -> UILabel {
    let label = UILabel()
    label.text = "CAPTION: My Caption"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    //label.textAlignment = .center
    label.backgroundColor = .green
    
    return label
}

//POST: Post Divider
func createPostDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemRed
    
    return view
}


//SORT
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










