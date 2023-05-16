//
//  GroupData.swift
//  QuoteNewGroup
//
//  Created by David on 5/13/23.
//

import Foundation

struct GroupDataModel: Codable {
    let groupID: Int
    let groupMembers: [String]
    let pendingGroupMembers: [String]
}
