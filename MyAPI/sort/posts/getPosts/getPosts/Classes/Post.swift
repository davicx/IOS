//
//  Post.swift
//  getPosts
//
//  Created by David Vasquez on 6/8/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var postCaption: String
    var postFrom = ""
    var postFromImage: UIImage?
    var imageURL: String
    var imageMissing = 1
    var image: UIImage?
    var postType: String = ""

    init(imageURL: String, postCaption: String) {
        self.imageURL = imageURL
        self.postCaption = postCaption
        
        //Set the Post Image
        let urlKey = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/post_images/\(self.imageURL)"

        if let url = URL(string: urlKey) {
            do {
                let returnedImage = try Data(contentsOf: url)
                self.image = UIImage(data: returnedImage)
                self.imageMissing = 0
            } catch let err {
                self.imageMissing = 1

            }
        }
        
    }
}
