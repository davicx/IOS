//
//  Post.swift
//  getPostsSimple
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/2/21.
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
    var postCaption: String = ""
    var fileName: String = ""
    var fileNameServer: String = ""
    var fileUrl: String = ""
    var videoURL: String = ""
    var videoCode: String  = ""
    var created = ""
    var imageMissing = 1

    init(postID: Int) {
        self.postID = postID
    }


}



/*
import Foundation
import UIKit

class Post {
    var postCaption: String
    var postFrom = ""
    var postFromImage: UIImage?
    var imageURL: String
    var imageMissing = 1
    var image: UIImage?
    var postType: String = ""

    init(imageURL: String, postCaption: String) {
        self.imageURL = imageURL
        self.postCaption = postCaption
        
        //Set the Post Image
        let urlKey = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/post_images/\(self.imageURL)"

        if let url = URL(string: urlKey) {
            do {
                let returnedImage = try Data(contentsOf: url)
                self.image = UIImage(data: returnedImage)
                self.imageMissing = 0
            } catch let err {
                self.imageMissing = 1

            }
        }
        
    }
}
*/
