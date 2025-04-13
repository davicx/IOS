//
//  NewPostResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 11/19/24.
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
        self.data = PostModel(postID: 0, postType: "", groupID: 0, listID: 0, postFrom: "", postTo: "", postCaption: "", fileName: "", fileNameServer: "", fileURL: "", cloudBucket: "", cloudKey: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "", isLikedByCurrentUser: false, commentsArray: [], postLikesArray: [], simpleLikesArray: [])
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}



