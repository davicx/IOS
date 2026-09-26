//
//  PostTableViewCell.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/29/24.
//  Copyright © 2024 David Vasquez. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    
    func setPost(post: Post) {
        postImage.image = post.image
        postCaption.text = post.title
        postLikes.text = String(post.likeCount)
    }
    
    
    @IBAction func LikeButton(_ sender: UIButton) {
        print("like me")
        
    }
    
}
