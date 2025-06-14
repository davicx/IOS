//
//  RemoveFriendResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 5/30/25.
//

import Foundation


struct RemoveFriendResponseModel: Codable {
    let data: RemoveFriendModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = RemoveFriendModel()
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}


struct RemoveFriendModel: Codable {
    let currentUser: String
    let friendName: String
    let friendRemoved: Bool

    init() {
        self.currentUser = ""
        self.friendName = ""
        self.friendRemoved = false
    }
}
