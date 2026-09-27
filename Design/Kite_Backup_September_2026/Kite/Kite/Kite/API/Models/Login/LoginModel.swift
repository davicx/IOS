//
//  LoginModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/26/24.
//

import Foundation


struct LoginModel: Codable {
    let loginSuccess: Bool
    let loggedInUser: String
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
    
    init() {
        self.loginSuccess = false
        self.loggedInUser = ""
        self.validUser = false
        self.passwordCorrect = false
        self.accessToken = ""
        self.refreshToken = ""
    }
}
