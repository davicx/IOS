//
//  FriendProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/20/25.
//

import UIKit


class FriendProfileViewController: UIViewController {
    var friend: FriendModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white  // Optional: to see something while testing

         if let friend = friend {
             print("Friend profile for: \(friend.friendName)")
         }
        
    }
 
}
