//
//  PostResponseModel.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/7/24.
//

import Foundation


struct PostResponseModel: Codable {
    let data: [PostModel]
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
