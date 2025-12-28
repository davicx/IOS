//
//  AuthManager.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/26/25.
//  Copyright © 2025 David Vasquez. All rights reserved.
//

import Foundation


//let currentUser = AuthManager.shared.currentUser
final class AuthManager {

    static let shared = AuthManager()
    private init() {}

    // MARK: - Current User
    // Hardcoded for now (learning)
    let currentUser: String = "davey"
}
