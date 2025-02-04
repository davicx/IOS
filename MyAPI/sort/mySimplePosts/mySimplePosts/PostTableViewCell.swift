//
//  PostTableViewCell.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/9/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!


    func setPost(post: Post) {
        postImageView.image = post.postImageData
        postCaptionLabel.text = post.postCaption
    }
    
}

