//
//  FriendCell.swift
//  getFriends
//
//  Created by David Vasquez on 8/15/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol FriendCellDelegate {
    func didTapAddFriend(selectedFriend: String)
}

class FriendCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var currentFriendName = ""
    var delegate: FriendCellDelegate?

    func setFriend(friend: Friend) {
        //print(friend.userImage)
        userNameLabel.text = friend.userName
        fullNameLabel.text = friend.userImage
        currentFriendName = friend.userName
        print(friend.friendStatus)

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
        delegate?.didTapAddFriend(selectedFriend: currentFriendName)
        
    }
    
 
    
}


/*
@IBAction func addFriend(_ sender: UIButton) {
    flipButton(withString: "Add Friend", on: sender)
}

func flipButton(withString addFriend: String, on button: UIButton) {
    if button.currentTitle == addFriend {
        button.setTitle("Remove Friend", for: UIControl.State.normal)
    } else {
        button.setTitle("Add Friend", for: UIControl.State.normal)
    }
    
}



*/


