//
//  Post.swift
//  Kite
//
//  Created by David Vasquez on 12/14/24.
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
    var cloudBucket: String?
    var cloudKey: String?
    var videoURL: String?
    var videoCode: String?
    var postDate: String?
    var postTime: String?
    var timeMessage: String?
    var created: String?
    var isLikedByCurrentUser: Bool?
    var commentsArray: [CommentModel]?
    var postLikesArray: [LikeModel]?
    var simpleLikesArray: [String]?
    
    var postImageData: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }
   
}

