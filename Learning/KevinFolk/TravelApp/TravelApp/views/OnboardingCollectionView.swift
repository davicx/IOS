//
//  OnboardingCollectionView.swift
//  TravelApp
//
//  Created by David Vasquez on 3/4/24.
//

import UIKit


class OnboardingColledtionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
    
}
