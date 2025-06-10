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

//NEW ONE SO WE HAVE YourFriendsDataController FriendDataController
class FriendDataController {
    static let shared = FriendDataController()

    private let friendAPI = FriendAPI()
    private let imageFunctions = ImageFunctions()
    private let userDefaultManager = UserDefaultManager()

    //DO I NEED TYPES OF FRIENDS HERE NOT SURE PROBABLY NOT
    //call yourFriends
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

extension FriendDataController {
    
    func cancelFriendRequest(for user: Friend) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.cancelFriendRequest(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                removeFriend(user)
                return true
            }
        } catch {
            print("Error cancelling friend request: \(error)")
        }
        return false
    }

    func removeFriendFromServer(_ user: Friend) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.removeFriend(
                masterSite: "kite",
                currentUser: currentUser,
                removeFriendName: user.friendName
            )
            if response.success {
                removeFriend(user)
                return true
            }
        } catch {
            print("Error removing friend: \(error)")
        }
        return false
    }

    func acceptFriendInvite(_ user: Friend) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.acceptFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                var updatedUser = user
                updatedUser.friendshipKey = FriendshipStatus.friends.rawValue
                addFriend(updatedUser)
                return true
            }
        } catch {
            print("Error accepting invite: \(error)")
        }
        return false
    }

    func declineFriendInvite(_ user: Friend) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.declineFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.friendName
            )
            if response.success {
                removeFriend(user)
                return true
            }
        } catch {
            print("Error declining invite: \(error)")
        }
        return false
    }
}
