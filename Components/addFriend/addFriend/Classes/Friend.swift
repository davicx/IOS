//
//  Friend.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation
import UIKit

struct Friend {
    var friendID: Int
    var userName: String
    var friendImage: UIImage
    var friendStatus: Int
    
    init(friendID: Int, userName: String, friendImage: UIImage, friendStatus: Int) {
        self.friendID = friendID
        self.userName = userName
        self.friendImage = friendImage
        self.friendStatus = friendStatus
        
    }
    
}

