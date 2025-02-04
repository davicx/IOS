//
//  CustomCell.swift
//  CollectionViewProgrammatic
//
//  Created by David Vasquez on 10/3/24.
//

import UIKit

class CustomCell: UICollectionViewCell {
    let myImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        addSubview(myImageView)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false

         //Set Layout
         NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            myImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            myImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            //myImageView.widthAnchor.constraint(equalToConstant: 50),
            myImageView.heightAnchor.constraint(equalToConstant: 50)
         ])
         
        //myImageView.translatesAutoresizingMaskIntoConstraints = false
        //myImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //myImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        //myImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //myImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        myImageView.layer.cornerRadius = 20
        myImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
}
