//
//  GroupsResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 2/16/25.
//

import Foundation


struct GroupsResponseModel: Codable {
    let data: [GroupModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = [GroupModel(groupID: 0, groupName: "groupName", groupImage: "groupImage", activeMembers: ["activeMembers"], pendingMembers: ["pendingMembers"])]
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}


