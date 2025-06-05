//
//  CommentModel.swift
//  Kite
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


struct CommentModel: Codable {
     let commentID: Int?
     let postID: Int?
     let groupID: Int?
     let listID: Int?
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
     let friendshipStatus: Int? 
     let commentLikeCount: Int?
     let commentLikedByCurrentUser: Bool?
     
}


