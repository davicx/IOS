//
//  UserModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UserModel: Codable {
    let userName: String
    let userID: Int
    let userImage: String
    let biography: String
    let firstName: String
    let lastName: String
    let friendshipKey: String
    let requestPending: Int
    let requestSentBy: String
    let alsoYourFriend: Int
    
    init() {
        self.userName = "userName"
        self.userID = 0
        self.userImage = "userImage"
        self.biography = "biography"
        self.firstName = "firstName"
        self.lastName = "lastName"
        self.friendshipKey = "friendshipKey"
        self.requestPending = 0
        self.requestSentBy = "requestSentBy"
        self.alsoYourFriend = 0
    }
    
    init(userID: Int, userName: String, userImage: String, firstName: String, lastName: String, biography: String, requestPending: Int, requestSentBy: String, friendshipKey: String, alsoYourFriend: Int) {
        self.userID = userID
        self.userName = userName
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.biography = biography
        self.requestPending = requestPending
        self.requestSentBy = requestSentBy
        self.friendshipKey = friendshipKey
        self.alsoYourFriend = alsoYourFriend
    }
}
