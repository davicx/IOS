//
//  FriendCell.swift
//  getFriends
//
//  Created by David Vasquez on 8/15/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol FriendCellDelegate {
    func didTapAddFriend(title: String)
}

class FriendCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    //var friendItem = Friend?
    var delegate: FriendCellDelegate?
    //var currentFriend = Friend.self
   
    func setFriend(friend: Friend) {
        print(friend.userImage)
        userNameLabel.text = friend.userName
        fullNameLabel.text = friend.userImage
        
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
        print(friend.userName)
    }
    
    @IBAction func addFriend(_ sender: UIButton) {
       delegate?.didTapAddFriend(title: "ahhh")
    }
    
    /*
    @IBAction func addFriend(_ sender: Any) {
        delegate?.didTapAddFriend(title: "friendItem.userName")
        
    }
    
    */
    
    /*
    @IBAction func addFriend(_ sender: Any) {
        delegate?.didTapAddFriend(title: friend.userName)
        
    }
    */
    
}




