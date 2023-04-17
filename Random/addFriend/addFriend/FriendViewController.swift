//
//  FriendViewController.swift
//  addFriend
//
//  Created by David Vasquez on 12/9/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendNameLabel.text = friendsArray[friendIndex].userName
        friendImage.image = friendsArray[friendIndex].friendImage
        
    }
    

}
