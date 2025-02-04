//
//  PostTableViewCell.swift
//  posts
//
//  Created by David Vasquez on 8/24/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postCommentsImage: UIImageView!
    @IBOutlet weak var postCommentsLabel: UILabel!
    @IBOutlet weak var postLikeImage: UIImageView!
    @IBOutlet weak var postLikeLabel: UILabel!
    
    
    func setPost(post: Post) {
        postImage.image = post.postImageData
        postCaptionLabel.text = post.postCaption
        postCommentsImage.image = UIImage(named: "like")
        postCommentsLabel.text = "1"
        postCommentsImage.image = UIImage(named: "like")
        postLikeLabel.text = "1"
        
    }
     
    /*
     func setPost(currentPost: String) {
         //postImage.image = post.postImageData
         print("Set Post \(currentPost)")
         postCaptionLabel.text = currentPost
         postCommentsImage.image = UIImage(named: "like")
         postCommentsLabel.text = "1"
         postCommentsImage.image = UIImage(named: "like")
         postLikeLabel.text = "1"
         
     }
     */
    
}




/*
 
 @IBOutlet weak var postImageView: UIImageView!
 @IBOutlet weak var postCaptionLabel: UILabel!


 func setPost(post: Post) {
     postImageView.image = post.postImageData
     postCaptionLabel.text = post.postCaption
 }
 
 */
