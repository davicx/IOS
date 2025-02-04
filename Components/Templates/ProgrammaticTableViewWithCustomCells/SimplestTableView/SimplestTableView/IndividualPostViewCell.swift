//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



class IndividualPostViewCell: UITableViewCell {
    var postImageView = UIImageView()
    var postCaptionLabel = UILabel()

    func setUser(currentUser: User) {
        postCaptionLabel.numberOfLines = 0
        postImageView.image = currentUser.userImage
        postCaptionLabel.text = currentUser.userName
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(postImageView)
        addSubview(postCaptionLabel)
        
        configureImageView()
        configureTitleLabel()
        
        setImageConstraints()
        setTitleLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        postImageView.layer.cornerRadius = 10
        postImageView.clipsToBounds = true
    }
    
    func configureTitleLabel () {
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    
    //Leading = Left
    //Trailing = Right (This must be negative)
    func setImageConstraints () {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
        postImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier:16/9).isActive = true
         
    }
    
    func setTitleLabelConstraints () {
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postCaptionLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        //Pin This to the image
        postCaptionLabel.leadingAnchor.constraint(equalTo:postImageView.trailingAnchor,constant:20).isActive = true
        postCaptionLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
        postCaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    

}

