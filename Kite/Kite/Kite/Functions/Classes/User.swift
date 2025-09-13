//
//  User.swift
//  Kite
//
//  Created by David Vasquez on 9/12/25.
//

import UIKit

class User {
    let userID: Int
    let userName: String
    var profileImageURL: String
    var firstName: String
    var lastName: String
    var biography: String
    var isCurrentUser: Bool
    
    // Friend-specific properties (optional for non-friend users)
    var requestPending: Int?
    var requestSentBy: String?
    var friendshipKey: String?
    var alsoYourFriend: Int?
    
    var profileImage: UIImage?
    

    init(userID: Int, userName: String, profileImageURL: String = "", firstName: String = "", lastName: String = "", biography: String = "", isCurrentUser: Bool = false) {
        self.userID = userID
        self.userName = userName
        self.profileImageURL = profileImageURL
        self.firstName = firstName.isEmpty ? "Unknown" : firstName
        self.lastName = lastName.isEmpty ? "User" : lastName
        self.biography = biography
        self.isCurrentUser = isCurrentUser
        
        // Friend-specific properties are nil for regular users
        self.requestPending = nil
        self.requestSentBy = nil
        self.friendshipKey = nil
        self.alsoYourFriend = nil
        
        self.profileImage = UIImage(named: "background_1")
    }
    
    // MARK: - Computed Properties
    var displayName: String {
        if firstName == "Unknown" && lastName == "User" {
            return userName
        }
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
    
    var isFriend: Bool {
        return isUserFriend(self)
    }
    
    var friendshipStatus: FriendshipStatus {
        return calculateFriendshipStatus(for: self)
    }
    
    // MARK: - Helper Methods
    func setFriendProperties(requestPending: Int, requestSentBy: String, friendshipKey: String, alsoYourFriend: Int) {
        self.requestPending = requestPending
        self.requestSentBy = requestSentBy
        self.friendshipKey = friendshipKey
        self.alsoYourFriend = alsoYourFriend
    }
    
    func clearFriendProperties() {
        self.requestPending = nil
        self.requestSentBy = nil
        self.friendshipKey = nil
        self.alsoYourFriend = nil
    }
    
    /// Manually fetch and cache the profile image for this user
    func fetchProfileImage() async {
        if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: self.profileImageURL) {
            self.profileImage = image
        }
    }
}
