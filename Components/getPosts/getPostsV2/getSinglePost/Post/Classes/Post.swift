//
//  Post.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/16/21.
//

import Foundation
import UIKit

class Post {
    var postID: Int
    var postType: String = ""
    var groupID = 0
    var listID = 0
    var postFrom: String = ""
    var postTo: String = ""
    var postCaption: String
    var postImage: UIImage?
    var fileName: String = ""
    var fileNameServer: String = ""
    var fileUrl: String = ""
    var videoURL: String = ""
    var videoCode: String  = ""
    var created = ""
    var imageMissing = 1

    init(postID: Int, postCaption: String) {
        self.postID = postID
        self.postCaption = postCaption
    }
}


