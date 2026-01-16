//
//  UserLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/15/26.
//

import Foundation

final class UserLogic {
    static let shared = UserLogic()
    private init() {}
    
    private let usersDataController = UsersDataController.shared
    private let friendAPI = FriendAPI()
    private let userDefaultManager = UserDefaultManager()
    
    private var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }
    
    // MARK: - Friend Actions
    
    func sendFriendRequest(to user: User) async -> User? {
        do {
            let response = try await friendAPI.addFriend(
                masterSite: "kite",
                currentUser: currentUser,
                addFriendName: user.userName
            )
            
            if response.success {
                var updatedUser = user
                
                // Use API response data if available, otherwise use defaults
                let friendData = response.data.friendData
                // API returns "request_pending" when you send a friend request (you can cancel)
                // This maps to .invitePendingSentByYou via calculateFriendshipStatus
                var friendshipKey = friendData.friendshipKey.isEmpty ? "request_pending" : friendData.friendshipKey
                if friendshipKey == "new_request_pending" {
                    friendshipKey = "request_pending"
                }
                
                // Update friend properties directly
                updatedUser.requestPending = friendData.requestPending
                updatedUser.requestSentBy = friendData.requestSentBy.isEmpty ? currentUser : friendData.requestSentBy
                updatedUser.friendshipKey = friendshipKey
                updatedUser.alsoYourFriend = friendData.alsoYourFriend
                
                // Update in UsersDataController (which posts notification)
                usersDataController.updateUserFriendStatus(user: updatedUser)
                
                return updatedUser
            }
        } catch {
            print("UserLogic: Error sending friend request: \(error)")
        }
        return nil
    }
    
    func cancelRequest(to friend: User) async throws {
        let response = try await friendAPI.cancelFriendRequest(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        
        if response.success {
            // Update user to not_friends status in UsersDataController
            usersDataController.updateUserFriendStatusToNotFriends(username: friend.userName)
        } else {
            throw NSError(domain: "CancelFriendRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func remove(friend: User) async throws {
        let response = try await friendAPI.removeFriend(
            masterSite: "kite",
            currentUser: currentUser,
            removeFriendName: friend.userName
        )
        
        if response.success {
            // Update user to not_friends status in UsersDataController
            usersDataController.updateUserFriendStatusToNotFriends(username: friend.userName)
        } else {
            throw NSError(domain: "RemoveFriend", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func accept(inviteFrom friend: User) async throws -> User {
        let response = try await friendAPI.acceptFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        
        if response.success {
            var updatedFriend = friend
            updatedFriend.requestPending = 0
            updatedFriend.requestSentBy = currentUser
            updatedFriend.friendshipKey = FriendshipStatus.friends.rawValue
            updatedFriend.alsoYourFriend = 1
            
            // Update in UsersDataController (which posts notification)
            usersDataController.updateUserFriendStatus(user: updatedFriend)
            
            return updatedFriend
        } else {
            throw NSError(domain: "AcceptFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func decline(inviteFrom friend: User) async throws {
        let response = try await friendAPI.declineFriendInvite(
            masterSite: "kite",
            currentUser: currentUser,
            friendName: friend.userName
        )
        
        if response.success {
            // Update user to not_friends status in UsersDataController
            usersDataController.updateUserFriendStatusToNotFriends(username: friend.userName)
        } else {
            throw NSError(domain: "DeclineFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
}
