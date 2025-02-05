//
//  AccessTokenResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 2/3/25.
//

import Foundation



struct AccessTokenResponseModel: Codable {
    let data: AccessTokenModel
    let success: Bool
    let message: String
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = AccessTokenModel()
        self.message = ""
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}
