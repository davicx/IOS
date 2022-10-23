//
//  VerifyResponseModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 10/22/22.
//

import Foundation

import Foundation

struct VerifyResponseModel: Codable {
    let currentUser: String
    let cookieAccessToken: String
    let cookieRefreshToken: String
    let headerAccessToken: String
}
