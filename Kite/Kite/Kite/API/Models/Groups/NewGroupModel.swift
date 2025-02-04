//
//  NewGroupModel.swift
//  Kite
//
//  Created by David Vasquez on 12/18/24.
//

import Foundation


struct NewGroupModel: Codable {
    let groupName: String
    let groupID: Int
    let groupMembers: [String]
    let pendingGroupMembers: [String]
}
