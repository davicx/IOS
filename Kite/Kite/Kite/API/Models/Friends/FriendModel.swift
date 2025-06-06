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


/*
 {
     "friendID": 1,
     "friendName": "davey",
     "friendImage": "frodo.jpg",
     "firstName": "david",
     "lastName": "v2",
     "friendBiography": "They are (or were) a little people, about half our height, and smaller than the bearded dwarves",
     "requestPending": 0,
     "requestSentBy": "merry",
     "friendshipKey": "you",
     "alsoYourFriend": 1
 }
 */

/*
 {
     "data": {
         "currentUser": "davey",
         "friendAddSuccessOutcome": false,
         "friendData": {
             "friendID": 5,
             "friendName": "pippin",
             "friendImage": "http://localhost:3003/kite-profile-us-west-two/profileImage-1748475610744-101974712-76909388_p0.jpg",
             "firstName": "Pippin",
             "lastName": "BrandyBuck",
             "requestPending": 0,
             "requestSentBy": "davey",
             "friendshipKey": "invite_pending",
             "alsoYourFriend": 0
         }
     },
     "message": "Status 2: Friendship Invite Pending (they accept)",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
