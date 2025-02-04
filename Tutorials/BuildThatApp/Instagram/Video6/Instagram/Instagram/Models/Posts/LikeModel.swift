//
//  LikeModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

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
