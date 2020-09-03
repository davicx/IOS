//
//  ViewController.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 9/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, addFriendProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var friends = ["David", "frodo", "bilbo", "Sam"]
  
    var friendOne = Friend(friendID: 1, userName: "david", friendStatus: 1)
    var friendTwo = Friend(friendID: 2, userName: "frodo", friendStatus: 1)
    var friendThree = Friend(friendID: 3, userName: "bilbo", friendStatus: 0)
    var friendFour = Friend(friendID: 4, userName: "samwise", friendStatus: 0)
    var friendsArray: [Friend] = []

    //var friendsArray = [friendOne, friendTwo]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsArray.append(friendOne)
        friendsArray.append(friendTwo)
        friendsArray.append(friendThree)
        friendsArray.append(friendFour)
    }
    

    func addFriendClick(index: Int, friendName: String) {
        //print("index \(index)")
        print(friendName)
        print("Update Friend Status \(index) \(friendsArray[index].userName)")
    
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendViewCell
        let currentFriendName = friendsArray[indexPath.row].userName
        let currentFriendStatus = friendsArray[indexPath.row].friendStatus
        cell?.friendName.text = currentFriendName
        cell?.cellDelegate = self
        cell?.index = indexPath
        cell?.selectedFriendName = currentFriendName
        
        if currentFriendStatus == 1 {
           cell!.configure(with: "Remove")
        } else {
            cell!.configure(with: "Add")
        }
        
        return cell!
        
    }
}

