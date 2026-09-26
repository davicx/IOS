//
//  PostResponseModel.swift
//  Kite
//
//  Created by Syngenta on 11/20/21.
//

import Foundation

struct PostResponseModel: Codable {
    var outcome:Int = 0
    var postID:Int = 0
    var errors:Array = ["no worky"]
}
