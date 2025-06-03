//
//  AddFriendResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 5/23/25.
//

import Foundation


struct AddFriendResponseModel: Codable {
    let data: AddFriendModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = AddFriendModel()
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}


struct AddFriendModel: Codable {
    let currentUser: String
    let friendAddSuccessOutcome: Bool
    let friendData: FriendModel

    init() {
        self.currentUser = ""
        self.friendAddSuccessOutcome = false
        self.friendData = FriendModel()
    }
}
