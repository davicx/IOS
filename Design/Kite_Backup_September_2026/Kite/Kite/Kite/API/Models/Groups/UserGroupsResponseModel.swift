//
//  UserGroupsResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/16/24.
//

import Foundation


struct UserGroupsResponseModel: Codable {
    let data: [Int]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}


