//
//  Backup.swift
//  addFriend
//
//  Created by David Vasquez on 12/9/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

//
//  FriendCell.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
// Boss

//CELL

/*

import UIKit

protocol addFriendProtocol {
    //func addFriendClick(index: Int, friendName: String, friendObject: Friend)
    func addFriendClick(index: Int, friendObject: Friend)
}

class FriendCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    //Cell Delegates
    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var currentFriend: Friend?
    //var selectedFriendName: String?
    //var selectedFriendStatus: Int?
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        //Unwrap Optional
        
        
        print("addFriendButton \(currentFriend?.userName)")
        
        
        //cellDelegate?.addFriendClick(index: i ndex!.row, friendName: selectedFriendName!, friendObject: currentFriend!)
        cellDelegate?.addFriendClick(index: index!.row, friendObject: currentFriend!)
        
        //print("addFriendButton \(friend.userName)")
        flipButton(withString: "", on: sender)
    }
    
    
    //SETUP Methods that Run on Setup the friend information (This is called when the app is loaded)
    func setupFriendCell(friend: Friend){
        friendImage.image = friend.friendImage
        friendName.text = friend.userName
        
        //Set Up the Button Title
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
        }
    }
    
    
    //BUTTON: Changes to Button
    //Configure Button on Cell Flip
    func flipButton(withString addFriend: String, on button: UIButton) {
        if button.currentTitle == "Add" {
            button.setTitle("Remove", for: UIControl.State.normal)
        } else {
            button.setTitle("Add", for: UIControl.State.normal)
        }
        
    }
}


//
//  ViewController.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, addFriendProtocol {
    
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
    
    
    //func addFriendClick(index: Int, friendName: String, friendObject: Friend) {
    func addFriendClick(index: Int, friendObject: Friend) {
        print("Friend ID: \(index) \(friendsArray[index].userName) Friend Status: \(friendsArray[index].friendStatus)")
        print("Friend Name: \(friendObject.userName)")
        print("______________________")
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //ROWS: Set the Total Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    //CELL: This is where each cell is configured
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //CELL SET UP
        //Get the Friend we are going to Load into the Cell
        let friend = friendsArray[indexPath.row]
        
        //Create a cell variable so we can configure it
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        
        //Methods in Friend Cell Called when we set the Cell Up
        cell?.setupFriendCell(friend: friend)
        //cell?.selectedFriendName = friend.userName
        //cell?.selectedFriendStatus = friend.friendStatus
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        //Send the Friend Object
        cell?.currentFriend = friend
        
        return cell!
        
    }
    
}

*/
