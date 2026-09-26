//
//  CommentModel.swift
//  designLoginThree
//
//  Created by David on 4/7/23.
//

import Foundation

struct CommentModel: Codable {
    let commentID: Int
    let postID: Int
    
    let commentCaption: String
    let commentFrom: String
    let userName: String
    let imageName: String
    let firstName: String
    let lastName: String

    let commentLikes: [CommentLikeModel]
    
    let created: String
    let commentLikeCount: Int
}


/*
 "commentID": 2,
  "postID": 72,
  "commentCaption": "Cool how fun! ",
  "commentFrom": "sam",
  "userName": "sam",
  "imageName": "frodo.jpg",
  "firstName": "sam gamgee",
  "lastName": "sam gamgee",
  "commentLikes": [
 

 */
