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
    let groupDescription: String
    let groupType: String
    let groupImage: String?
    let createdBy: String?
    let activeGroupMembers: [String]
    let pendingGroupMembers: [String]

    init(
        groupID: Int,
        groupName: String,
        groupDescription: String = "this is my new group so cool",
        groupType: String = "",
        groupImage: String?,
        createdBy: String?,
        activeGroupMembers: [String],
        pendingGroupMembers: [String]
    ) {
        self.groupID = groupID
        self.groupName = groupName
        self.groupDescription = groupDescription
        self.groupType = groupType
        self.groupImage = groupImage
        self.createdBy = createdBy
        self.activeGroupMembers = activeGroupMembers
        self.pendingGroupMembers = pendingGroupMembers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupID = try container.decode(Int.self, forKey: .groupID)
        groupName = try container.decode(String.self, forKey: .groupName)
        groupDescription = try container.decodeIfPresent(String.self, forKey: .groupDescription) ?? "this is my new group so cool"
        groupType = try container.decodeIfPresent(String.self, forKey: .groupType) ?? ""
        groupImage = try container.decodeIfPresent(String.self, forKey: .groupImage)
        createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        activeGroupMembers = try container.decodeIfPresent([String].self, forKey: .activeGroupMembers) ?? []
        pendingGroupMembers = try container.decodeIfPresent([String].self, forKey: .pendingGroupMembers) ?? []
    }
}
