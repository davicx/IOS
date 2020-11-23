//
//  WorkingBackup.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 11/17/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

/*
 
 //
 //  FriendViewCell.swift
 //  makeButtonClickable
 //
 //  Created by David Vasquez on 9/1/20.
 //  Copyright © 2020 David Vasquez. All rights reserved.
 //This is the Boss
 
 import UIKit
 
 protocol addFriendProtocol {
 func addFriendClick(index: Int, friendName: String)
 }
 
 class FriendViewCell: UITableViewCell {
 
 var cellDelegate: addFriendProtocol?
 
 var index: IndexPath?
 
 var selectedFriendName: String?
 var selectedFriendStatus: Int?
 
 //var whatTheHeck: String?
 
 @IBOutlet weak var friendName: UILabel!
 @IBOutlet weak var addFriendButtonOutlet: UIButton!
 
 
 @IBAction func addFriendButton(_ sender: UIButton) {
 cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!)
 flipButton(withString: "", on: sender)
 //let currentIndex = index!.row
 //print("Info \(currentIndex)")
 }
 
 //SETUP: Set Friend
 func setFriend(friend: Friend) {
 print("Set Friend \(friend.userName) \(friend.friendStatus)")
 friendName.text = friend.userName
 
 if friend.friendStatus == 1 {
 addFriendButtonOutlet.setTitle("Remove", for: .normal)
 } else {
 addFriendButtonOutlet.setTitle("Add", for: .normal)
 }
 /*
 if friend.friendStatus == 1 {
 cell!.configure(with: "Remove")
 } else {
 cell!.configure(with: "Add")
 }
 */
 /*
 friendImage.image = friend.friendImage
 friendName.text = friend.userName
 
 //Set Up the Button Title
 if friend.friendStatus == 1 {
 addFriendButtonOutlet.setTitle("Remove", for: .normal)
 } else {
 addFriendButtonOutlet.setTitle("Add", for: .normal)
 
 }
 */
 //Yay! Do the stuff here
 //videoImageView.image = video.image
 //videoTitleLabel.text = video.username
 
 //Set Properties to Use in Video Cell
 //userName = video.username
 //friendStatus = video.friendStatus
 }
 
 func configure(with title: String) {
 addFriendButtonOutlet.setTitle(title, for: .normal)
 
 }
 
 func flipButton(withString addFriend: String, on button: UIButton) {
 if button.currentTitle == "Add" {
 button.setTitle("Remove", for: UIControl.State.normal)
 } else {
 button.setTitle("Add", for: UIControl.State.normal)
 }
 
 }
 }
 
 
 /*
 import UIKit
 
 class VideoCell: UITableViewCell {
 
 @IBOutlet weak var videoImageView: UIImageView!
 
 @IBOutlet weak var videoTitleLabel: UILabel!
 
 var userName = ""
 var friendStatus = 0
 
 @IBAction func buttonTapped(_ sender: UIButton) {
 print("button Tapped")
 print(userName)
 }
 
 @IBOutlet weak var button: UIButton!
 
 func configure(with title: String) {
 
 button.setTitle(title, for: .normal)
 }
 
 func setVideo(video: Video) {
 videoImageView.image = video.image
 videoTitleLabel.text = video.username
 
 //Set Properties to Use in Video Cell
 userName = video.username
 friendStatus = video.friendStatus
 }
 
 
 }
 
 
 */
 
 
 /*
 override func awakeFromNib() {
 super.awakeFromNib()
 // Initialization code
 }
 */

 
 //
 //  ViewController.swift
 //  makeButtonClickable
 //
 //  Created by David Vasquez on 9/1/20.
 //  Copyright © 2020 David Vasquez. All rights reserved.
 //https://www.youtube.com/watch?v=UPrBXUWPf6Q
 //The Intern
 
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
 
 //Send Variables to the Cell
 cell?.selectedFriendName = currentFriendName
 cell?.selectedFriendStatus = currentFriendStatus
 cell?.cellDelegate = self
 cell?.index = indexPath
 //cell?.whatTheHeck = "hi"
 
 /*
 Moved to the cell where cell! broke
 if currentFriendStatus == 1 {
 cell!.configure(with: "Remove")
 } else {
 cell!.configure(with: "Add")
 }
 */
 return cell!
 
 }
 }
 

 */
