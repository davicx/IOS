//
//  PostCell.swift
//  getPosts
//
//  Created by David Vasquez on 6/7/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView?
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postFromLabel: UILabel!
    
    func setPost(post: Post) {
        self.postTitleLabel.text = post.postCaption
        self.postImageView?.image = post.image
        self.postFromLabel.text = post.postFrom
    }
}



