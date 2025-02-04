//
//  NewPostResponseModel.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
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
        self.data = PostModel(postID: 0, postType: "", groupID: 0, listID: 0, postFrom: "", postTo: "", postCaption: "", fileName: "", fileNameServer: "", fileURL: "", cloudKey: "", videoURL: "", videoCode: "", postDate: "", postTime: "", timeMessage: "", created: "", commentsArray: [], postLikesArray: [], simpleLikesArray: [])
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}
