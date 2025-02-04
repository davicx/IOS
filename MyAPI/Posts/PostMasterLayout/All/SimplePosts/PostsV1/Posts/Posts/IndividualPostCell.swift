//
//  IndividualPostCell.swift
//  Posts
//
//  Created by David Vasquez on 9/26/24.
//

import UIKit


class IndividualPostCell: UITableViewCell {
    
    private var imageViewHeightConstraint: NSLayoutConstraint?

    //HEADER: Post Image
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //Post Image
    private let textImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    
    //FUNCTIONS: Style
    private func setupViews() {
        addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
   
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            //headerView.heightAnchor.constraint(equalToConstant: 4),

        ])
        

    }
    
    
    
    //CONFIGURE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    //NEED TO ADD BELOW
    func setPost(with image: UIImage, postCaption: String) {
        print("CONFIGURE \(postCaption)")
        /*
        postImageView.image = image
        
        // Update the imageView height based on image aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = UIScreen.main.bounds.width * aspectRatio
        
        imageViewHeightConstraint?.constant = newHeight + 8
        
        // Set the label text
        myTextLabel.text = postCaption
        
        layoutIfNeeded() // Ensure layout is updated immediately
         */
    }
    
    
    /*


    //BODY: Image and Post
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()

    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    


    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    


    private func setupViews() {
        addSubview(headerView)
        addSubview(postImageView)
        addSubview(textImageView)
        addSubview(footerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        textImageView.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up textImageView
        textImageView.addSubview(myTextLabel)
        
        // Initial height constraint for blueImageView
        imageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 4),

            postImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Set textImageView below ImageView
            textImageView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            textImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Set height for textImageView based on the content
            textImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50), // Adjust as needed
            
            footerView.topAnchor.constraint(equalTo: textImageView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 8),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Label constraints
        NSLayoutConstraint.activate([
            myTextLabel.topAnchor.constraint(equalTo: textImageView.topAnchor),
            myTextLabel.leadingAnchor.constraint(equalTo: textImageView.leadingAnchor),
            myTextLabel.trailingAnchor.constraint(equalTo: textImageView.trailingAnchor),
            myTextLabel.bottomAnchor.constraint(equalTo: textImageView.bottomAnchor)
        ])
    }
     */

}



//APPENDIX
/*
 //
 //  VideoCell.swift
 //  UITableViewTutorialCustomCellsProgrammatic
 //
 //  Created by David Vasquez on 9/16/24.
 //

 import UIKit

 class VideoCell: UITableViewCell {
     var videoImageView = UIImageView()
     var videoTitleLabel = UILabel ()
     
     

     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(videoImageView)
         addSubview(videoTitleLabel)
         configureImageView()
         configureTitleLabel()
         setImageConstraints()
         setTitleLabelConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func configureImageView() {
         videoImageView.layer.cornerRadius = 10
         videoImageView.clipsToBounds = true
     }
     
     func configureTitleLabel () {
         videoTitleLabel.numberOfLines = 0
         videoTitleLabel.adjustsFontSizeToFitWidth = true
     }
     
     
     //Leading = Left
     //Trailing = Right (This must be negative)
     func setImageConstraints () {
         videoImageView.translatesAutoresizingMaskIntoConstraints = false
         videoImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
         videoImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
         videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier:16/9).isActive = true
     }
     
     func setTitleLabelConstraints () {
         videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
         videoTitleLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         //Pin This to the image
         videoTitleLabel.leadingAnchor.constraint(equalTo:videoImageView.trailingAnchor,constant:20).isActive = true
         videoTitleLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
         videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
     }
 }



 */
