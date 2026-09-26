//
//  PostResponseModel.swift
//  designLoginThree
//
//  Created by David on 4/7/23.
//

import Foundation

import Foundation

struct PostResponseModel: Codable {
    let posts: [PostModel]
    let postCount: String
    let success: Bool
    let message: String
    let statusCode: Int
    let errors: [String]
    let currentUser: String
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
            "commentsArray": [
                {
                    "commentID": 2,
                    "postID": 72,
                    "commentCaption": "Cool how fun! ",
                    "commentFrom": "sam",
                    "userName": "sam",
                    "imageName": "frodo.jpg",
                    "firstName": "sam gamgee",
                    "lastName": "sam gamgee",
                    "commentLikes": [
                        {
                            "commentLikeID": 28,
                            "commentID": 2,
                            "likedByUserName": "sam",
                            "likedByImage": "frodo.jpg",
                            "likedByFirstName": "sam gamgee",
                            "likedByLastName": "sam gamgee",
                            "commentCreated": "2023-03-12T01:00:25.000Z"
                        },
                        {
                            "commentLikeID": 29,
                            "commentID": 2,
                            "likedByUserName": "bilbo",
                            "likedByImage": "frodo.jpg",
                            "likedByFirstName": "Bilbo v",
                            "likedByLastName": "Bilbo v",
                            "commentCreated": "2023-03-12T01:00:29.000Z"
                        }
                    ],
                    "created": "2021-11-22T07:39:11.000Z",
                    "commentLikeCount": 2
                },
                {
                    "commentID": 122,
                    "postID": 72,
                    "commentCaption": "Hiya Frodo!! The weather is perfect! wanna hike or we could garden!",
                    "commentFrom": "davey",
                    "userName": "davey",
                    "imageName": "frodo.jpg",
                    "firstName": "davey v",
                    "lastName": "davey v",
                    "commentLikes": [
                        {
                            "commentLikeID": 78,
                            "commentID": 122,
                            "likedByUserName": "davey",
                            "likedByImage": "frodo.jpg",
                            "likedByFirstName": "davey v",
                            "likedByLastName": "davey v",
                            "commentCreated": "2023-03-28T00:16:24.000Z"
                        }
                    ],
                    "created": "2023-03-28T00:15:37.000Z",
                    "commentLikeCount": 1
                },
                {
                    "commentID": 123,
                    "postID": 72,
                    "commentCaption": "OHHHH Hiya Frodo!! The weather is perfect! wanna hike or we could garden!",
                    "commentFrom": "davey",
                    "userName": "davey",
                    "imageName": "frodo.jpg",
                    "firstName": "davey v",
                    "lastName": "davey v",
                    "commentLikes": [],
                    "created": "2023-03-28T00:15:54.000Z",
                    "commentLikeCount": 0
                }
            ],
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
*/
