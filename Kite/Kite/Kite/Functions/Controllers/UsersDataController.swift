//
//  UsersDataController.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import UIKit

extension Notification.Name {
    static let usersUpdated = Notification.Name("usersUpdated")
    static let friendsUpdated = Notification.Name("friendsUpdated")
}

class UsersDataController {
    static let shared = UsersDataController()
    
    // Dictionary to store all users by username (current user, friends, group members, etc.)
    private(set) var users: [String: User] = [:]
    
    // Callback to notify when users are updated (legacy support)
    var onUsersUpdated: (() -> Void)?
    
    private let profileAPI = ProfileAPI()
    private let friendAPI = FriendAPI()
    private let userDefaultManager = UserDefaultManager()
    
    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }
    
    // MARK: - User Retrieval
    
    // Get user by username (from cache)
    func getUser(username: String) -> User? {
        return users[username]
    }
    
    // Get UserModel by username (for backward compatibility - converts User to UserModel)
    func getUserModel(username: String) -> UserModel? {
        guard let user = users[username] else { return nil }
        // Convert User back to UserModel if needed
        // Note: This is a lossy conversion - friendship data may not be preserved
        return UserModel(
            userID: user.userID,
            userName: user.userName,
            userImage: user.profileImageURL,
            firstName: user.firstName,
            lastName: user.lastName,
            biography: user.biography,
            requestPending: user.requestPending ?? 0,
            requestSentBy: user.requestSentBy ?? "",
            friendshipKey: user.friendshipKey ?? "",
            alsoYourFriend: user.alsoYourFriend ?? 0
        )
    }
    
    // Check if user is already cached
    func hasUser(username: String) -> Bool {
        return users[username] != nil
    }
    
    // Get or fetch user (checks cache first, then fetches if needed)
    func getOrFetchUser(username: String) async -> User? {
        // Check if we already have this user cached
        if let cachedUser = users[username] {
            return cachedUser
        }
        
        // If not cached, fetch from API
        return await fetchUser(username: username)
    }
    
    // MARK: - User Fetching
    
    // Fetch user profile from API and cache it as User
    func fetchUser(username: String) async -> User? {
        do {
            let response = try await profileAPI.getUserProfileAPI(currentUser: username)
            
            if response.statusCode == 401 {
                LoginManager.shared.logoutCurrentUser()
                return nil
            }
            
            if response.success {
                let userProfile = response.data
                let isCurrentUser = (username == currentUser)
                let user = createUserFromProfile(userProfile, isCurrentUser: isCurrentUser)
                
                // Store in cache
                users[username] = user
                
                // Fetch image asynchronously
                Task {
                    await user.fetchProfileImage()
                    DispatchQueue.main.async {
                        self.notifyUsersUpdated()
                    }
                }
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                }
                
                return user
            } else {
                print("UsersDataController: Failed to fetch user \(username) - \(response.message)")
                return nil
            }
        } catch {
            print("UsersDataController: Error fetching user \(username) - \(error)")
            return nil
        }
    }
    
    // Fetch multiple users at once
    func fetchUsers(usernames: [String]) async -> [User] {
        var fetchedUsers: [User] = []
        
        // Process users in parallel
        await withTaskGroup(of: User?.self) { group in
            for username in usernames {
                group.addTask {
                    await self.getOrFetchUser(username: username)
                }
            }
            
            for await user in group {
                if let user = user {
                    fetchedUsers.append(user)
                }
            }
        }
        
        return fetchedUsers
    }
    
    // Fetch multiple users and convert them to User objects with images
    func fetchUsersWithImages(usernames: [String]) async -> [User] {
        let users = await fetchUsers(usernames: usernames)
        await fetchImagesForUsers(users)
        return users
    }
    
    // MARK: - Friend Management
    
    // Fetch all friends for the current user
    func fetchFriends() async throws {
        let currentUsername = currentUser
        let friendsResponse = try await friendAPI.getAllCurrentUserFriends(currentUser: currentUsername)
        
        // Convert to User objects with images
        let fetchedFriends = await createUsersFromFriendsWithImages(friendsResponse.data)
        
        // Store all friends in the users dictionary
        for friend in fetchedFriends {
            users[friend.userName] = friend
        }
        
        DispatchQueue.main.async {
            self.notifyUsersUpdated()
            NotificationCenter.default.post(name: .friendsUpdated, object: nil)
        }
    }
    
    // Get all friends (users with friendship status)
    func getFriends() -> [User] {
        return Array(users.values).filter { $0.friendshipKey != nil }
    }
    
    // Split friends by status
    func splitFriendsByStatus() -> (friends: [User], requests: [User]) {
        let allFriends = getFriends()
        
        let friends = allFriends.filter {
            $0.friendshipStatus == .friends
        }
        
        let requests = allFriends.filter {
            $0.friendshipStatus == .invitePendingSentByYou
        }
        
        return (friends, requests)
    }
    
    // MARK: - Friend Actions
    
    func sendFriendRequest(to user: User) async -> Bool {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.addFriend(
                masterSite: "kite",
                currentUser: currentUsername,
                addFriendName: user.userName
            )
            
            if response.success {
                var updatedUser = user
                updatedUser.setFriendProperties(
                    requestPending: 1,
                    requestSentBy: currentUsername,
                    friendshipKey: FriendshipStatus.invitePendingSentByYou.rawValue,
                    alsoYourFriend: 0
                )
                
                // Update in cache
                users[user.userName] = updatedUser
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return true
            }
        } catch {
            print("Error sending friend request: \(error)")
        }
        return false
    }
    
    func cancelFriendRequest(for user: User) async -> Bool {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.cancelFriendRequest(
                masterSite: "kite",
                currentUser: currentUsername,
                friendName: user.userName
            )
            
            if response.success {
                // Remove friendship properties
                var updatedUser = user
                updatedUser.clearFriendProperties()
                users[user.userName] = updatedUser
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return true
            }
        } catch {
            print("Error cancelling friend request: \(error)")
        }
        return false
    }
    
    func cancelRequest(to friend: User) async throws {
        let currentUsername = currentUser
        let response = try await friendAPI.cancelFriendRequest(
            masterSite: "kite",
            currentUser: currentUsername,
            friendName: friend.userName
        )
        
        if response.success {
            var updatedUser = friend
            updatedUser.clearFriendProperties()
            users[friend.userName] = updatedUser
            
            DispatchQueue.main.async {
                self.notifyUsersUpdated()
                NotificationCenter.default.post(name: .friendsUpdated, object: nil)
            }
        } else {
            throw NSError(domain: "CancelFriendRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func removeFriendFromServer(_ user: User) async -> Bool {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.removeFriend(
                masterSite: "kite",
                currentUser: currentUsername,
                removeFriendName: user.userName
            )
            
            if response.success {
                var updatedUser = user
                updatedUser.clearFriendProperties()
                users[user.userName] = updatedUser
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return true
            }
        } catch {
            print("Error removing friend: \(error)")
        }
        return false
    }
    
    func remove(friend: User) async throws {
        let currentUsername = currentUser
        let response = try await friendAPI.removeFriend(
            masterSite: "kite",
            currentUser: currentUsername,
            removeFriendName: friend.userName
        )
        
        if response.success {
            var updatedUser = friend
            updatedUser.clearFriendProperties()
            users[friend.userName] = updatedUser
            
            DispatchQueue.main.async {
                self.notifyUsersUpdated()
                NotificationCenter.default.post(name: .friendsUpdated, object: nil)
            }
        } else {
            throw NSError(domain: "RemoveFriend", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func acceptFriendInvite(_ user: User) async -> Bool {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.acceptFriendInvite(
                masterSite: "kite",
                currentUser: currentUsername,
                friendName: user.userName
            )
            
            if response.success {
                var updatedUser = user
                updatedUser.setFriendProperties(
                    requestPending: 0,
                    requestSentBy: currentUsername,
                    friendshipKey: FriendshipStatus.friends.rawValue,
                    alsoYourFriend: 1
                )
                
                users[user.userName] = updatedUser
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return true
            }
        } catch {
            print("Error accepting invite: \(error)")
        }
        return false
    }
    
    func accept(inviteFrom friend: User) async throws -> User {
        let currentUsername = currentUser
        let response = try await friendAPI.acceptFriendInvite(
            masterSite: "kite",
            currentUser: currentUsername,
            friendName: friend.userName
        )
        
        if response.success {
            var updatedFriend = friend
            updatedFriend.setFriendProperties(
                requestPending: 0,
                requestSentBy: currentUsername,
                friendshipKey: FriendshipStatus.friends.rawValue,
                alsoYourFriend: 1
            )
            
            users[friend.userName] = updatedFriend
            
            DispatchQueue.main.async {
                self.notifyUsersUpdated()
                NotificationCenter.default.post(name: .friendsUpdated, object: nil)
            }
            
            return updatedFriend
        } else {
            throw NSError(domain: "AcceptFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    func declineFriendInvite(_ user: User) async -> Bool {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.declineFriendInvite(
                masterSite: "kite",
                currentUser: currentUsername,
                friendName: user.userName
            )
            
            if response.success {
                var updatedUser = user
                updatedUser.clearFriendProperties()
                users[user.userName] = updatedUser
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return true
            }
        } catch {
            print("Error declining invite: \(error)")
        }
        return false
    }
    
    func decline(inviteFrom friend: User) async throws {
        let currentUsername = currentUser
        let response = try await friendAPI.declineFriendInvite(
            masterSite: "kite",
            currentUser: currentUsername,
            friendName: friend.userName
        )
        
        if response.success {
            var updatedUser = friend
            updatedUser.clearFriendProperties()
            users[friend.userName] = updatedUser
            
            DispatchQueue.main.async {
                self.notifyUsersUpdated()
                NotificationCenter.default.post(name: .friendsUpdated, object: nil)
            }
        } else {
            throw NSError(domain: "DeclineFriendInvite", code: 1, userInfo: [NSLocalizedDescriptionKey: response.message])
        }
    }
    
    // MARK: - User Management
    
    // Add or update a user in the cache
    func addOrUpdateUser(_ user: User) {
        users[user.userName] = user
        notifyUsersUpdated()
    }
    
    // Update user profile (when user updates their own profile)
    func updateUser(username: String, updatedUser: User) {
        users[username] = updatedUser
        notifyUsersUpdated()
    }
    
    // Update user from UserModel (for backward compatibility)
    func updateUserFromModel(username: String, userModel: UserModel) {
        let isCurrentUser = (username == currentUser)
        let user = createUserFromProfile(userModel, isCurrentUser: isCurrentUser)
        users[username] = user
        notifyUsersUpdated()
    }
    
    // Remove user from cache
    func removeUser(username: String) {
        users.removeValue(forKey: username)
        notifyUsersUpdated()
    }
    
    // Clear all cached users (useful for logout)
    func clearAllUsers() {
        users.removeAll()
        notifyUsersUpdated()
    }
    
    // Get all cached users
    func getAllUsers() -> [User] {
        return Array(users.values)
    }
    
    // Get users by usernames (returns only cached users)
    func getCachedUsers(usernames: [String]) -> [User] {
        return usernames.compactMap { users[$0] }
    }
    
    // MARK: - Notifications
    
    private func notifyUsersUpdated() {
        DispatchQueue.main.async {
            self.onUsersUpdated?()
            NotificationCenter.default.post(name: .usersUpdated, object: nil)
        }
    }
}
