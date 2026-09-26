//
//  LikeModel.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
//

import UIKit


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


