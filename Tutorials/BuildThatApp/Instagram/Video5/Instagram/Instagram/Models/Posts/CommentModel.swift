//
//  CommentModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


struct CommentModel: Codable {
     let commentID: Int?
     let postID: Int?
     let commentCaption: String?
     let commentFrom: String?
     let commentType: String?
     let userName: String?
     let imageName: String?
     let firstName: String?
     let lastName: String?
     let commentDate: String?
     let commentTime: String?
     let timeMessage: String?
     let commentLikes: [CommentLikeModel]?
     let created: String?
     let friendshipStatus: String?
     let commentLikeCount: Int?
}
