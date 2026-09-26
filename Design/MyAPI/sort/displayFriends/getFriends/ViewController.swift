//
//  ViewController.swift
//  getFriends
//
//  Created by David Vasquez on 7/11/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

//https://www.youtube.com/watch?v=ChjXkkqog5k
//https://stackoverflow.com/questions/28894765/uibutton-action-in-table-view-cell


class ViewController: UIViewController, FriendCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserFriends(userName: "Vasquezd") { tempFriendsArray, error in
            DispatchQueue.main.async {
                self.friendsArray = tempFriendsArray
                self.tableView.reloadData()
            }
        }

        
    }

    //Handle Logic of Tapping on Someone
    func didTapAddFriend(selectedFriend: String, selectedFriendStatus: Int) {
        
        var friendArrayIndex = getFriendArrayLocation(friendToFind: selectedFriend, friendsArray: friendsArray)
        print("User Clicked: \(selectedFriend)  Status: \(selectedFriendStatus) Array: \(friendArrayIndex)")
        
        //You are Already Friends (Remove)
        if selectedFriendStatus == 1 {
            friendsArray[friendArrayIndex].friendStatus = 0
            print("Remove")
            //self.tableView.reloadData()
        //You are not Friends (Add)
        } else {
            print("add")
            
            friendsArray[friendArrayIndex].friendStatus = 1
        }
 
        
        for friend in friendsArray {
            print("Friend: \(friend.friendStatus)  \(friend.userName)")
        }
        
        print("_________________")

    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friendsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        
        //cell.dbColumnOrder.setTitle("\(column.order)", for: .normal)
        cell.setFriend(friend: friend)
        
        cell.delegate = self
    
        return cell
    }
 
}

