//
//  PostLayoutManager.swift
//  Posts
//
//  Created by David Vasquez on 3/27/25.
//

import UIKit


class IndividualPostLayoutManager {
    
    // Image Container
    let postImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Divider View
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupLayout(in contentView: UIView) {
        contentView.addSubview(postImageContainerView)
        postImageContainerView.addSubview(postImageView)
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            // Post Image Container Constraints
            postImageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Post Image View Constraints
            postImageView.topAnchor.constraint(equalTo: postImageContainerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: postImageContainerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: postImageContainerView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postImageContainerView.bottomAnchor),
            
            // Divider View Constraints
            dividerView.topAnchor.constraint(equalTo: postImageContainerView.bottomAnchor, constant: 8),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


/*
func postImageContainerView() -> UIImageView {
    let view = UIView()
    view.backgroundColor = UIColor.systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view 

}
 
 func createHeaderView() -> UIView {
     let view = UIView()
     view.backgroundColor = .red
     
     return view

 }
 */

/*
class IndividualPostLayoutManager {
    
    let postImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupLayout(in contentView: UIView) {
        contentView.addSubview(postImageContainerView)
        postImageContainerView.addSubview(postImageView)
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            // Post Image Container Constraints
            postImageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageContainerView.heightAnchor.constraint(equalToConstant: 198),
            
            // Post Image View Constraints
            postImageView.topAnchor.constraint(equalTo: postImageContainerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: postImageContainerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: postImageContainerView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postImageContainerView.bottomAnchor),
            
            // Divider View Constraints
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
*/

/*
class IndividualPostLayoutManager {
    
    let captionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupLayout(in contentView: UIView) {
        contentView.addSubview(captionContainerView)
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            // Caption Container Constraints
            captionContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            captionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            captionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            captionContainerView.heightAnchor.constraint(equalToConstant: 198),
            
            // Divider View Constraints
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
*/
