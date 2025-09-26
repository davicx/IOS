//
//  FriendSearchModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct FriendSearchModel: Codable {
    let friendName: String
    let friendImage: String
    let firstName: String
    let lastName: String
    
    init() {
        self.friendName = "friendName"
        self.friendImage = "friendImage"
        self.firstName = "firstName"
        self.lastName = "lastName"
    }
}
