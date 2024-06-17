//
//  TableViewController.swift
//  TableViewSingleButton
//
//  Created by David Vasquez on 8/28/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//


import UIKit


var friendsArray: [Friend] = []

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFriendsArray()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let friendName = friendsArray[indexPath.row].userName
 
        cell.textLabel?.text = friendName

        return cell
    }
    
    func createFriendsArray() {
        let friendOne = Friend(friendID: 1, userName: "bilbo", friendStatus: 1)
        let friendTwo = Friend(friendID: 2, userName: "frodo", friendStatus: 1)
        let friendThree = Friend(friendID: 3, userName: "james", friendStatus: 0)
        let friendFour = Friend(friendID: 4, userName: "samwise", friendStatus: 0)
        
        friendsArray.append(friendOne)
        friendsArray.append(friendTwo)
        friendsArray.append(friendThree)
        friendsArray.append(friendFour)
        
    }

    


}
