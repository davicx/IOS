//
//  PostModel.swift
//  designLoginThree
//
//  Created by David on 4/5/23.
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
    let fileUrl: String
    let videoURL: String
    let videoCode: String
    let created: String
    
    let commentsArray: [CommentModel]
    
    let postLikesArray: [PostLikeModel]
    let simpleLikesArray: [String]
    
}


/*
 {
     "posts": [
         {
             "postID": 72,
             "postType": "text",
             "groupID": 72,
             "listID": 0,
             "postFrom": "davey",
             "postTo": "frodo",
             "postCaption": "Hiya Frodo!! The weather is perfect! wanna hike or we could garden!!!!",
             "fileName": "",
             "fileNameServer": "hiya.jpg",
             "fileUrl": "empty",
             "videoURL": "empty",
             "videoCode": "empty",
             "created": "2021-12-19T00:14:03.000Z",
             "postLikesArray": [
                 {
                     "postLikeID": 93,
                     "postID": 72,
                     "likedByUserName": "sam",
                     "likedByImage": "frodo.jpg",
                     "likedByFirstName": "sam gamgee",
                     "likedByLastName": "sam gamgee",
                     "timestamp": "2023-02-21T00:42:33.000Z"
                 },
                 {
                     "postLikeID": 95,
                     "postID": 72,
                     "likedByUserName": "bilbo",
                     "likedByImage": "frodo.jpg",
                     "likedByFirstName": "Bilbo v",
                     "likedByLastName": "Bilbo v",
                     "timestamp": "2023-02-21T00:42:43.000Z"
                 },
                 {
                     "postLikeID": 96,
                     "postID": 72,
                     "likedByUserName": "frodo",
                     "likedByImage": "frodo.jpg",
                     "likedByFirstName": "frodo v",
                     "likedByLastName": "frodo v",
                     "timestamp": "2023-02-21T00:42:47.000Z"
                 },
                 {
                     "postLikeID": 185,
                     "postID": 72,
                     "likedByUserName": "davey",
                     "likedByImage": "frodo.jpg",
                     "likedByFirstName": "davey v",
                     "likedByLastName": "davey v",
                     "timestamp": "2023-03-31T00:13:52.000Z"
                 }
             ],
             "simpleLikesArray": [
                 "sam",
                 "bilbo",
                 "frodo",
                 "davey"
             ]
         }
     ],
     "postCount": "get me 10",
     "success": true,
     "message": "Need to add error and stuff in this always works!",
     "statusCode": 200,
     "errors": [],
     "currentUser": "Get from middles"
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
     let videoURL: String
     let videoCode: String
     let created: String
     
     let commentsArray: [CommentModel]
 
     let postLikesArray: [PostLikeModel]
     let simpleLikesArray: [String]
 }
 */
