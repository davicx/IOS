//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit

class IndividualPostViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postLikeCountLabel: UILabel!
    
    func setUser(currentUser: String) {
        postCaptionLabel.text = "Hiya!!"

    }

    
    @IBAction func postLikeButton(_ sender: UIButton) {
        print("Like me!")
        
    }
    
}


/*
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

 */
