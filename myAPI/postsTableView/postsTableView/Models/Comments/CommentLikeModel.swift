//
//  CommentLikeModel.swift
//  postsTableView
//
//  Created by David on 6/23/24.
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

