//
//  PostCell.swift
//  twitterDesign
//
//  Created by Vasquez, Charles Geoffrey David [C] on 2/28/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postUserImageView: UIImageView!
    @IBOutlet weak var postUserNameLabel: UILabel!
    
    func setPost(post: Post) {
        postUserImageView.image = post.userImage
        postUserNameLabel.text = post.userName
    }
 
    
}
