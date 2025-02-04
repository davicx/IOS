//
//  LikePostResponseModel.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/20/24.
//

import Foundation


struct LikePostResponseModel: Codable {
    let data: LikeModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
 
    init() {
        self.data = LikeModel(postLikeID: 0, postID: 0, likedByUserName: "", likedByImage: "", likedByFirstName: "", likedByLastName: "", timestamp: "", friendshipStatus: "")
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


/*
 struct LikeModel: Codable {
     let postLikeID: Int
     let postID: Int
     let likedByUserName: String
     let likedByImage: String
     let likedByFirstName: String
     let likedByLastName: String
     let timestamp: String
     let friendshipStatus: String
 }

 
 init() {
     self.message = ""
     self.success = false
     self.statusCode = 500
     self.errors = []
     self.currentUser = ""
 }
  
 {
     "data": {
         "postLikeID": 231,
         "postID": 72,
         "likedByUserName": "davey",
         "likedByImage": "frodo.jpg",
         "likedByFirstName": "davey v",
         "likedByLastName": "davey v",
         "timestamp": "2024-07-24T23:19:08.000Z",
         "friendshipStatus": "not_friends"
     },
     "message": "You liked this post!",
     "success": false,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
