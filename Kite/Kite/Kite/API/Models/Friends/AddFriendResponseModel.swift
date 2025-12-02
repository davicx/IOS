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
    let friendData: AddFriendDataModel

    init() {
        self.currentUser = ""
        self.friendAddSuccessOutcome = false
        self.friendData = AddFriendDataModel()
    }
}

// Model that matches the API response structure for friendData
struct AddFriendDataModel: Codable {
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
    
    // Convert to UserModel for compatibility
    func toUserModel() -> UserModel {
        return UserModel(
            userID: friendID,
            userName: friendName,
            userImage: friendImage,
            firstName: firstName,
            lastName: lastName,
            biography: "", // Not provided in API response
            requestPending: requestPending,
            requestSentBy: requestSentBy,
            friendshipKey: friendshipKey,
            alsoYourFriend: alsoYourFriend
        )
    }
}
