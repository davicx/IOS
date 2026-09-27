//
//  CommentLike.swift
//  Kite
//
//  Created by David Vasquez on 5/23/25.
//


import UIKit

class CommentLike: Codable {
    var commentLikeID: Int
    var commentID: Int
    var likedByUserName: String
    var likedByImage: String
    var likedByFirstName: String
    var likedByLastName: String
    var commentCreated: String

    init(
        commentLikeID: Int,
        commentID: Int,
        likedByUserName: String,
        likedByImage: String,
        likedByFirstName: String,
        likedByLastName: String,
        commentCreated: String
    ) {
        self.commentLikeID = commentLikeID
        self.commentID = commentID
        self.likedByUserName = likedByUserName
        self.likedByImage = likedByImage
        self.likedByFirstName = likedByFirstName
        self.likedByLastName = likedByLastName
        self.commentCreated = commentCreated
    }
}
