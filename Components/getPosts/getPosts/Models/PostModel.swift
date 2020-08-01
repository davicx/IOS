//
//  Posts.swift
//  getPosts
//
//  Created by David Vasquez on 6/7/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

class PostModel: Decodable {
    let post_id: String
    let post_from: String
    let post_to: String
    let post_type: String
    let post_caption: String
    let image_url: String
    let video_code: String
    let posted_time_message: String

}
