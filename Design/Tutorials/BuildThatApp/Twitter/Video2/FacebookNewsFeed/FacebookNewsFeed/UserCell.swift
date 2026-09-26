//
//  UserCell.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/12/24.
//


import UIKit


class UserCell: UICollectionViewCell {
    
    //this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    

    let wordLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     
    func setupViews() {
        backgroundColor = .yellow
        
        addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}
