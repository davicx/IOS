//
//  Post.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/7/24.
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


/*
 struct PostModel: Codable {


    let : String
    let : String
    let : String
    let : String
    let : String
    let commentsArray:

}
 class Post {

     
     
     let fileUrl: String?
     let cloudKey: String?
     let videoURL: String?
     let videoCode: String?
     let postDate: String?
     let postTime: String?
     let timeMessage: String?
     let created: String?
     let commentsArray: [CommentModel]?
     let postLikesArray: [LikeModel]?
     let simpleLikesArray: [String]?
     
     var postImageData: UIImage?
     
     
     init(postID: Int) {
         self.postID = postID
     }
    
 }

 
 struct PostModel: Codable {
    let postID: Int
    let postType: String
    let groupID: Int
    let listID: Int
    let postFrom: String
    let postTo: String
    let postCaption: String
    let fileName: String
    let fileNameServer: String
    let fileUrl: String
    let cloudKey: String
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    let commentsArray: [CommentModel]
    let postLikesArray: [LikeModel]
    let simpleLikesArray: [String]
}
*/
