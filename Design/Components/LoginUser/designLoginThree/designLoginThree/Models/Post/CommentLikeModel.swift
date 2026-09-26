//
//  CommentLikeModel.swift
//  designLoginThree
//
//  Created by David on 4/7/23.
//

import Foundation

struct CommentLikeModel: Codable {
    let commentLikeID: Int
    let commentID: Int
    
    let likedByUserName: String
    let likedByImage: String
    let likedByFirstName: String
    let likedByLastName: String
    let commentCreated: String
}


/*
"commentLikeID": 28,
"commentID": 2,
 
"likedByUserName": "sam",
"likedByImage": "frodo.jpg",
"likedByFirstName": "sam gamgee",
"likedByLastName": "sam gamgee",
"commentCreated": "2023-03-12T01:00:25.000Z"
 */
