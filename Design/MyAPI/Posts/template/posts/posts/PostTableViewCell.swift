//
//  PostTableViewCell.swift
//  posts
//
//  Created by David Vasquez on 8/24/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    var currentUser = "davey"
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postCommentsImage: UIImageView!
    @IBOutlet weak var postCommentsLabel: UILabel!
    @IBOutlet weak var postLikeImage: UIImageView!
    @IBOutlet weak var postLikeLabel: UILabel!

    func setPost(post: Post) {
        let likeCount : Int = post.simpleLikesArray?.count ?? 0
        let simpleLikesArray : Array = post.simpleLikesArray ?? []
        
        postImage.image = post.postImageData
        postCaptionLabel.text = post.postCaption
        postCommentsImage.image = UIImage(named: "like")
        postCommentsLabel.text = "1"
        postLikeLabel.text = String(likeCount)
        
        //Like Button
        if simpleLikesArray.contains(currentUser) {
            postLikeImage.image = UIImage(named: "liked")
          
        } else {
            postLikeImage.image = UIImage(named: "like")
          
        }
    }
     
    
}

