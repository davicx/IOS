//
//  PostModel.swift
//  sendFormDataToAPI
//
//  Created by David Vasquez on 8/12/24.
//

import Foundation


struct PostModel: Codable {
    let postID: Int
    let postType: String
    let groupID: Int
    let listID: Int
    let postFrom: String
    let postTo: String
    let postCaption: String
    let fileName: String
    let fileNameServer: String
    let fileURL: String
    let cloudKey: String
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    //These are not right
    let commentsArray: [String]
    let postLikesArray: [String]
    let simpleLikesArray: [String]
}
