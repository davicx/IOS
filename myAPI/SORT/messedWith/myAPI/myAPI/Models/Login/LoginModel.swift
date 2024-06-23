//
//  LoginModel.swift
//  myAPI
//
//  Created by David on 6/19/24.
//

import Foundation

struct LoginModel: Codable {
    let loginSuccess: Bool
    let loggedInUser: String
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
}

