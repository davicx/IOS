//
//  Post.swift
//  getImage
//
//  Created by David on 6/30/24.
//

import UIKit


class Post {
    let postID: Int
    var postFrom = ""
    var postCaption = "hi"
    var fileUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"
    //var fileUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975390703-820924480-city.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240701%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240701T000623Z&X-Amz-Expires=3600&X-Amz-Signature=40d0c32f0b8ca4fa961bf19c587f26fcf32bce7957194c616d0bc06ad871dc6d&X-Amz-SignedHeaders=host&x-id=GetObject"
    var postImage: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }
    


}
