//
//  LikeMode.swift
//  postsTableView
//
//  Created by David on 6/23/24.
//

import Foundation

import Foundation


struct LikeModel: Codable {
    let postLikeID: Int
    let postID: Int
    let likedByUserName: String
    let likedByImage: String
    let likedByFirstName: String
    let likedByLastName: String
    let timestamp: String
    let friendshipStatus: String
}
