//
//  Functions.swift
//  Posts
//
//  Created by David Vasquez on 9/28/24.
//

import UIKit

func getImageHeight(image: UIImage) -> CGFloat {
    let aspectRatio = image.size.height / image.size.width
    //let originalImageHeight = image.size.height
    //let originalImageWidth = image.size.width

    let newImageHeight = UIScreen.main.bounds.width * aspectRatio
    //let newImageWidth = UIScreen.main.bounds.width
    
    return newImageHeight
}


func calculateLabelHeight(text: String, font: UIFont = UIFont.systemFont(ofSize: 20), width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
    let label = UILabel()
    label.numberOfLines = 0 
    label.font = font
    
    let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    
    let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
    let boundingRect = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: textAttributes, context: nil)
    
    return ceil(boundingRect.height)
}
