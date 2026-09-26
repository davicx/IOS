//
//  VideoCell.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    
    func setVideo(video: Video) {
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
    
}
