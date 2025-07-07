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
                    AuthManager.shared.logoutCurrentUser()
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
}
