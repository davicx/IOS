//
//  User.swift
//  Kite
//
//  Created by David Vasquez on 9/12/25.
//

import UIKit

class User {
    // Core properties (always present from API)
    let userID: Int
    let userName: String
    var userImage: String
    var firstName: String
    var lastName: String 
    var biography: String
    var isCurrentUser: Bool
    
    // Friend properties (always present from API, never nil)
    // Use empty string "" for friendshipKey to indicate "no relationship"
    // Use 0 for requestPending and alsoYourFriend to indicate "not pending/not friend"
    var friendshipKey: String
    var requestPending: Int
    var requestSentBy: String
    var alsoYourFriend: Int
    
    var profileImage: UIImage?
    

    init(userID: Int, userName: String, userImage: String = "", firstName: String = "", lastName: String = "", biography: String = "", isCurrentUser: Bool = false, friendshipKey: String = "not_friends", requestPending: Int = 0, requestSentBy: String = "", alsoYourFriend: Int = 0) {
        self.userID = userID
        self.userName = userName
        self.userImage = userImage
        self.firstName = firstName.isEmpty ? "Unknown" : firstName
        self.lastName = lastName.isEmpty ? "User" : lastName
        self.biography = biography
        self.isCurrentUser = isCurrentUser
        
        // Friend properties - always set (default to "not_friends" if empty)
        self.friendshipKey = friendshipKey.isEmpty ? "not_friends" : friendshipKey
        self.requestPending = requestPending
        self.requestSentBy = requestSentBy
        self.alsoYourFriend = alsoYourFriend
        
        self.profileImage = UIImage(named: "background_1")
    }
    
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
    
    //Manually fetch and cache the profile image for this user
    func fetchProfileImage() async {
        if let image = await ImageCacheManager.shared.fetchImageIfNeeded(from: self.userImage) {
            self.profileImage = image
        }
    }
}
