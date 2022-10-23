//
//  LoginResponseModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 8/12/22.
//

import Foundation

struct LoginResponseModel: Codable {
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
}
