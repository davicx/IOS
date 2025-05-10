//
//  CommentLikeResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 5/5/25.
//

import UIKit


struct CommentLikeResponseModel: Codable {
    let data: CommentLikeModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = CommentLikeModel(commentLikeID: 0, commentID: 0, likedByUserName: "", likedByImage: "", likedByFirstName: "", likedByLastName: "", commentCreated: "")
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}




