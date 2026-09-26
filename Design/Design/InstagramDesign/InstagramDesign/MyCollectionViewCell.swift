//
//  MyCollectionViewCell.swift
//  InstagramDesign
//
//  Created by David Vasquez on 1/5/25.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    func configure(with cellWords: String) {
        myLabel.text = cellWords
    }
}
