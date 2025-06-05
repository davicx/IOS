//
//  CancelFriendRequestReponseModel.swift
//  Kite
//
//  Created by David Vasquez on 6/1/25.
//

import Foundation

struct CancelFriendRequestResponseModel: Codable {
    let data: CancelFriendRequestData
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = CancelFriendRequestData()
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}
