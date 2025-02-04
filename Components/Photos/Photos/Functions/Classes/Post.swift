//
//  Post.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
//

import UIKit


class Post {
    var postID: Int
    var postType: String?
    var groupID: Int?
    var listID: Int?
    var postFrom: String?
    var postTo: String?
    var postCaption: String?
    var fileName: String?
    var fileNameServer: String?
    var fileUrl: String?
    var cloudKey: String?
    var videoURL: String?
    var videoCode: String?
    var postDate: String?
    var postTime: String?
    var timeMessage: String?
    var created: String?
    var commentsArray: [CommentModel]?
    var postLikesArray: [LikeModel]?
    var simpleLikesArray: [String]?
    
    var postImageData: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }
   
}

