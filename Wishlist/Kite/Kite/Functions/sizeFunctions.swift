//
//  sizeFunctions.swift
//  Kite
//
//  Created by David Vasquez on 7/11/25.
//

import UIKit

class sizeFunctions {
    static func calculatePostImageHeight(from image: UIImage?) -> CGFloat {
        let fallbackImage = UIImage(named: "background_1") ?? UIImage()
        let imageToUse = image ?? fallbackImage
        return round(getImageHeight(image: imageToUse))
    }

    static func calculatePostCaptionHeight(from caption: String?) -> CGFloat {
        let captionText = caption ?? "no caption"
        return round(calculateLabelHeight(text: captionText))
    }
    
    static func calculateCommentCaptionHeight(from caption: String?) -> CGFloat {
        let captionText = caption ?? "no comment"
        return round(calculateLabelHeight(text: captionText, font: UIFont.systemFont(ofSize: 14)))
    }
}
