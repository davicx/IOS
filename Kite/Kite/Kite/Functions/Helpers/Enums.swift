//
//  Enums.swift
//  Kite
//
//  Created by David Vasquez on 12/10/24.
//

import UIKit


enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case tokenRefreshFailed
    case unauthorized
    case serverError(statusCode: Int)
}

enum FriendshipStatus: String {
    case friends = "friends"
    case requestPending = "request_pending"
    case invitePending = "invite_pending"
    case unknown

    init(key: String) {
        self = FriendshipStatus(rawValue: key) ?? .unknown
    }
}

enum FriendAction {
    case add
    case decline
    case remove
    case accept
}





