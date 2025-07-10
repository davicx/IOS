//
//  GroupModel.swift
//  Kite
//
//  Created by David Vasquez on 2/16/25.
//

import Foundation


struct GroupModel: Codable {
    let groupID: Int
    let groupName: String
    let groupImage: String?
    let activeGroupMembers: [String]
    let pendingGroupMembers: [String]
}

