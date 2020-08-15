//
//  ViewController.swift
//  getFriends
//
//  Created by David Vasquez on 7/11/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserFriends(userName: "Vasquezd") { tempFriendsArray, error in
            DispatchQueue.main.async {
                self.friendsArray = tempFriendsArray
                
            }
        }
    }
    
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
    
    

}

