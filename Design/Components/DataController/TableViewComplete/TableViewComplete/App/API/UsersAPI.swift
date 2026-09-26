//
//  UsersAPI.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/24/25.
//  Copyright © 2025 David Vasquez. All rights reserved.
//


import UIKit


final class UsersAPI {

    //API: Call Get Users 
    func getUsersAPI() async throws -> [User] {

        if #available(iOS 13.0, *) {
            // Non-blocking async/await delay
            try await Task.sleep(nanoseconds: 500_000_000)
        } else {
            // Pre-iOS 13 fallback — MUST NOT be on main thread
            Thread.sleep(forTimeInterval: 0.5)
        }

        // Pretend this came from the backend
        return createUsers()
    }

    
    private func createUsers() -> [User] {

        let david = User(
            userName: "David",
            userImage: UIImage(named: "river"),
            userFollowers: ["Sam", "Merry"]
        )

        let frodo = User(
            userName: "Frodo",
            userImage: UIImage(named: "train"),
            userFollowers: ["Sam", "Merry"]
        )

        let sam = User(
            userName: "Sam",
            userImage: UIImage(named: "night")
        )

        let merry = User(
            userName: "Merry",
            userImage: UIImage(named: "whale"),
            userFollowers: ["Sam"]
        )

        return [david, frodo, sam, merry]
    }
}
