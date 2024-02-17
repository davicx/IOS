//
//  GroupUsersModel.swift
//  myAPI
//
//  Created by David Vasquez on 9/24/23.
//

import Foundation

struct GroupUsersModel: Codable {
    let data: GroupUsersData
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
}


struct GroupUsersData: Codable {
    let activeGroupUsers: [String]
    let pendingGroupUsers: [String]

}
