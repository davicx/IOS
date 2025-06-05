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
    
    init() {
        self.userName = "userName"
        self.userID = 0
        self.userImage = "userImage"
        self.biography = "biography"
        self.firstName = "firstName"
        self.lastName = "lastName"
    }
}

