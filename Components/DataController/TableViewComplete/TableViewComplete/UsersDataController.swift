//
//  UsersDataController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/24/25.
//  Copyright © 2025 David Vasquez. All rights reserved.
//

import UIKit


final class UserDataController {
    
    private let usersAPI = UsersAPI()

    static let shared = UserDataController()
    private init() {}

    // Keyed by userName for fast lookup & no duplicates
    private(set) var users: [String: User] = [:]
    
    // Get all users
    func fetchUsers() async {
        do {
            // Step 1 – Call API
            let fetchedUsers = try await usersAPI.getUsersAPI()

            // Step 2 – Clear old data
            users.removeAll()

            // Step 3 – Store users
            for user in fetchedUsers {
                users[user.userName] = user
            }

            // Step 4 – Notify app
            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .usersUpdated,
                    object: nil
                )
            }

        } catch {
            print("UserDataController: Failed to fetch users - \(error)")
        }
    }

    // Read single user by username
    //CALL: let user = UserDataController.shared.getUserByUsername(userName: "Alice")
    func getUserByUsername(userName: String) -> User? {
        return users[userName]
    }
    /*
    func getUserByUsername(_ userName: String) -> User? {
        return users[userName]
    }
     */

    // Read all users
    func getAllUsers() -> [User] {
        return Array(users.values)
    }

    // Follow user
    func followUser(targetUserName: String, followerUsername: String) {
        // Locate user
        guard var user = users[targetUserName] else { return }

        // Mutate data (idempotent)
        if !user.userFollowers.contains(followerUsername) {
            user.userFollowers.append(followerUsername)
        }

        users[targetUserName] = user

        // Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserName
        )
    }

    // Unfollow user
    func unfollowUser(targetUserName: String, followerUsername: String) {
        // Locate user
        guard var user = users[targetUserName] else { return }

        // Mutate data
        user.userFollowers.removeAll {
            $0 == followerUsername
        }

        users[targetUserName] = user

        // Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserName
        )
    }

    // Debug print users
    func debugPrintUsers() {
        for (userName, user) in users {
            print("USERNAME: \(userName)")
            print("Name: \(user.userName)")
            print("Followers: \(user.userFollowers)")
            print("-------------")
        }
    }
}

extension Notification.Name {
    static let usersUpdated = Notification.Name("usersUpdated")
    static let userUpdated  = Notification.Name("userUpdated")
}

/*
final class UserDataController {
    
    private let usersAPI = UsersAPI()

    static let shared = UserDataController()
    private init() {}

    // Keyed by userID for fast lookup & no duplicates
    private(set) var users: [String: User] = [:]
    
    //Get all Users
    func fetchUsers() async {

        do {
            // APP DATA: Step 1 – Call API
            let fetchedUsers = try await usersAPI.getUsersAPI()

            // APP DATA: Step 2 – Clear old data
            users.removeAll()

            // APP DATA: Step 3 – Store users one by one
            for user in fetchedUsers {
                users[user.userName] = user
            }

            // APP DATA: Step 4 – Notify entire app
            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .usersUpdated,
                    object: nil
                )
            }

        } catch {
            print("UserDataController: Failed to fetch users - \(error)")
        }
    }


    // ------------------------------------------------
    // APP DATA: READ — Views pull, never store
    // ------------------------------------------------
    func getUserByID(_ userID: String) -> User? {
        return users[userID]
    }

    func getAllUsers() -> [User] {
        return Array(users.values)
    }

    //Follow User
    func followUser(targetUserID: String, followerUsername: String) {

        // Step 1 – Locate user
        guard var user = users[targetUserID] else { return }

        // Step 2 – Mutate data (idempotent)
        if !user.userFollowers.contains(followerUsername) {
            user.userFollowers.append(followerUsername)
        }

        users[targetUserID] = user

        // Step 3 – Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserID
        )
    }

    func unfollowUser( targetUserID: String, followerUsername: String) {

        // Step 1 – Locate user
        guard var user = users[targetUserID] else { return }

        // Step 2 – Mutate data
        user.userFollowers.removeAll {
            $0 == followerUsername
        }

        users[targetUserID] = user

        // Step 3 – Notify app
        NotificationCenter.default.post(
            name: .userUpdated,
            object: targetUserID
        )
    }

    //Print Users
    func debugPrintUsers() {
        for (id, user) in users {
            print("USER ID: \(id)")
            print("Name: \(user.userName)")
            print("Followers: \(user.userFollowers)")
            print("-------------")
        }
    }
}

extension Notification.Name {
    static let usersUpdated = Notification.Name("usersUpdated")
    static let userUpdated  = Notification.Name("userUpdated")
}
*/


/*
// ------------------------------------------------
// APP DATA: SET / LOAD USERS
// ------------------------------------------------
// Used for mock data, API results, or resets
func setUsers(_ newUsers: [User]) {
    users = Dictionary(uniqueKeysWithValues: newUsers.map {
        ($0.id, $0)
    })

    NotificationCenter.default.post(
        name: .usersUpdated,
        object: nil
    )
}
 */
