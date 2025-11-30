//
//  userFunctions.swift
//  Kite
//
//  Created by David Vasquez on 9/13/25.
//

import Foundation
import UIKit

// MARK: - Image Cache Manager

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    private let imageFunctions = ImageFunctions()
    
    private init() {
        // Configure cache limits
        cache.countLimit = 100 // Maximum 100 images in memory
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB total memory limit
    }
    
    func getCachedImage(for urlString: String) -> UIImage? {
        return cache.object(forKey: urlString as NSString)
    }
    
    func cacheImage(_ image: UIImage, for urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
    }
    
    func fetchImageIfNeeded(from urlString: String) async -> UIImage? {
        // Check cache first
        if let cachedImage = getCachedImage(for: urlString) {
            return cachedImage
        }
        
        // Fetch from network if not cached
        if let image = await imageFunctions.fetchImage(from: urlString) {
            cacheImage(image, for: urlString)
            return image
        }
        
        return nil
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

// MARK: - User Factory Methods

/// Creates a User from UserProfileModel data
func createUserFromProfile(_ userProfileModel: UserModel, isCurrentUser: Bool = false) -> User {
    let user = User(
        userID: userProfileModel.userID,
        userName: userProfileModel.userName,
        profileImageURL: userProfileModel.userImage,
        firstName: userProfileModel.firstName.isEmpty ? "Unknown" : userProfileModel.firstName,
        lastName: userProfileModel.lastName.isEmpty ? "User" : userProfileModel.lastName,
        biography: userProfileModel.biography.isEmpty ? "" : userProfileModel.biography,
        isCurrentUser: isCurrentUser
    )
    
    // Set friendship properties if available in UserModel
    // Check if friendshipKey is not empty (UserModel always has these fields, but they might be empty strings)
    if !userProfileModel.friendshipKey.isEmpty && userProfileModel.friendshipKey != "friendshipKey" {
        user.setFriendProperties(
            requestPending: userProfileModel.requestPending,
            requestSentBy: userProfileModel.requestSentBy,
            friendshipKey: userProfileModel.friendshipKey,
            alsoYourFriend: userProfileModel.alsoYourFriend
        )
    }
    
    return user
}

/// Creates a User from UserProfileModel data and fetches the profile image
func createUserFromProfileWithImage(_ userProfileModel: UserModel, isCurrentUser: Bool = false) async -> User {
    let user = createUserFromProfile(userProfileModel, isCurrentUser: isCurrentUser)
    
    // Fetch and cache the profile image
    if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: user.profileImageURL) {
        user.profileImage = image
    }
    
    return user
}

/// Creates a User from UserModel data with friend-specific properties
func createUserFromFriend(_ userModel: UserModel) -> User {
    let user = User(
        userID: userModel.userID,
        userName: userModel.userName,
        profileImageURL: userModel.userImage,
        firstName: userModel.firstName.isEmpty ? "Unknown" : userModel.firstName,
        lastName: userModel.lastName.isEmpty ? "User" : userModel.lastName,
        biography: userModel.biography,
        isCurrentUser: false
    )
    
    // Set friend-specific properties
    user.setFriendProperties(
        requestPending: userModel.requestPending,
        requestSentBy: userModel.requestSentBy,
        friendshipKey: userModel.friendshipKey,
        alsoYourFriend: userModel.alsoYourFriend
    )
    
    return user
}

/// Creates a User from UserModel data with friend-specific properties and fetches the profile image
func createUserFromFriendWithImage(_ userModel: UserModel) async -> User {
    let user = createUserFromFriend(userModel)
    
    // Fetch and cache the profile image
    if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: user.profileImageURL) {
        user.profileImage = image
    }
    
    return user
}

// MARK: - Friendship Status Logic

/// Calculates the friendship status between the current user and another user
func calculateFriendshipStatus(for user: User) -> FriendshipStatus {
    guard let key = user.friendshipKey else { return .notFriends }
    
    // If friendship is confirmed, return friends regardless of who sent the original request
    if key == "friends" {
        return .friends
    }
    
    // For pending requests, check who sent the request
    let currentUser = UserDefaultManager().getLoggedInUser()
    if let requestSentBy = user.requestSentBy {
        if requestSentBy == currentUser {
            // Current user sent the request - should show "Cancel"
            return .invitePendingSentByYou
        } else {
            // Someone else sent the request to current user - should show "Accept/Decline"
            return .requestPendingSentByThem
        }
    }
    
    // Fallback to original enum mapping
    return FriendshipStatus(key: key)
}

/// Checks if a user is a friend based on their friendship key
func isUserFriend(_ user: User) -> Bool {
    return user.friendshipKey != nil
}

// MARK: - Batch Image Fetching

/// Fetches images for multiple users in parallel
func fetchImagesForUsers(_ users: [User]) async {
    await withTaskGroup(of: Void.self) { group in
        for user in users {
            group.addTask {
                if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: user.profileImageURL) {
                    user.profileImage = image
                }
            }
        }
    }
}

/// Creates multiple users from UserProfileModel data and fetches their images in parallel
func createUsersFromProfilesWithImages(_ userProfileModels: [UserModel], isCurrentUser: Bool = false) async -> [User] {
    // First create all users without images
    let users = userProfileModels.map { createUserFromProfile($0, isCurrentUser: isCurrentUser) }
    
    // Then fetch all images in parallel
    await fetchImagesForUsers(users)
    
    return users
}

/// Creates multiple users from UserModel data and fetches their images in parallel
func createUsersFromFriendsWithImages(_ userModels: [UserModel]) async -> [User] {
    // First create all users without images
    let users = userModels.map { createUserFromFriend($0) }
    
    // Then fetch all images in parallel
    await fetchImagesForUsers(users)
    
    return users
}
