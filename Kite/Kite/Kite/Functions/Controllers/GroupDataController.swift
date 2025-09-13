//
//  GroupDataController.swift
//  Kite
//
//  Created by David Vasquez on 7/5/25.
//

import UIKit


class GroupDataController {
    static let shared = GroupDataController()
    

    private(set) var groups: [GroupModel] = []
    var onGroupsUpdated: (() -> Void)?
    
    // MARK: - Individual Group Data Management
    private(set) var groupUsers: [String: GroupUsersModel] = [:] // groupID -> GroupUsersModel
    private(set) var groupDetails: [String: GroupModel] = [:] // groupID -> GroupModel (cached individual group data)
    
    var onGroupUsersUpdated: ((String) -> Void)? // groupID parameter
    var onGroupDetailsUpdated: ((String) -> Void)? // groupID parameter
    
    private let groupsAPI = GroupsAPI()
    private let userDefaultManager = UserDefaultManager()
    
    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }

    // Fetch groups
    func getGroups(completion: @escaping () -> Void) {
        let currentUser = userDefaultManager.getLoggedInUser()

        Task {
            do {
                let response = try await groupsAPI.getGroupsAPI(for: currentUser)
                if response.statusCode == 401 {
                    LoginManager.shared.logoutCurrentUser()
                    DispatchQueue.main.async {
                        completion()
                    }
                    return
                }
                self.groups = response.data
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Failed to fetch groups:", error)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }


    func addGroup(_ newGroup: GroupModel) {
        groups.insert(newGroup, at: 0)
        onGroupsUpdated?()
    }
    
    func refreshGroups(completion: @escaping () -> Void) {
        getGroups {
            self.onGroupsUpdated?()
            completion()
        }
    }
    
    // MARK: - Group Users Management
    
    // Fetch group users for a specific group
    func fetchGroupUsers(groupID: String, completion: @escaping () -> Void) {
        Task {
            do {
                let response = try await groupsAPI.getGroupUsers(groupID: groupID)
                if response.statusCode == 401 {
                    LoginManager.shared.logoutCurrentUser()
                    DispatchQueue.main.async {
                        completion()
                    }
                    return
                }
                
                if response.success {
                    self.groupUsers[groupID] = response.data
                }
                
                DispatchQueue.main.async {
                    self.onGroupUsersUpdated?(groupID)
                    completion()
                }
            } catch {
                print("Failed to fetch group users for group \(groupID):", error)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    // Get group users for a specific group (from cache)
    func getGroupUsers(groupID: String) -> GroupUsersModel? {
        return groupUsers[groupID]
    }
    
    // Get active users for a specific group
    func getActiveGroupUsers(groupID: String) -> [String] {
        return groupUsers[groupID]?.activeGroupUsers ?? []
    }
    
    // Get pending users for a specific group
    func getPendingGroupUsers(groupID: String) -> [String] {
        return groupUsers[groupID]?.pendingGroupUsers ?? []
    }
    
    // Add user to active group users (local update)
    func addUserToGroup(groupID: String, username: String) {
        guard var groupUserData = groupUsers[groupID] else { return }
        
        // Remove from pending if exists
        groupUserData.pendingGroupUsers.removeAll { $0 == username }
        
        // Add to active if not already there
        if !groupUserData.activeGroupUsers.contains(username) {
            groupUserData.activeGroupUsers.append(username)
        }
        
        groupUsers[groupID] = groupUserData
        onGroupUsersUpdated?(groupID)
    }
    
    // Remove user from group (local update)
    func removeUserFromGroup(groupID: String, username: String) {
        guard var groupUserData = groupUsers[groupID] else { return }
        
        groupUserData.activeGroupUsers.removeAll { $0 == username }
        groupUserData.pendingGroupUsers.removeAll { $0 == username }
        
        groupUsers[groupID] = groupUserData
        onGroupUsersUpdated?(groupID)
    }
    
    // Add user to pending group users (local update)
    func addUserToPendingGroup(groupID: String, username: String) {
        guard var groupUserData = groupUsers[groupID] else { return }
        
        // Remove from active if exists
        groupUserData.activeGroupUsers.removeAll { $0 == username }
        
        // Add to pending if not already there
        if !groupUserData.pendingGroupUsers.contains(username) {
            groupUserData.pendingGroupUsers.append(username)
        }
        
        groupUsers[groupID] = groupUserData
        onGroupUsersUpdated?(groupID)
    }
    
    // Refresh group users from server
    func refreshGroupUsers(groupID: String, completion: @escaping () -> Void) {
        fetchGroupUsers(groupID: groupID) {
            completion()
        }
    }
    
    // Clear group users cache (useful for logout)
    func clearGroupUsersCache() {
        groupUsers.removeAll()
    }
    
    // MARK: - Individual Group Details Management
    
    // Get individual group details (from cache)
    func getGroupDetails(groupID: String) -> GroupModel? {
        return groupDetails[groupID]
    }
    
    // Update group details (when group name, image, etc. changes)
    func updateGroupDetails(groupID: String, updatedGroup: GroupModel) {
        groupDetails[groupID] = updatedGroup
        
        // Also update in the groups list if it exists there
        if let index = groups.firstIndex(where: { $0.groupID == Int(groupID) }) {
            groups[index] = updatedGroup
        }
        
        onGroupDetailsUpdated?(groupID)
        onGroupsUpdated?()
    }
    
    // Get group by ID (searches both groups list and cached details)
    func getGroup(by groupID: String) -> GroupModel? {
        // First check cached details
        if let cachedGroup = groupDetails[groupID] {
            return cachedGroup
        }
        
        // Then check groups list
        if let groupIDInt = Int(groupID) {
            return groups.first { $0.groupID == groupIDInt }
        }
        
        return nil
    }
    
    // Clear all caches (useful for logout)
    func clearAllCaches() {
        groupUsers.removeAll()
        groupDetails.removeAll()
    }
}
