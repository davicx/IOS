//
//  FriendCell.swift
//  getFriends
//
//  Created by David Vasquez on 8/15/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol FriendCellDelegate {
    func didTapAddFriend(selectedFriend: String, selectedFriendStatus: Int)
}

class FriendCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var currentFriendName = ""
    var currentFriendStatus = 0
    var delegate: FriendCellDelegate?

    func setFriend(friend: Friend) {
        userNameLabel.text = friend.userName
        fullNameLabel.text = friend.userImage
        currentFriendName = friend.userName
        currentFriendStatus = friend.friendStatus
        print(friend.friendStatus)
        
        /*
        if friend.friendStatus == 1 {
            button.setTitle("Remove Friend", for: UIControl.State.normal)
        } else {
            button.setTitle("Add Friend", for: UIControl.State.normal)
        }
        */
        //Load Image
        let userImagePath = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/user_image/"
        let userImageFullPath = userImagePath + friend.userImage
        
        if let url = URL(string: userImageFullPath) {
            do {
                let data = try Data(contentsOf: url)
                userImageView.image = UIImage(data: data)
                
            } catch let err {
                print("error ", err)
                
            }
        }
        
    }
    
    @IBAction func addFriend(_ sender: UIButton) {
        
       //delegate?.didTapAddFriend(title: currentFriendName)
        delegate?.didTapAddFriend(selectedFriend: currentFriendName, selectedFriendStatus: currentFriendStatus)
        //flipButton(withString: "Remove Friend", on: sender)
        
        
        //You are Already Friends (Remove)
        if currentFriendStatus == 1 {
            currentFriendStatus = 0
            flipButton(withString: "Remove Friend", on: sender)
        //You are not Friends (Add)
        } else {
            currentFriendStatus = 1
            flipButton(withString: "Add Friend", on: sender)
        }
        
        
    }
    
    //Change Button Text 
    //func flipButton(withString addFriend: String, on button: UIButton) {
    func flipButton(withString addFriend: String, on button: UIButton) {
        if button.currentTitle == addFriend {
            button.setTitle("Remove Friend", for: UIControl.State.normal)
        } else {
            button.setTitle("Add Friend", for: UIControl.State.normal)
        }
    }
    
 
    
}


