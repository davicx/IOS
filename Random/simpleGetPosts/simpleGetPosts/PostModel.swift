//
//  PostModel.swift
//  simpleGetPosts
//
//  Created by David Vasquez on 5/15/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import Foundation

class PostModel: Decodable {
    let userId: String
    let id: String
    let body: String
    
}


/*
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "q
 */
