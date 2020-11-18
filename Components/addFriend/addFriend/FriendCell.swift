//
//  FriendCell.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
// Boss

import UIKit

class FriendCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        print("addFriendButton")
        //print("You Selected \(friend.userName)")
        flipButton(withString: "", on: sender)
    }
    
    
    //SETUP Methods that Run on Setup the friend information (This is called when the app is loaded)
    func setupFriendCell(friend: Friend){
        friendImage.image = friend.friendImage
        friendName.text = friend.userName
        
        //Set Up the Button Title
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
        }
    }
    

    //BUTTON: Changes to Button s
    //Configure Button on Cell Flip
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
        print("Info \(currentIndex)")
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


*/


/*
 //Runs on Setup
 func getTheData(friend: Friend) {
 print("User Name \(friend.friendID)")
 print("User Name \(friend.userName)")
 print("User Name \(friend.friendStatus)")
 }
 
 //Set Button Title On Load (Calls another Function)
 func configureButtonTitle(friend: Friend) {
 if friend.friendStatus == 1 {
 addFriendButtonOutlet.setTitle("Remove", for: .normal)
 } else {
 addFriendButtonOutlet.setTitle("Add", for: .normal)
 }
 
 }
 */

