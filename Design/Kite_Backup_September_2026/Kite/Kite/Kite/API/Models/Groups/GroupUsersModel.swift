//
//  GroupUsersModel.swift
//  Kite
//
//  Created by David Vasquez on 9/10/25.
//

import Foundation

struct GroupUsersModel: Codable {
    var activeGroupUsers: [String]
    var pendingGroupUsers: [String]
    
    init() {
        self.activeGroupUsers = []
        self.pendingGroupUsers = []
    }
    
    init(activeGroupUsers: [String], pendingGroupUsers: [String]) {
        self.activeGroupUsers = activeGroupUsers
        self.pendingGroupUsers = pendingGroupUsers
    }
}

