//
//  PostModel.swift
//  Kite
//
//  Created by Syngenta on 11/20/21.
//

import Foundation

struct PostModel: Codable {
    var postID:Int = 0
    var postType:String = ""
    var groupID:Int = 0
    var listID:Int = 0
    var postFrom:String = ""
    var postTo:String = ""
    var postCaption:String = ""
    var fileName:String = ""
    var fileNameServer:String = ""
    var videoURL:String = ""
    var videoCode:String = ""
    var created:String = ""
}
