//
//  PostModel.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/14/21.
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
