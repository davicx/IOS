//
//  Post.swift
//  learningJSON
//
//  Created by David Vasquez on 5/16/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}
