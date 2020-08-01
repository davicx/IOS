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
    }
    
    //Actions
    @IBAction func getFriends(_ sender: Any) {
        getFriends()
    }
    
    @IBAction func showFriends(_ sender: Any) {
        for friend in friendsArray {
            print(friend.userName)
        }
        print("___________________")
    }
    
    
    func getFriends() {
        //Get Friends
        let parameters = ["user_name": "vasquezd", "user_key": "vasquezd"]
        
        guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/friends/get_friends.php?user_name=vasquezd") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    self.friendsArray.removeAll()
                    let friendModelArray = try JSONDecoder().decode([FriendModel].self, from: data)
                    
                    for friend in friendModelArray{
                        let currentFriend = Friend(userName: friend.friend_user_name)
                        currentFriend.userImage = friend.user_image
                        currentFriend.firstName = friend.first_name
                        currentFriend.lastName = friend.last_name
                        self.friendsArray.append(currentFriend)
                    }
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}

