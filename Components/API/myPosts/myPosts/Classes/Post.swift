//
//  Post.swift
//  myPosts
//
//  Created by David Vasquez on 11/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//


import Foundation
import UIKit

struct Post {
    var postID: Int
    var postCaption: String
    var postImage: UIImage
    var postLikeStatus: Int
    var postShareStatus: Int
    
    init(postID: Int, postCaption: String, postImage: UIImage, postLikeStatus: Int, postShareStatus: Int) {
        self.postID = postID
        self.postCaption = postCaption
        self.postImage = postImage
        self.postLikeStatus = postLikeStatus
        self.postShareStatus = postShareStatus
    }
    
}

