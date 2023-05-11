//
//  PostModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/23/22.
//

import Foundation

struct PostModel: Codable {
    var postID: Int
    var postType: String
    var groupID: Int
    var listID: Int
    var postFrom: String
    var postTo: String
    var postCaption: String
    var fileName: String
    var fileNameServer: String
    var fileUrl: String
    var videoURL: String
    var videoCode: String
    var created: String
}



















/*
struct PostModel: Codable {
    let userName: String
    let caption: String    
}
 var postFrom: String
 var postID": 254,
 var postType": "text",
 var groupID": 77,
 var listID": 0,
 var postFrom": "davey",
 var postTo": "frodo",
 var postCaption": "Hiya Frodo!!!!!",
 var fileName": "",
 var fileNameServer": "hiya.jpg",
 var fileUrl": "empty",
 var videoURL": "empty",
 var videoCode": "empty",
 var created": "2021-12-19T08:14:03.000Z"
}
 */

