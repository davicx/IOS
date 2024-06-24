//
//  Post.swift
//  postsTableView
//
//  Created by David on 6/23/24.
//

import Foundation
import UIKit

class Post {
    var image: UIImage
    var caption: String
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
}
