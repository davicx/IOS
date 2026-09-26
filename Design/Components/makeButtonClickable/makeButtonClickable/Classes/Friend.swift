//
//  Friend.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 9/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation
import UIKit

struct Friend {
    var friendID: Int
    var userName: String
    var friendStatus: Int
    
    init(friendID: Int, userName: String, friendStatus: Int) {
        self.friendID = friendID
        self.userName = userName
        self.friendStatus = friendStatus
        
    }
    
}

