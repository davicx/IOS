//
//  User.swift
//  simpleSocial
//
//  Created by David Vasquez on 5/22/25.
//

import Foundation


class User {
    let userName: String
    var totalLikes: Int

    init(userName: String, totalLikes: Int) {
        self.userName = userName
        self.totalLikes = totalLikes
    }
}
