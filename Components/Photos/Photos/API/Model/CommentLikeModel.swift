//
//  CommentLikeModel.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
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

