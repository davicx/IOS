//
//  DeclineFriendResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 6/3/25.
//

import Foundation


struct DeclineFriendResponseModel: Codable {
    let data: DeclineFriendModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = DeclineFriendModel()
        self.message = ""
        self.success = true
        self.statusCode = 200
        self.errors = []
        self.currentUser = ""
    }
}

struct DeclineFriendModel: Codable {
    let friendInviteDeclined: Bool
    let currentUser: String
    let friendName: String

    init() {
        self.friendInviteDeclined = false
        self.currentUser = ""
        self.friendName = ""
    }
}
