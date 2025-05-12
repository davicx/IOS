//
//  Comment.swift
//  Kite
//
//  Created by David Vasquez on 12/14/24.
//

import UIKit



class Comment: Codable {
    var commentID: Int?
    var postID: Int?
    var groupID: Int?
    var listID: Int?
    var commentCaption: String?
    var commentFrom: String?
    var commentType: String?
    var userName: String?
    var imageName: String?
    var firstName: String?
    var lastName: String?
    var commentDate: String?
    var commentTime: String?
    var timeMessage: String?
    var commentLikes: [CommentLikeModel]?
    var created: String?
    var friendshipStatus: String?
    var commentLikeCount: Int?
    var commentLikedByCurrentUser: Bool?
    
    init(
        commentID: Int? = nil,
        postID: Int? = nil,
        groupID: Int? = nil,
        listID: Int? = nil,
        commentCaption: String? = nil,
        commentFrom: String? = nil,
        commentType: String? = nil,
        userName: String? = nil,
        imageName: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        commentDate: String? = nil,
        commentTime: String? = nil,
        timeMessage: String? = nil,
        commentLikes: [CommentLikeModel]? = nil,
        created: String? = nil,
        friendshipStatus: String? = nil,
        commentLikeCount: Int? = nil,
        commentLikedByCurrentUser: Bool? = nil
    ) {
        self.commentID = commentID
        self.postID = postID
        self.groupID = groupID
        self.listID = listID
        self.commentCaption = commentCaption
        self.commentFrom = commentFrom
        self.commentType = commentType
        self.userName = userName
        self.imageName = imageName
        self.firstName = firstName
        self.lastName = lastName
        self.commentDate = commentDate
        self.commentTime = commentTime
        self.timeMessage = timeMessage
        self.commentLikes = commentLikes
        self.created = created
        self.friendshipStatus = friendshipStatus
        self.commentLikeCount = commentLikeCount
        self.commentLikedByCurrentUser = commentLikedByCurrentUser
    }
}
