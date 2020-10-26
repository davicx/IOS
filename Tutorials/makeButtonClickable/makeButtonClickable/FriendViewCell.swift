//
//  FriendViewCell.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 9/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol addFriendProtocol {
    func addFriendClick(index: Int, friendName: String)
}

class FriendViewCell: UITableViewCell {

    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var selectedFriendName: String?
    var selectedFriendStatus: Int?
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!)
        flipButton(withString: "", on: sender)
    }
    
    //Set Friend
    func setFriend(friend: Friend) {
        print("Set Friend \(friend.userName) \(friend.friendStatus)")
        //Yay! Do the stuff here 
        //videoImageView.image = video.image
        //videoTitleLabel.text = video.username
        
        //Set Properties to Use in Video Cell
        //userName = video.username
        //friendStatus = video.friendStatus
    }
    
    func configure(with title: String) {
        addFriendButtonOutlet.setTitle(title, for: .normal)
    }
    
    func flipButton(withString addFriend: String, on button: UIButton) {  
        if button.currentTitle == "Add" {
            button.setTitle("Remove", for: UIControl.State.normal)
        } else {
            button.setTitle("Add", for: UIControl.State.normal)
        }
        
    }
}


/*
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


*/


/*
 override func awakeFromNib() {
 super.awakeFromNib()
 // Initialization code
 }
 */
