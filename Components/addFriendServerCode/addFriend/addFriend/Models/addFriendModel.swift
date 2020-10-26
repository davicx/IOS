//
//  addFriendModel.swift
//  addFriend
//
//  Created by David Vasquez on 9/6/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

class addFriendModel: Decodable {
    let request_from: String
    let request_to: String
    let add_friend_outcome: Int
    let add_friend_message: String
}
