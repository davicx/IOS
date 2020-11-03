//
//  ViewController.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 120;
        friendsArray = createArray()
        //tableView.delegate = self
        //tableView.dataSource = self
        
    }

    func createArray() -> [Friend] {
        let friendOne = Friend(friendID: 1, userName: "david", friendImage: #imageLiteral(resourceName: "train"), friendStatus: 1)
        let friendTwo = Friend(friendID: 2, userName: "frodo", friendImage: #imageLiteral(resourceName: "city"), friendStatus: 1)
        let friendThree = Friend(friendID: 3, userName: "bilbo",friendImage: #imageLiteral(resourceName: "night"), friendStatus: 0)
        let friendFour = Friend(friendID: 4, userName: "samwise",friendImage: #imageLiteral(resourceName: "train"), friendStatus: 0)
        
        return [friendOne, friendTwo, friendThree, friendFour]

    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //ROWS: Set the Total Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    //CELL: This is where each cell is configured
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get the Friend we are going to Load into the Cell
        let friend = friendsArray[indexPath.row]
        
        //Create a cell variable so we can configure it
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        
        //CELL SET UP: Methods in Friend Cell Called when we set the Cell Up
        cell.setupFriendCell(friend: friend)
        //cell.getTheData(friend: friend)
        //cell.configureButtonTitle(friend: friend)
        
 
        return cell
        
        
        
        
    }

}

/*
 //Set the Button Title on Load
 if friend.friendStatus == 1 {
 cell.setOriginalButtonTitle(with: "Remove")
 } else {
 cell.setOriginalButtonTitle(with: "Add")
 }
 */

