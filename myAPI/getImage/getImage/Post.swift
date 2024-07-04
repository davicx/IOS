//
//  Post.swift
//  getImage
//
//  Created by David on 6/30/24.
//

import UIKit


class Post {
    let postID: Int
    var postFrom = "davey"
    var postCaption = "hiya there! wanna garden!"
    //var fileUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"
    var fileUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240704%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240704T220000Z&X-Amz-Expires=3600&X-Amz-Signature=9c76d5df6edc245ebc60bb27b806d982fceacf0324850bcc14333cf446e31b4b&X-Amz-SignedHeaders=host&x-id=GetObject"
    var postImage: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }
    


}
