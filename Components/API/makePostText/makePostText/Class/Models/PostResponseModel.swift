//
//  PostResponseModel.swift
//  makePostText
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/7/21.
//

import Foundation

struct PostResponseModel: Codable {
    var outcome:Int = 0
    var postID:Int = 0
    var errors:Array = ["worky"]
}

