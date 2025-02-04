//
//  VideoCell.swift
//  TableViewCustomCells
//
//  Created by David Vasquez on 5/20/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!

    func setPost(post: Post) {
        videoImageView.image = post.image
        videoTitleLabel.text = post.title
    }
 
}


