//
//  Functions.swift
//  ViewWithImageSubview
//
//  Created by David Vasquez on 10/8/24.
//

import UIKit




func printImageSize(currentImage: UIImage) {
    let aspectRatio = currentImage.size.height / currentImage.size.width

    let originalImageHeight = currentImage.size.height
    let originalImageWidth = currentImage.size.width

    let newImageHeight = UIScreen.main.bounds.width * aspectRatio
    let newImageWidth = UIScreen.main.bounds.width
    
    print("originalImageHeight \(originalImageHeight)")
    print("originalImageWidth \(originalImageWidth)")
    print("newImageHeight \(newImageHeight)")
    print("newImageWidth \(newImageWidth)")
  
    
}


// Function to get the image aspect ratio (height / width)
func getImageRatio(image: UIImage) -> CGFloat {
    return image.size.height / image.size.width
}


