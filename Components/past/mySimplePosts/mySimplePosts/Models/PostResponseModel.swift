//
//  PostResponseModel.swift
//  mySimplePosts
//
//  Created by David on 6/30/24.
//

import Foundation


struct PostResponseModel: Codable {
    let data: [PostModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
}
