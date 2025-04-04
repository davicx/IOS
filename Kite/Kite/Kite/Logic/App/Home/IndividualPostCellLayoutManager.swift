//
//  IndividualPostCellLayoutManager.swift
//  Kite
//
//  Created by David Vasquez on 3/24/25.
//


import UIKit



class IndividualPostCellLayoutManager {
    
    private let postUserView = PostUserView()

    func setupLayout(in contentView: UIView) {
        if postUserView.superview == nil { // Prevent duplicate adding
            contentView.addSubview(postUserView)
        }
        
        NSLayoutConstraint.activate([
            postUserView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postUserView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postUserView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postUserView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}



/*
class IndividualPostCellLayoutManager {
    
    let userImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        return view
    }()
    
    let postView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray
        return view
    }()
    
    func setupLayout(in contentView: UIView) {
        contentView.addSubview(userImageView)
        contentView.addSubview(postView)
        
        // Enable Auto Layout
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        postView.translatesAutoresizingMaskIntoConstraints = false
        
        // Apply constraints
        NSLayoutConstraint.activate([
            // UserImageView - Fixed width of 100, min height 200
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            // PostView - Takes remaining space, min height 200
            postView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor),
            postView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
}
 */



//ADJUST FOR IPAD NEW USE!!
/*
 import UIKit

 class IndividualPostCellLayoutManager {
     
     let userImageView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.systemBlue
         return view
     }()
     
     let postView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.systemGray
         return view
     }()
     
     func setupLayout(in contentView: UIView) {
         contentView.addSubview(userImageView)
         contentView.addSubview(postView)
         
         // Enable Auto Layout
         userImageView.translatesAutoresizingMaskIntoConstraints = false
         postView.translatesAutoresizingMaskIntoConstraints = false
         
         // Determine width based on device type
         let userImageWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 140 : 100
         
         // Apply constraints
         NSLayoutConstraint.activate([
             // UserImageView - Adjust width for iPhone or iPad, min height 200
             userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             userImageView.widthAnchor.constraint(equalToConstant: userImageWidth),
             userImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
             
             // PostView - Takes remaining space, min height 200
             postView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor),
             postView.topAnchor.constraint(equalTo: contentView.topAnchor),
             postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             postView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
         ])
     }
 }

 */
