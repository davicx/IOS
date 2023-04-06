//
//  PostModel.swift
//  designLoginThree
//
//  Created by David on 4/5/23.
//

import Foundation

struct Post: Codable {
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
    let videoURL: String
    let videoCode: String
    let created: String
    
    let commentsArray: [String]
    let postLikesArray: [String]
    
    let simpleLikesArray: [String]
}

/*
 Comment
    CommentLike

PostLike
 
 */
