//
//  GroupUsersResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 9/10/25.
//

import Foundation

struct GroupUsersResponseModel: Codable {
    let data: GroupUsersModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = GroupUsersModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}

