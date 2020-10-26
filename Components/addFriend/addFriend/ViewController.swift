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
    
    //Total Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    //This is where each cell is configured
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get the Correct Friend
        let friend = friendsArray[indexPath.row]
        
        //Create a cell variable so we can configure it
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        
        //You could configure each cell right here we do it in FriendCell.setFriend 
        cell.setFriend(friend: friend)
        
        return cell
        
    }

}

/*
import UIKit

class ViewController: UIViewController, addFriendProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friendOne = Friend(friendID: 1, userName: "david", friendStatus: 1)
    var friendTwo = Friend(friendID: 2, userName: "frodo", friendStatus: 1)
    var friendThree = Friend(friendID: 3, userName: "bilbo", friendStatus: 0)
    var friendFour = Friend(friendID: 4, userName: "samwise", friendStatus: 0)
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsArray.append(friendOne)
        friendsArray.append(friendTwo)
        friendsArray.append(friendThree)
        friendsArray.append(friendFour)
    }
    
    func addFriendClick(index: Int, friendName: String) {
        print("Update Friend Status \(index) \(friendsArray[index].userName)")
        
    }
}

*/
/*
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendViewCell
        
        //Just send the Full Friend Object
        let currentFriendObject = friendsArray[indexPath.row]
        cell?.setFriend(friend: currentFriendObject)
        
        //Clean Below
        let currentFriendName = friendsArray[indexPath.row].userName
        
        let currentFriendStatus = friendsArray[indexPath.row].friendStatus
        cell?.selectedFriendName = currentFriendName
        cell?.selectedFriendStatus = currentFriendStatus
        
        //Set Name
        cell?.friendName.text = currentFriendName
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        
        if currentFriendStatus == 1 {
            cell!.configure(with: "Remove")
        } else {
            cell!.configure(with: "Add")
        }
        
        return cell!
        
    }
}

*/
