//
//  LoginResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/26/24.
//

import Foundation


struct LoginResponseModel: Codable {
    let data: LoginModel
    let success: Bool
    let message: String
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = LoginModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}
