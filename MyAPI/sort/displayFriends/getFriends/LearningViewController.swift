//
//  LearningViewController.swift
//  getFriends
//
//  Created by David Vasquez on 8/24/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController {

    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserFriends(userName: "Vasquezd") { tempFriendsArray, error in
            DispatchQueue.main.async {
                self.friendsArray = tempFriendsArray
                
            }
        }
        


    }
    

    @IBAction func printFriends(_ sender: UIButton) {
        for friend in friendsArray {
            print("Friend: \(friend.friendStatus)  \(friend.userName)")
        }
        
        print("___________________")
        let friendToSearchFor = "BeCCA"
        var friendArrayIndex = getFriendArrayLocation(friendToFind: friendToSearchFor, friendsArray: friendsArray)
        
        friendsArray[1].friendStatus = 0
        
        for friend in friendsArray {
            print("Friend: \(friend.friendStatus)  \(friend.userName)")
        }
        
        
    }
    
    /*
    var currentIndex = 0
    for friend in friendsArray {
    print("Friend: \(currentIndex)  \(friend.userName)")
    currentIndex = currentIndex + 1
    }
    print(friendArrayIndex)
    */


}

