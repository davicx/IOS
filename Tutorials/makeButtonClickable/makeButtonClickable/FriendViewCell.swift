//
//  FriendViewCell.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 9/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//This is the Boss

import UIKit

protocol addFriendProtocol {
    func addFriendClick(index: Int, friendName: String)
}

class FriendViewCell: UITableViewCell {

    var cellDelegate: addFriendProtocol?
    
    var index: IndexPath?
    
    var selectedFriendName: String?
    var selectedFriendStatus: Int?
   
    //var whatTheHeck: String?
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!)
        flipButton(withString: "", on: sender)
        let currentIndex = index!.row
        //print("Info \(currentIndex)")
    }
    
    //SETUP: Set Friend
    //func setupFriendCell(friend: Friend){
    func setFriend(friend: Friend) {
        print("Set Friend \(friend.userName) \(friend.friendStatus)")
        
        //This broke here so we changed
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
        }
        /*
        if friend.friendStatus == 1 {
            cell!.configure(with: "Remove")
        } else {
            cell!.configure(with: "Add")
        }
            */
        /*
        friendImage.image = friend.friendImage
        friendName.text = friend.userName
        
        //Set Up the Button Title
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
 
        }
 */
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
