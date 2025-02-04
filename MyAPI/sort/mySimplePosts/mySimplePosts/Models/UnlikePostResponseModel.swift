//
//  UnlikePostResponseModel.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/20/24.
//

import Foundation


struct UnlikePostResponseModel: Codable {
    let data: [UnlikePostModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}

struct UnlikePostModel: Codable {
    let postLikeID: String
}
