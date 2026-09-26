//
//  LikePostResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
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
