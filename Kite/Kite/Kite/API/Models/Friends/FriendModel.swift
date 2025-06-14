//
//  FriendModel.swift
//  Kite
//
//  Created by David Vasquez on 5/20/25.
//


import UIKit


struct FriendModel: Codable {
    let friendID: Int
    let friendName: String
    let friendImage: String
    let firstName: String
    let lastName: String
    let requestPending: Int
    let requestSentBy: String
    let friendshipKey: String
    let alsoYourFriend: Int

    init() {
        self.friendID = 0
        self.friendName = ""
        self.friendImage = ""
        self.firstName = ""
        self.lastName = ""
        self.requestPending = 0
        self.requestSentBy = ""
        self.friendshipKey = ""
        self.alsoYourFriend = 0
    }
}

