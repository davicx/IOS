//
//  VideoCell.swift
//  TableViewButtonFive
//
//  Created by David Vasquez on 8/31/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var userName = ""
    var friendStatus = 0
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("button Tapped")
        print(userName)
    }
    
    @IBOutlet weak var button: UIButton!
    
    func configure(with title: String) {
        
        button.setTitle(title, for: .normal)
    }
    
    func setVideo(video: Video) {
        videoImageView.image = video.image
        videoTitleLabel.text = video.username
        
        //Set Properties to Use in Video Cell
        userName = video.username
        friendStatus = video.friendStatus
    }
    
    
}
