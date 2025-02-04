//
//  NewPostResponseModel.swift
//  sendFormDataToAPI
//
//  Created by David Vasquez on 8/12/24.
//

import Foundation


struct NewPostResponseModel: Codable {
    let data: PostModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = PostModel(postID: 0, postType: "", groupID: "0", listID: "0", postFrom: "", postTo: "", postCaption: "", fileName: "", fileNameServer: "", fileURL: "", cloudKey: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "", commentsArray: [], postLikesArray: [], simpleLikesArray: [])
        //self.data = PostModel(postID: 0, postType: "", groupID: "0", listID: "0", postFrom: "", postTo: "", postCaption: "", fileame: "", fileNameServer: "", fileURL: "", cloudKey: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "")
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}




    /*
     {
         "data": {
             "postID": 529,
             "postType": "photo",
             "groupID": "70",
             "listID": "0",
             "postFrom": "davey",
             "postTo": "sam",
             "postCaption": "Hiya wanna garden! ",
             "fileName": "lake_png.png",
             "fileNameServer": "postImage-1723680260558-110240378-lake_png.png",
             "fileUrl": "uploads/postImage-1723680260558-110240378-lake_png.png",
             "cloudKey": "local_cloud_key",
             "videoURL": "empty",
             "videoCode": "empty",
             "postDate": "08/14/2024",
             "postTime": "5:4 pm",
             "timeMessage": "a few seconds ago",
             "created": "",
             "commentsArray": [],
             "postLikesArray": [],
             "simpleLikesArray": []
         },
         "message": "Your photo was posted!",
         "success": true,
         "statusCode": 200,
         "errors": [],
         "currentUser": "davey"
     }
     */

