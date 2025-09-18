//
//  UserProfileModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UserProfileModel: Codable {
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
}

/*
 {
     "userName": "davey",
     "userID": 1,
     "userImage": "http://localhost:3003/kite-us-west-two/profile/profileImage-1754177896055-604384021-1597356887small7_p0_master1200.jpg",
     "firstName": "David",
     "lastName": "Vasquez",
     "biography": "They are (or were) a little people, about half our height, and smaller than the bearded dwarves",
     "friendshipKey": "you",
     "requestPending": 0,
     "requestSentBy": "davey",
     "alsoYourFriend": 1
 },
*/
