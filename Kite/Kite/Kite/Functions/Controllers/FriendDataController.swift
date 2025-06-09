//
//  FriendDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/9/25.
//

import UIKit


extension Notification.Name {
    static let friendsUpdated = Notification.Name("friendsUpdated")
}

class FriendDataController {
    static let shared = FriendDataController()

    private let friendAPI = FriendAPI()
    private let imageFunctions = ImageFunctions()
    private let userDefaultManager = UserDefaultManager()

    private(set) var friends: [Friend] = []

    func fetchFriends() async throws {
        let currentUser = userDefaultManager.getLoggedInUser()
        let friendsResponse = try await friendAPI.getAllCurrentUserFriends(currentUser: currentUser)
        var fetchedFriends = friendAPI.convertToFriendObjects(from: friendsResponse.data)

        // Preload images
        await withTaskGroup(of: Void.self) { group in
            for friend in fetchedFriends {
                group.addTask {
                    if let image = await self.imageFunctions.fetchImage(from: friend.friendImage) {
                        friend.profileImage = image
                    }
                }
            }
        }

        self.friends = fetchedFriends
    }

    func addFriend(_ friend: Friend) {
        if !friends.contains(where: { $0.friendID == friend.friendID }) {
            friends.append(friend)
        }
    }

    func removeFriend(_ friend: Friend) {
        friends.removeAll { $0.friendID == friend.friendID }
    }
}
