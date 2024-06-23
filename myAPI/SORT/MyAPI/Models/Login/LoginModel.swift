//
//  LoginModel.swift
//  MyAPI
//
//  Created by David Vasquez on 6/21/24.
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
