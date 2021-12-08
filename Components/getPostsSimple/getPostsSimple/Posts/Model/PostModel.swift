//
//  Posts.swift
//  getPosts
//
//  Created by David Vasquez on 6/7/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

class PostModel: Decodable {
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
    
}
