//
//  CommentLikeModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


struct CommentLikeModel: Codable {
    var commentLikeID: Int
    var commentID: Int
    var likedByUserName: String
    var likedByImage: String
    var likedByFirstName: String
    var likedByLastName: String
    var commentCreated: String
}

