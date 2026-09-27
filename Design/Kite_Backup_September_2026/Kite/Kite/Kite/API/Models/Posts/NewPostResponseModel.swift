//
//  NewPostResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 11/19/24.
//

import Foundation


//WISHLIST
struct NewPostResponseModel: Codable {
    let data: PostModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = PostModel(postID: 0, postType: "", groupID: 0, groupName: "", groupImage: "", listID: 0, postFrom: "", postFromImage: "", postTo: "", postCaption: "", fileName: "", fileNameServer: "", fileURL: "", cloudBucket: "", cloudKey: "", storageType: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "", isLikedByCurrentUser: false, commentsArray: [], postLikesArray: [], simpleLikesArray: [], item: nil)
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}


//KITE
/*
 struct NewPostResponseModel: Codable {
     let data: PostModel
     let message: String
     let success: Bool
     let statusCode: Int
     let errors: [String]
     let currentUser: String
     
     init() {
         self.data = PostModel(postID: 0, postType: "", groupID: 0, groupName: "", groupImage: "", listID: 0, postFrom: "", postFromImage: "", postTo: "", postCaption: "", fileName: "", fileNameServer: "", fileURL: "", cloudBucket: "", cloudKey: "", storageType: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "", isLikedByCurrentUser: false, commentsArray: [], postLikesArray: [], simpleLikesArray: [])
         self.message = ""
         self.success = false
         self.statusCode = 500
         self.errors = []
         self.currentUser = ""
     }
     
 }

 
 */


