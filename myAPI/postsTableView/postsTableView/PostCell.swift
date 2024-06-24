//
//  PostCell.swift
//  postsTableView
//
//  Created by David on 6/23/24.
//

import UIKit

class PostCell: UITableViewCell {


    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    func setPost(post: Post) {
        postImageView.image = post.image
        postCaption.text = post.caption
    }
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     */

}
