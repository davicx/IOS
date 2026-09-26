//
//  Functions.swift
//  Posts
//
//  Created by David Vasquez on 9/28/24.
//

import UIKit

private func getImageHeight(image: UIImage) -> CGFloat {
    let aspectRatio = image.size.height / image.size.width
    //let originalImageHeight = image.size.height
    //let originalImageWidth = image.size.width

    let newImageHeight = UIScreen.main.bounds.width * aspectRatio
    //let newImageWidth = UIScreen.main.bounds.width
    
    return newImageHeight
}
