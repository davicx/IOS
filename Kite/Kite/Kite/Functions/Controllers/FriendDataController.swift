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

    func splitFriendsByStatus() -> (friends: [Friend], requests: [Friend]) {
        let friends = self.friends.filter {
            FriendshipStatus(key: $0.friendshipKey) == .friends
        }

        let requests = self.friends.filter {
            FriendshipStatus(key: $0.friendshipKey) == .invitePendingSentByYou
        }

        return (friends, requests)
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
    func sendFriendRequest(to user: Friend) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.addFriend(
                masterSite: "kite",
                currentUser: currentUser,
                addFriendName: user.friendName
            )

            if response.success {
                var updatedUser = user
                updatedUser.friendshipKey = FriendshipStatus.invitePendingSentByYou.rawValue // define this in your enum
                addFriend(updatedUser)

                // Notify other views
                NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                return true
            }
        } catch {
            print("Error sending friend request: \(error)")
        }
        return false
    }
    
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


// FriendDataController.swift
extension FriendDataController {

    func cancelRequest(to friend: Friend) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().cancelFriendRequest(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.friendName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "CancelFriendRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func remove(friend: Friend) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().removeFriend(
            masterSite: "kite",
            currentUser: currentUser,
            removeFriendName: friend.friendName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "RemoveFriend", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func accept(inviteFrom friend: Friend) async throws -> Friend {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().acceptFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.friendName
        )
        if response.success {
            var updatedFriend = friend
            updatedFriend.friendshipKey = FriendshipStatus.friends.rawValue
            addFriend(updatedFriend)
            return updatedFriend
        } else {
            throw NSError(domain: "AcceptFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func decline(inviteFrom friend: Friend) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().declineFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.friendName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "DeclineFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
}
