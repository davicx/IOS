//
//  FriendCell.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

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

