//
//  TableViewCell.swift
//  designTableView
//
//  Created by Vasquez, Charles Geoffrey David [C] on 1/14/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    
    func setPost(post: Post) {
        postImageView.image = post.image
        postTextLabel.text = post.title
    }
    
}
