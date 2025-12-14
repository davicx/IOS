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

/// Creates a User from UserModel data
/// This is the single source of truth for creating User objects from API responses
func createUser(from userModel: UserModel, isCurrentUser: Bool = false) -> User {
    // Determine if this is current user (check both flag and friendshipKey)
    let isYou = isCurrentUser || userModel.friendshipKey == "you"
    
    // Normalize friendshipKey - handle empty string or default "friendshipKey" value
    let friendshipKey: String
    if userModel.friendshipKey.isEmpty || userModel.friendshipKey == "friendshipKey" {
        friendshipKey = "not_friends"
    } else {
        friendshipKey = userModel.friendshipKey
    }
    
    let user = User(
        userID: userModel.userID,
        userName: userModel.userName,
        userImage: userModel.userImage,
        firstName: userModel.firstName.isEmpty ? "Unknown" : userModel.firstName,
        lastName: userModel.lastName.isEmpty ? "User" : userModel.lastName,
        biography: userModel.biography,
        isCurrentUser: isYou,
        friendshipKey: friendshipKey,
        requestPending: userModel.requestPending,
        requestSentBy: userModel.requestSentBy,
        alsoYourFriend: userModel.alsoYourFriend
    )
    
    return user
}

/// Creates a User from UserModel data and fetches the profile image
func createUserWithImage(from userModel: UserModel, isCurrentUser: Bool = false) async -> User {
    let user = createUser(from: userModel, isCurrentUser: isCurrentUser)
    
    // Fetch and cache the profile image
    if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: user.userImage) {
        user.profileImage = image
    }
    
    return user
}

// MARK: - Friendship Status Logic

/// Calculates the friendship status between the current user and another user
func calculateFriendshipStatus(for user: User) -> FriendshipStatus {
    // Check if this is the current user
    if user.isCurrentUser || user.friendshipKey == "you" {
        return .you
    }
    
    // Handle empty string as "not_friends"
    if user.friendshipKey.isEmpty {
        return .notFriends
    }
    
    // Direct mapping from API values to enum
    switch user.friendshipKey {
    case "friends":
        return .friends
    case "invite_pending":
        // They sent invite to you - you can accept/decline
        return .requestPendingSentByThem
    case "request_pending":
        // You sent request to them - you can cancel
        return .invitePendingSentByYou
    case "not_friends":
        return .notFriends
    case "you":
        return .you
    default:
        return .unknown
    }
}

/// Checks if a user is a friend based on their friendship key
func isUserFriend(_ user: User) -> Bool {
    return !user.friendshipKey.isEmpty && user.friendshipKey == "friends"
}

// MARK: - Batch Image Fetching

/// Fetches images for multiple users in parallel
func fetchImagesForUsers(_ users: [User]) async {
    await withTaskGroup(of: Void.self) { group in
        for user in users {
            group.addTask {
                if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: user.userImage) {
                    user.profileImage = image
                }
            }
        }
    }
}

/// Creates multiple users from UserModel data and fetches their images in parallel
func createUsersWithImages(from userModels: [UserModel], isCurrentUser: Bool = false) async -> [User] {
    // First create all users without images
    let users = userModels.map { createUser(from: $0, isCurrentUser: isCurrentUser) }
    
    // Then fetch all images in parallel
    await fetchImagesForUsers(users)
    
    return users
}
