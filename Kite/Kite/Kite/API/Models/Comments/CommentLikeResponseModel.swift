//
//  CommentLikeResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 5/5/25.
//

import UIKit


struct CommentLikeResponseModel: Codable {
    let data: CommentModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = CommentModel(commentID: 0, postID: 0, groupID: 0, listID: 0, commentCaption: "", commentFrom: "", commentType: "", userName: "", imageName: "", firstName: "", lastName: "", commentDate: "", commentTime: "", timeMessage: "", commentLikes: [], created: "", friendshipStatus: "", commentLikeCount: 0, commentLikedByCurrentUser: false)
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}


