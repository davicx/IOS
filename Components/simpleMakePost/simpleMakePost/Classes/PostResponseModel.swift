//
//  PostResponseModel.swift
//  simpleMakePost
//
//  Created by Syngenta on 7/16/21.
//

import Foundation

struct PostResponseModel: Codable {
    var outcome:Int = 0
    var postID:Int = 0
    var errors:Array = ["worky"]
}

