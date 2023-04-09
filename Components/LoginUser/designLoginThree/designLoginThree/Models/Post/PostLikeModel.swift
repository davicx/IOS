//
//  PostLikeModel.swift
//  designLoginThree
//
//  Created by David on 4/7/23.
//

import Foundation

struct PostLikeModel: Codable {
    let postLikeID: Int
    let postID: Int
    
    let likedByUserName: String
    let likedByImage: String
    let likedByFirstName: String
    let likedByLastName: String
    let timestamp: String
}
