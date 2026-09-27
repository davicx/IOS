//
//  CancelFriendRequestModel.swift
//  Kite
//
//  Created by David Vasquez on 6/1/25.
//

import Foundation


struct CancelFriendRequestData: Codable {
    let requestRemoved: Bool
    let requestType: String
    let currentUser: String
    let friendName: String
    let errors: [String]

    init() {
        self.requestRemoved = false
        self.requestType = ""
        self.currentUser = ""
        self.friendName = ""
        self.errors = []
    }
}
