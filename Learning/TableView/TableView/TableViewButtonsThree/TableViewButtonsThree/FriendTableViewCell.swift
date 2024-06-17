//
//  FriendTableViewCell.swift
//  TableViewButtonsThree
//
//  Created by David Vasquez on 8/26/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol TableViewNew {
    func onAddFriendCell(index: Int)
}

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    let imgUser = UIImageView()
    let labUserName = UILabel()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.backgroundColor = UIColor.blue
        labUserName.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(labUserName)
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addFriend(_ sender: UIButton) {
        cellDelegate?.onAddFriendCell(index: index!.row)

        flipButton(withString: "", on: sender)
    }
    
    //func flipButton(withString addFriend: String, on button: UIButton) {
    func flipButton(withString addFriend: String, on button: UIButton) {
        print(button.currentTitle!)
        
        if button.currentTitle == "Add Friend" {
            button.setTitle("Remove Friend", for: UIControl.State.normal)
        } else {
            button.setTitle("Add Friend", for: UIControl.State.normal)
        }
        
    }
    
    
}



import Foundation
import UIKit

struct Friend {
    var friendID: Int
    var userName: String
    var friendStatus: Int
    
    init(friendID: Int, userName: String, friendStatus: Int) {
        self.friendID = friendID
        self.userName = userName
        self.friendStatus = friendStatus
        
    }
    
}


var friendOne = Friend(friendID: 1, userName: "bilbo", friendStatus: 1)
var friendTwo = Friend(friendID: 2, userName: "frodo", friendStatus: 1)
var friendThree = Friend(friendID: 3, userName: "james", friendStatus: 0)
var friendFour = Friend(friendID: 4, userName: "samwise", friendStatus: 0)

//var friendsArray: [Friend] = []
var friendsArray = ["david", "Bilbo", "Frodo"]

/*
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
*/
