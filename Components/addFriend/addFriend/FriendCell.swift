//
//  FriendCell.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
// Boss

//CELL

import UIKit

protocol addFriendProtocol {
    //func addFriendClick(index: Int, friendName: String, friendObject: Friend)
    func addFriendClick(index: Int, friendObject: Friend)
}

class FriendCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    //Cell Delegates
    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var currentFriend: Friend? 
    //var selectedFriendName: String?
    //var selectedFriendStatus: Int?
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        print("addFriendButton")
        //cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!, friendObject: currentFriend!)
        cellDelegate?.addFriendClick(index: index!.row, friendObject: currentFriend!)
        
        //print("addFriendButton \(friend.userName)")
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
    

    //BUTTON: Changes to Button 
    //Configure Button on Cell Flip
    func flipButton(withString addFriend: String, on button: UIButton) {
        if button.currentTitle == "Add" {
            button.setTitle("Remove", for: UIControl.State.normal)
        } else {
            button.setTitle("Add", for: UIControl.State.normal)
        }
        
    }
}
