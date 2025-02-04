//
//  Post.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/29/24.
//  Copyright © 2024 David Vasquez. All rights reserved.
//

import UIKit


struct Post {
    var postID: Int
    var image: UIImage
    var title: String
    var likeCount: Int
    
    init(postID: Int, image: UIImage, title: String, likeCount: Int) {
        self.postID = postID
        self.image = image
        self.title = title
        self.likeCount = likeCount
    }
}
