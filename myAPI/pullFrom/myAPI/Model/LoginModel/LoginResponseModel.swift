//
//  LoginModel.swift
//  myAPI
//
//  Created by David Vasquez on 6/13/24.
//

import Foundation

struct LoginResponseModel: Codable {
    let data: LoginModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
}


