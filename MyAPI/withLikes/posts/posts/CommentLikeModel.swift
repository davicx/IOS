//
//  CommentLikeModel.swift
//  posts
//
//  Created by David Vasquez on 8/22/24.
//

import Foundation


struct CommentLikeModel: Codable {
    let commentLikeID: Int
    let commentID: Int
    let likedByUserName: String
    let likedByImage: String
    let likedByFirstName: String
    let likedByLastName: String
    let commentCreated: String
}

