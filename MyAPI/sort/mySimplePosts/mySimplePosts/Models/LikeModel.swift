//
//  LikeModel.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/7/24.
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

//let vga = Resolution(width: 640, height: 480)

