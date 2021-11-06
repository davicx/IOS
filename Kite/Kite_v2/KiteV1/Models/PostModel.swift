//
//  PostModel.swift
//  simpleGetPosts
//
//  Created by Syngenta on 7/16/21.
//

import Foundation

struct PostModel: Codable {
    var postID:Int = 0
    var postFrom:String = ""
    var postTo:String = ""
    var postCaption:String = ""
}

