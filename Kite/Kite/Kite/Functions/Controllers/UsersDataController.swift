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
    
    // Serial queue for thread-safe dictionary access
    private let usersQueue = DispatchQueue(label: "com.kite.usersDataController")
    
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
        return usersQueue.sync {
        return users[username]
        }
    }
    
    // Get UserModel by username (for backward compatibility - converts User to UserModel)
    func getUserModel(username: String) -> UserModel? {
        guard let user = usersQueue.sync(execute: { users[username] }) else { return nil }
        // Convert User back to UserModel if needed
        return UserModel(
            userID: user.userID,
            userName: user.userName,
            userImage: user.userImage,
            firstName: user.firstName,
            lastName: user.lastName,
            biography: user.biography,
            requestPending: user.requestPending,
            requestSentBy: user.requestSentBy,
            friendshipKey: user.friendshipKey,
            alsoYourFriend: user.alsoYourFriend
        )
    }
    
    // Check if user is already cached
    func hasUser(username: String) -> Bool {
        return usersQueue.sync {
        return users[username] != nil
        }
    }
    
    // Get or fetch user (checks cache first, then fetches if needed)
    func getOrFetchUser(username: String) async -> User? {
        // Check if we already have this user cached
        let cachedUser = usersQueue.sync {
            return users[username]
        }
        if let cachedUser = cachedUser {
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
                let user = createUser(from: userProfile, isCurrentUser: isCurrentUser)
                
                // Store in cache (thread-safe)
                usersQueue.async {
                    self.users[username] = user
                }
                
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
    // refreshFriendshipStatus: If true, fetches fresh friendship data first before returning users
    // This ensures friendship status is up-to-date while still caching profile data (name, image, bio)
    func fetchUsersWithImages(usernames: [String], refreshFriendshipStatus: Bool = false) async -> [User] {
        // If refresh needed, fetch fresh friends list first to update cache with latest friendship data
        if refreshFriendshipStatus {
            do {
                _ = try await fetchFriends()
            } catch {
                print("UsersDataController: Error refreshing friendship status: \(error)")
                // Continue anyway - we'll use cached data if available
            }
        }
        
        // Fetch users (will use cached profile data, but friendship data will be fresh if refreshFriendshipStatus was true)
        let users = await fetchUsers(usernames: usernames)
        await fetchImagesForUsers(users)
        return users
    }
    
    // MARK: - Friend Management
    
    // Fetch all friends for the current user
    // This updates the cache with fresh friendship data for all users who have a relationship with the current user
    // Returns the set of usernames that are in the API response (have a friendship relationship)
    func fetchFriends() async throws -> Set<String> {
        let currentUsername = currentUser
        let friendsResponse = try await friendAPI.getAllCurrentUserFriends(currentUser: currentUsername)
        
        // Convert to User objects with images
        let fetchedFriends = await createUsersWithImages(from: friendsResponse.data)
        
        // Track which usernames are in the API response
        var usernamesInResponse = Set<String>()
        
        // Collect usernames first
        for friend in fetchedFriends {
            usernamesInResponse.insert(friend.userName)
        }
        
        // Store all friends in the users dictionary (thread-safe)
        // This overwrites existing cached users with fresh data from the friends API
        // The friends API returns complete user profiles (name, image, bio) + friendship status
        await withCheckedContinuation { continuation in
            usersQueue.async {
                for friend in fetchedFriends {
                    // Preserve cached profile image if it exists and is already loaded
                    if let existingUser = self.users[friend.userName], let cachedImage = existingUser.profileImage {
                        friend.profileImage = cachedImage
                    }
                    self.users[friend.userName] = friend
                }
                continuation.resume()
            }
        }
        
        DispatchQueue.main.async {
            self.notifyUsersUpdated()
            NotificationCenter.default.post(name: .friendsUpdated, object: nil)
        }
        
        return usernamesInResponse
    }
    
    // Get all friends (users with friendship status)
    func getFriends() -> [User] {
        return usersQueue.sync {
            return Array(users.values).filter { !$0.friendshipKey.isEmpty && $0.friendshipKey != "not_friends" }
        }
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
    
    func sendFriendRequest(to user: User) async -> User? {
        do {
            let currentUsername = currentUser
            let response = try await friendAPI.addFriend(
                masterSite: "kite",
                currentUser: currentUsername,
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
                updatedUser.requestSentBy = friendData.requestSentBy.isEmpty ? currentUsername : friendData.requestSentBy
                updatedUser.friendshipKey = friendshipKey
                updatedUser.alsoYourFriend = friendData.alsoYourFriend
                
                // Update in cache (thread-safe, synchronous to ensure update completes)
                usersQueue.sync {
                    self.users[user.userName] = updatedUser
                }
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                    NotificationCenter.default.post(name: .friendsUpdated, object: nil)
                }
                
                return updatedUser
            }
        } catch {
            print("Error sending friend request: \(error)")
        }
        return nil
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
                updatedUser.friendshipKey = "not_friends"
                updatedUser.requestPending = 0
                updatedUser.requestSentBy = ""
                updatedUser.alsoYourFriend = 0
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
            updatedUser.friendshipKey = "not_friends"
            updatedUser.requestPending = 0
            updatedUser.requestSentBy = ""
            updatedUser.alsoYourFriend = 0
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
                updatedUser.friendshipKey = "not_friends"
                updatedUser.requestPending = 0
                updatedUser.requestSentBy = ""
                updatedUser.alsoYourFriend = 0
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
            updatedUser.friendshipKey = "not_friends"
            updatedUser.requestPending = 0
            updatedUser.requestSentBy = ""
            updatedUser.alsoYourFriend = 0
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
                updatedUser.requestPending = 0
                updatedUser.requestSentBy = currentUsername
                updatedUser.friendshipKey = FriendshipStatus.friends.rawValue
                updatedUser.alsoYourFriend = 1
                
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
            updatedFriend.requestPending = 0
            updatedFriend.requestSentBy = currentUsername
            updatedFriend.friendshipKey = FriendshipStatus.friends.rawValue
            updatedFriend.alsoYourFriend = 1
            
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
                updatedUser.friendshipKey = "not_friends"
                updatedUser.requestPending = 0
                updatedUser.requestSentBy = ""
                updatedUser.alsoYourFriend = 0
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
            updatedUser.friendshipKey = "not_friends"
            updatedUser.requestPending = 0
            updatedUser.requestSentBy = ""
            updatedUser.alsoYourFriend = 0
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
        usersQueue.async {
            self.users[user.userName] = user
        }
        notifyUsersUpdated()
    }
    
    // Update user profile (when user updates their own profile)
    func updateUser(username: String, updatedUser: User) {
        usersQueue.async {
            self.users[username] = updatedUser
        }
        notifyUsersUpdated()
    }
    
    // Update user from UserModel (for backward compatibility)
    func updateUserFromModel(username: String, userModel: UserModel) {
        let isCurrentUser = (username == currentUser)
        let user = createUser(from: userModel, isCurrentUser: isCurrentUser)
        usersQueue.async {
            self.users[username] = user
        }
        notifyUsersUpdated()
    }
    
    // Fetch and update user counts (totalFriends, totalGroups, totalPosts) from API
    // Updates the User object if it exists in cache, or creates a new one if it doesn't
    func fetchAndUpdateUserCounts(username: String) async -> Bool {
        do {
            let response = try await profileAPI.getUserCountsAPI(currentUser: username)
            
            if response.statusCode == 401 {
                LoginManager.shared.logoutCurrentUser()
                return false
            }
            
            if response.success, let countData = response.data.first {
                let isCurrentUserFlag = (username == currentUser)
                
                // Update user in cache (thread-safe)
                usersQueue.sync {
                    if var user = self.users[username] {
                        // Update existing user's counts
                        user.totalFriends = countData.totalFriends
                        user.totalGroups = countData.totalGroups
                        user.totalPosts = countData.totalPosts
                        self.users[username] = user
                    } else {
                        // User doesn't exist in cache yet - create a minimal user with counts
                        // This shouldn't normally happen, but handle it gracefully
                        let user = User(
                            userID: countData.userID,
                            userName: countData.userName,
                            userImage: "",
                            firstName: "",
                            lastName: "",
                            biography: "",
                            isCurrentUser: isCurrentUserFlag,
                            friendshipKey: "not_friends",
                            requestPending: 0,
                            requestSentBy: "",
                            alsoYourFriend: 0,
                            totalFriends: countData.totalFriends,
                            totalGroups: countData.totalGroups,
                            totalPosts: countData.totalPosts
                        )
                        self.users[username] = user
                    }
                }
                
                DispatchQueue.main.async {
                    self.notifyUsersUpdated()
                }
                
                return true
            } else {
                print("UsersDataController: Failed to fetch user counts for \(username) - \(response.message)")
                return false
            }
        } catch {
            print("UsersDataController: Error fetching user counts for \(username) - \(error)")
            return false
        }
    }
    
    // Remove user from cache
    func removeUser(username: String) {
        usersQueue.async {
            self.users.removeValue(forKey: username)
        }
        notifyUsersUpdated()
    }
    
    // Clear all cached users (useful for logout)
    func clearAllUsers() {
        usersQueue.async {
            self.users.removeAll()
        }
        notifyUsersUpdated()
    }
    
    // Get all cached users
    func getAllUsers() -> [User] {
        return usersQueue.sync {
        return Array(users.values)
        }
    }
    
    // Get users by usernames (returns only cached users)
    func getCachedUsers(usernames: [String]) -> [User] {
        return usersQueue.sync {
        return usernames.compactMap { users[$0] }
        }
    }
    
    // MARK: - Notifications
    
    private func notifyUsersUpdated() {
        DispatchQueue.main.async {
            self.onUsersUpdated?()
            NotificationCenter.default.post(name: .usersUpdated, object: nil)
        }
    }
}
