//
//  PostCell.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/16/21.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    func setPost(post: Post) {
        postImageView.image = post.postImage
        postCaptionLabel.text = post.postCaption
    }
    
}

