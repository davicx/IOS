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
    var fileUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240705T205811Z&X-Amz-Expires=259200&X-Amz-Signature=110084e7a25eedef956d838ec44ca8a3af969e2819e2a24a4d3c0eb042004446&X-Amz-SignedHeaders=host&x-id=GetObject"
    var postImage: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }
    


}
