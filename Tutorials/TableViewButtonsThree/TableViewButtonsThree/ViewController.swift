//
//  ViewController.swift
//  TableViewButtonsThree
//
//  Created by David Vasquez on 8/26/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var friendOne = Friend(friendID: 1, userName: "bilbo", friendStatus: 1)
    var friendTwo = Friend(friendID: 2, userName: "frodo", friendStatus: 1)
    var friendThree = Friend(friendID: 3, userName: "james", friendStatus: 0)
    var friendFour = Friend(friendID: 4, userName: "samwise", friendStatus: 0)
    
    //var friendsArray: [Friend] = []
    var friendsArray = ["david", "Bilbo", "Frodo"]

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //friendsArray.append(friendOne)
        //friendsArray.append(friendTwo)
        //friendsArray.append(friendThree)
        //friendsArray.append(friendFour)
    }


}




extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendTableViewCell
        let currentFriend = friendsArray[indexPath.row]
   
        cell?.labUserName.text = "hi"
        //cell?.userName.text = currentFriend.userName
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        return cell!
        
    }
}

extension ViewController: TableViewNew {
    func onAddFriendCell(index: Int) {
        print("User \(friendsArray[index])")
        //print("Clicked Index \(index)")
    }
    
    
}

