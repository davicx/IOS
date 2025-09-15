//
//  UsersDataController.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import UIKit

class UsersDataController {
    static let shared = UsersDataController()
    
    // Dictionary to store user profiles by username
    private(set) var users: [String: UserProfileModel] = [:]
    
    // Callback to notify when users are updated
    var onUsersUpdated: (() -> Void)?
    
    private let profileAPI = ProfileAPI()
    private let userDefaultManager = UserDefaultManager()
    
    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }
    
    // Get user profile by username (from cache)
    func getUser(username: String) -> UserProfileModel? {
        return users[username]
    }
    
    // Check if user is already cached
    func hasUser(username: String) -> Bool {
        return users[username] != nil
    }
    
    // Fetch user profile from API and cache it
    func fetchUser(username: String) async -> UserProfileModel? {
        do {
            let response = try await profileAPI.getUserProfileAPI(currentUser: username)
            
            if response.statusCode == 401 {
                LoginManager.shared.logoutCurrentUser()
                return nil
            }
            
            if response.success {
                let userProfile = response.data
                users[username] = userProfile
                
                DispatchQueue.main.async {
                    self.onUsersUpdated?()
                }
                
                return userProfile
            } else {
                print("UsersDataController: Failed to fetch user \(username) - \(response.message)")
                return nil
            }
        } catch {
            print("UsersDataController: Error fetching user \(username) - \(error)")
            return nil
        }
    }
    
    // Get or fetch user profile (checks cache first, then fetches if needed)
    func getOrFetchUser(username: String) async -> UserProfileModel? {
        // Check if we already have this user cached
        if let cachedUser = users[username] {
            return cachedUser
        }
        
        // If not cached, fetch from API
        return await fetchUser(username: username)
    }
    
    // Fetch multiple users at once
    func fetchUsers(usernames: [String]) async -> [UserProfileModel] {
        var fetchedUsers: [UserProfileModel] = []
        
        // Process users in parallel
        await withTaskGroup(of: UserProfileModel?.self) { group in
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
        let userProfileModels = await fetchUsers(usernames: usernames)
        return await createUsersFromProfilesWithImages(userProfileModels)
    }
    
    // Update user profile (when user updates their own profile)
    func updateUser(username: String, updatedUser: UserProfileModel) {
        users[username] = updatedUser
        onUsersUpdated?()
    }
    
    // Remove user from cache
    func removeUser(username: String) {
        users.removeValue(forKey: username)
        onUsersUpdated?()
    }
    
    // Clear all cached users (useful for logout)
    func clearAllUsers() {
        users.removeAll()
        onUsersUpdated?()
    }
    
    // Get all cached users
    func getAllUsers() -> [UserProfileModel] {
        return Array(users.values)
    }
    
    // Get users by usernames (returns only cached users)
    func getCachedUsers(usernames: [String]) -> [UserProfileModel] {
        return usernames.compactMap { users[$0] }
    }
}