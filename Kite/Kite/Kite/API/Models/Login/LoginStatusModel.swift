//
//  LoginStatusModel.swift
//  Kite
//
//  Created by David Vasquez on 9/2/25.
//


import Foundation


struct LoginStatusModel: Codable {
    let tokenType: String
    let userNameFromToken: String
    let userLoggedIn: Bool
    let token: LoginStatusTokenModel
    
    init() {
        self.tokenType = ""
        self.userNameFromToken = ""
        self.userLoggedIn = false
        self.token = LoginStatusTokenModel()
    }
}

struct LoginStatusTokenModel: Codable {
    let tokenType: String
    let accessToken: String
    let refreshToken: String
    let validAccessToken: Bool
    let validRefreshToken: Bool
    let refreshTokenMatches: Bool
    
    init() {
        self.tokenType = ""
        self.accessToken = ""
        self.refreshToken = ""
        self.validAccessToken = false
        self.validRefreshToken = false
        self.refreshTokenMatches = false
    }
}
