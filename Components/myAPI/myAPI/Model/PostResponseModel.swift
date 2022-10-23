//
//  PostResponseModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/25/22.
//

import Foundation

struct PostResponseModel: Codable {
    var posts: [PostModel]
}

/*
"postID": 254,
"postType": "text",
"groupID": 77,
"listID": 0,
"postFrom": "davey",
"postTo": "frodo",
"postCaption": "Hiya Frodo!!!!!",
"fileName": "",
"fileNameServer": "hiya.jpg",
"fileUrl": "empty",
"videoURL": "empty",
"videoCode": "empty",
"created": "2021-12-19T08:14:03.000Z"
*/
