//
//  LikeModel.swift
//  Kite
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


struct LikeModel: Codable {
    let postLikeID: Int
    let postID: Int
    let likedByUserName: String
    let likedByImage: String
    let likedByFirstName: String
    let likedByLastName: String
    let timestamp: String
    let friendshipStatus: Int //CONFIRM STRING OR INT 
    
}

/*
 {
     "data": {
         "postLikeID": 350,
         "postID": 722,
         "likedByUserName": "",
         "likedByImage": "",
         "likedByFirstName": "",
         "likedByLastName": "",
         "timestamp": "",
         "friendshipStatus": ""
     },
     "message": "The Post Like was removed",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */

