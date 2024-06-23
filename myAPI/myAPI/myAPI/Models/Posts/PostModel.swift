//
//  PostModel.swift
//  myAPI
//
//  Created by David on 6/22/24.
//

import Foundation


struct PostModel: Codable {
    let postID: Int
    let postType: String
    let groupID: Int
    let listID: Int
    let postFrom: String
    let postTo: String
    let postCaption: String
    let fileName: String
    let fileNameServer: String
    let fileUrl: String
    let cloudKey: String
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    let commentsArray: [CommentModel]
    let postLikesArray: [LikeModel]
    let simpleLikesArray: [String]
}
