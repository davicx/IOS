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

    //Cell Information
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    
    //Cell Delegates
    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var selectedFriendName: String?
    var selectedFriendStatus: Int?
    //var whatTheHeck: String?
    
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!)
        flipButton(withString: "", on: sender)
        //let currentIndex = index!.row
        //print("Info \(currentIndex)")
    }
    
    //SETUP: Setup Friend Cell 
    func setupFriendCell(friend: Friend) {
        print("Set Friend \(friend.userName) \(friend.friendStatus)")
        friendName.text = friend.userName
  
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
        }

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
