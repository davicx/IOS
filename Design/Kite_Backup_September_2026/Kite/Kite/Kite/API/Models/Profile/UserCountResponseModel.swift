//
//  UserCountResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/11/25.
//

import Foundation


struct UserCountResponseModel: Codable {
    let data: [UserCountModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}

