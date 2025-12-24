//
//  User.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/24/25.
//  Copyright © 2025 David Vasquez. All rights reserved.
//

import UIKit


class User {
    let userName: String
    var userImage: UIImage?
    var userFollowers: [String]

    init(userName: String, userImage: UIImage? = nil, userFollowers: [String] = []) {
        self.userName = userName
        self.userImage = userImage
        self.userFollowers = userFollowers
    }
}
