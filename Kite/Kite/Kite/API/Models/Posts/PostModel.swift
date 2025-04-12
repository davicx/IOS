//
//  PostModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


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
    let fileURL: String
    
    let cloudBucket: String
    let cloudKey: String
    
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    var isLikedByCurrentUser: Bool
    let commentsArray: [CommentModel]
    let postLikesArray: [LikeModel]
    let simpleLikesArray: [String]
    
}

/*
 "data": [
     {

         "cloudKey": "no_cloud_key",
         "videoURL": "empty",
         "videoCode": "empty",
         "postDate": "02/25/2025",
         "postTime": "3:030 pm",
         "timeMessage": "3 days ago",
         "created": "2025-02-25T23:30:03.000Z",
         "commentsArray": [],
         "postLikesArray": [],
         "simpleLikesArray": []
     },
   
 ],
 */

