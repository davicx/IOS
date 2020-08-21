//
//  ViewController.swift
//  getFriends
//
//  Created by David Vasquez on 7/11/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserFriends(userName: "Vasquezd") { tempFriendsArray, error in
            DispatchQueue.main.async {
                self.friendsArray = tempFriendsArray
                self.tableView.reloadData()
                
            }
            //self.reloadData()
        }
        
    }

}

extension ViewController: FriendCellDelegate {
    func didTapAddFriend(title: String) {
        print(title)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friendsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        cell.setFriend(friend: friend)
        cell.delegate = self
        //cell.fullNameLabel.text =
        
        return cell
    }
}

/*
 //Get All Posts
 @IBAction func getFriends(_ sender: Any) {
 getUserFriends(userName: "Vasquezd") { tempFriendsArray, error in
 DispatchQueue.main.async {
 self.friendsArray = tempFriendsArray
 
 }
 }
 //var friendsTempArray = getUserFriends(userName: "Vasquezd")
 //print("My Friends: \(friendsTempArray)")
 }
 
 
 @IBAction func showFriends(_ sender: Any) {
 for friend in friendsArray {
 print(friend.userName)
 }
 print("___________________")
 }
 */

