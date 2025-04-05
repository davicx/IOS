//
//  IndividualPostCell.swift
//  Kite
//
//  Created by David Vasquez on 2/26/25.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    let postUserView = createPostUserView()
    let postFromLabel = createLabelView()
    
    let postImageView = createPostImageView()
    let postImage = createPostImage()

    
    //Heights
    var postImageHeightConstraint: NSLayoutConstraint?
 
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
            /*
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
              footerView.leftAnchor.constraint(equalTo: leftAnchor),
              footerView.rightAnchor.constraint(equalTo: rightAnchor),
              footerView.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -0),
              */

            postImage.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 0),
            postImage.leftAnchor.constraint(equalTo: postImageView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: postImageView.rightAnchor, constant: -0),
            postImage.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -0),
            
        ])
        
        
        
    }

    func updatePost(with post: Post) {
        let currentImage = post.postImageData ?? UIImage(named: "background_1") ?? UIImage()
        //let postCaption = post.postCaption ?? "no caption"
        
        let imageHeight = getImageHeight(image: currentImage)
        
        postImageHeightConstraint?.constant = imageHeight
        postImage.image = currentImage
        //let captionHeight = round(calculateLabelHeight(text: postCaption))
        //print("imageHeight \(imageHeight) captionHeight \(captionHeight)")
        
        // Example usage (you can update this to fit your actual UI components)
        // postImageView.image = currentImage
        // captionLabel.text = postCaption
        
        layoutIfNeeded()
        
    }
    

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

//POST: Post User
func createPostUserView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view

}


func createLabelView() -> UILabel {
    let label = UILabel()
    label.text = "hi"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .blue
    

    
    return label
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


func createDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .black
    
    return view
}










//APPENDIX
/*
class IndividualPostCell: UITableViewCell {
    
    // Layout Manager
    private let layoutManager = IndividualPostCellLayoutManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup layout using Layout Manager
        layoutManager.setupLayout(in: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPost(post: Post) {
        print("Caption: \(post.postCaption)")
    }
}
*/

//WORKS
/*

class IndividualPostCell: UITableViewCell {
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let postCaption: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.addSubview(postCaption)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            postCaption.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postCaption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPost(post: Post) {
        postImageView.image = post.postImageData
        postCaption.text = post.postCaption
    }
}


*/
