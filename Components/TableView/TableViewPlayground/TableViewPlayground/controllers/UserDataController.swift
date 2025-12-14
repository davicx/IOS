//
//  UserDataController.swift
//  TableViewPlayground
//
//  Created by David Vasquez on 11/27/25.
//

import Foundation


class UserDataController {
    static let shared = UserDataController()
    
    private(set) var users: [User] = [
        User(name: "Aragorn"),
        User(name: "Legolas"),
        User(name: "Gimli"),
        User(name: "Frodo"),
        User(name: "Gandalf")
    ]
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
    
    func incrementLikes(for user: User) {
        user.likes += 1
        
        NotificationCenter.default.post(
            name: .userUpdated,
            object: user
        )
    }
    
    func decrementLikes(for user: User) {
        user.likes = max(0, user.likes - 1)
        
        NotificationCenter.default.post(
            name: .userUpdated,
            object: user
        )
    }
}

extension Notification.Name {
    static let userUpdated = Notification.Name("userUpdated")
}

//WORKS
/*
class UserDataController {
    static let shared = UserDataController()

    private(set) var users: [String: User] = [:]

    private init() {
        // initial sample data
        ["Aragorn", "Legolas", "Gimli", "Frodo", "Gandalf"].forEach {
            users[$0] = User(username: $0, likeCount: 0)
        }
    }

    func like(_ username: String) {
        users[username]?.likeCount += 1
        NotificationCenter.default.post(name: .userUpdated, object: username)
    }

    func unlike(_ username: String) {
        guard let user = users[username], user.likeCount > 0 else { return }
        user.likeCount -= 1
        NotificationCenter.default.post(name: .userUpdated, object: username)
    }

    func getUser(_ username: String) -> User? {
        return users[username]
    }

    func getAllUsers() -> [User] {
        return Array(users.values)
    }
}

extension Notification.Name {
    static let userUpdated = Notification.Name("userUpdated")
}
*/
