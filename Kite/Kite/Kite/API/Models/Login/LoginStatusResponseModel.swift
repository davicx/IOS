//
//  LoginStatusResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 9/2/25.
//

import Foundation


struct LoginStatusResponseModel: Codable {
    let data: LoginStatusModel
    let messages: [String]
    let success: Bool
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = LoginStatusModel()
        self.messages = []
        self.success = false
        self.errors = []
        self.currentUser = ""
    }
}

