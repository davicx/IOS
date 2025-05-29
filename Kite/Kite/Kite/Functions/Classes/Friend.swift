//
//  Friend.swift
//  Kite
//
//  Created by David Vasquez on 5/26/25.
//

import UIKit


class Friend {
    let friendID: Int
    let friendName: String
    var friendImage: String
    var firstName: String
    var lastName: String
    var friendBiography: String
    var requestPending: Int
    var requestSentBy: String
    var friendshipKey: String
    var alsoYourFriend: Int
    
    var profileImage: UIImage?
    
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
        
        self.profileImage = UIImage(named: "background_1")
    }
}
