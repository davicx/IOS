//
//  LoginStatusResponseModel.swift
//  Kite
//
// Created by David Vasquez on 12/15/24.
//

import Foundation


struct LoginStatusResponseModel: Codable {
    let data: LoginStatusModel
    let messages: [String]
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = LoginStatusModel()
        self.messages = []
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}
