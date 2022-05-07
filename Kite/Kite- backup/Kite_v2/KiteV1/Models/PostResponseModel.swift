//
//  PostResponseModel.swift
//  KiteV1
//
//  Created by Syngenta on 9/13/21.
//

import Foundation

struct PostResponseModel: Codable {
    var outcome:Int = 0
    var postID:Int = 0
    var errors:Array = ["no worky"]
}
