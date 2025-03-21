//
//  NewGroupResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/18/24.
//

import Foundation


struct NewGroupResponseModel: Codable {
    let data: NewGroupModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    
    init() {
        self.data = NewGroupModel(groupName: "groupName", groupID: 0, groupMembers: ["groupMembers"], pendingGroupMembers: ["pendingGroupMembers"])
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}
