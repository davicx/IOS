//
//  LoginResponseModel.swift
//  postsTableView
//
//  Created by David on 6/23/24.
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
