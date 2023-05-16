//
//  NewGroupModel.swift
//  QuoteNewGroup
//
//  Created by David on 5/9/23.
//

import Foundation

struct NewGroupModel: Codable {
    let groupData: GroupDataModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
   
}

