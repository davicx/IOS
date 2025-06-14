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
    case invitePendingSentByYou = "invite_pending"      // You sent the invite
    case requestPendingSentByThem = "request_pending"    // You received the invite
    case notFriends = "not_friends"
    case you = "you"
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





