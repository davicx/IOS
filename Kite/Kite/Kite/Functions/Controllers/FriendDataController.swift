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

    private(set) var friends: [User] = []
    

    func fetchFriends() async throws {
        let currentUser = userDefaultManager.getLoggedInUser()
        let friendsResponse = try await friendAPI.getAllCurrentUserFriends(currentUser: currentUser)
        
        // Use our new batch image fetching function
        let fetchedFriends = await createUsersFromFriendsWithImages(friendsResponse.data)

        self.friends = fetchedFriends
    }

    func splitFriendsByStatus() -> (friends: [User], requests: [User]) {
        let friends = self.friends.filter {
            $0.friendshipStatus == .friends
        }

        let requests = self.friends.filter {
            $0.friendshipStatus == .invitePendingSentByYou
        }

        return (friends, requests)
    }

    
    func addFriend(_ friend: User) {
        if !friends.contains(where: { $0.userID == friend.userID }) {
            friends.append(friend)
        }
    }

    func removeFriend(_ friend: User) {
        friends.removeAll { $0.userID == friend.userID }
    }
    
    
}


extension FriendDataController {
    func sendFriendRequest(to user: User) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.addFriend(
                masterSite: "kite",
                currentUser: currentUser,
                addFriendName: user.userName
            )

            if response.success {
                var updatedUser = user
                updatedUser.setFriendProperties(requestPending: 1, requestSentBy: currentUser, friendshipKey: FriendshipStatus.invitePendingSentByYou.rawValue, alsoYourFriend: 0)
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
    
    func cancelFriendRequest(for user: User) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.cancelFriendRequest(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.userName
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
    

    func removeFriendFromServer(_ user: User) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.removeFriend(
                masterSite: "kite",
                currentUser: currentUser,
                removeFriendName: user.userName
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

    func acceptFriendInvite(_ user: User) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.acceptFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.userName
            )
            if response.success {
                var updatedUser = user
                updatedUser.setFriendProperties(requestPending: 0, requestSentBy: currentUser, friendshipKey: FriendshipStatus.friends.rawValue, alsoYourFriend: 1)
                addFriend(updatedUser)
                return true
            }
        } catch {
            print("Error accepting invite: \(error)")
        }
        return false
    }

    func declineFriendInvite(_ user: User) async -> Bool {
        do {
            let currentUser = userDefaultManager.getLoggedInUser()
            let response = try await friendAPI.declineFriendInvite(
                masterSite: "kite",
                currentUser: currentUser,
                friendName: user.userName
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

    func cancelRequest(to friend: User) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().cancelFriendRequest(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "CancelFriendRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func remove(friend: User) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().removeFriend(
            masterSite: "kite",
            currentUser: currentUser,
            removeFriendName: friend.userName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "RemoveFriend", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func accept(inviteFrom friend: User) async throws -> User {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().acceptFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        if response.success {
            var updatedFriend = friend
            updatedFriend.setFriendProperties(requestPending: 0, requestSentBy: currentUser, friendshipKey: FriendshipStatus.friends.rawValue, alsoYourFriend: 1)
            addFriend(updatedFriend)
            return updatedFriend
        } else {
            throw NSError(domain: "AcceptFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }

    func decline(inviteFrom friend: User) async throws {
        let currentUser = UserDefaultManager().getLoggedInUser()
        let response = try await FriendAPI().declineFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        if response.success {
            removeFriend(friend)
        } else {
            throw NSError(domain: "DeclineFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
}
