//
//  UserCountModel.swift
//  Kite
//
//  Created by David Vasquez on 12/11/25.
//

import Foundation


struct UserCountModel: Codable {
    let userName: String
    let userID: Int
    let totalFriends: Int
    let totalGroups: Int
    let totalPosts: Int
}

