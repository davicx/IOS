//
//  Functions.swift
//  Kite
//
//  Created by David Vasquez on 12/7/24.
//


import UIKit



//Image Functions
func getImageHeight(currentImage: UIImage) -> Float {
    
    //Get Image Size
    let currentImageHeight = currentImage.size.height
    let currentImageWidth = currentImage.size.width
    print("Image Height \(currentImageHeight) Image Width \(currentImageWidth)")

    //Get Screen
    let screenSize: CGRect = UIScreen.main.bounds
    let phoneWidth = screenSize.width
    print("Screen Width \(phoneWidth) Screen Height \(screenSize.height)")

    //Get Image Size
    let imageCrop = currentImage.getCropRatio()
    //let imageHeight = tableView.frame.width / imageCrop
    let imageHeight = phoneWidth / imageCrop
    let imageWidth = screenSize.width
    
    print("New Image Height \(imageHeight) New Image Width \(imageWidth)")

    
    print(screenSize)

    return Float(currentImageHeight)
}



