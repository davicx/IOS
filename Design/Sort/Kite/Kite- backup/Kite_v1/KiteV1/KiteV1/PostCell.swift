//
//  PostCell.swift
//  KiteV1
//
//  Created by Syngenta on 8/31/21.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var PostCaption: UILabel!
    
    func setPost(post: Post) {
        PostCaption.text = post.caption
   
    }
}
