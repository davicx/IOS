//
//  WordCell.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/4/24.
//

import UIKit

class WordCell: UICollectionViewCell {
    
    //this gets called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    

    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     
    func setupViews() {
        backgroundColor = .blue
        
        addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}
