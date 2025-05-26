//
//  Friend.swift
//  Kite
//
//  Created by David Vasquez on 5/26/25.
//

import Foundation


class Friend {
    let friendID: Int
    let friendName: String
    let friendImage: String
    let firstName: String
    let lastName: String
    let friendBiography: String
    let requestPending: Int
    let requestSentBy: String
    let friendshipKey: String
    let alsoYourFriend: Int
    
    init(from model: FriendModel) {
        self.friendID = model.friendID
        self.friendName = model.friendName
        self.friendImage = model.friendImage
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.friendBiography = model.friendBiography
        self.requestPending = model.requestPending
        self.requestSentBy = model.requestSentBy
        self.friendshipKey = model.friendshipKey
        self.alsoYourFriend = model.alsoYourFriend
    }
}
