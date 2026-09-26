//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



class IndividualPostViewCell: UITableViewCell {
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setUser(currentUser: User) {
        postImageView.image = currentUser.userImage
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(postImageView)
        configureImageView()
        setImageConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        postImageView.layer.cornerRadius = 10
        postImageView.clipsToBounds = true
    }
    
    
    //Leading = Left
    //Trailing = Right (This must be negative)
    func setImageConstraints () {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
        postImageView.heightAnchor.constraint(equalToConstant:180).isActive = true
        postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier:16/9).isActive = true
 
         
    }
    

}

