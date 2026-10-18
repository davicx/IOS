//
//  InviteFriendsResponseModel.swift
//  Kite
//

import Foundation


struct InviteFriendsData: Codable {
    let addedUsers: [String]
    let existingUsers: [String]

    init() {
        addedUsers = []
        existingUsers = []
    }
}


struct InviteFriendsResponseModel: Codable {
    let data: InviteFriendsData
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        data = InviteFriendsData()
        message = ""
        success = false
        statusCode = 500
        errors = []
        currentUser = ""
    }
}
