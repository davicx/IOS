//
//  AcceptFriendResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 6/2/25.
//

import UIKit


struct AcceptFriendResponseModel: Codable {
    let data: AcceptFriendModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = AcceptFriendModel()
        self.message = ""
        self.success = true
        self.statusCode = 200
        self.errors = []
        self.currentUser = ""
    }
}

struct AcceptFriendModel: Codable {
    let friendAdded: Bool
    let currentUser: String
    let friendName: String

    init() {
        self.friendAdded = false
        self.currentUser = ""
        self.friendName = ""
    }
}


