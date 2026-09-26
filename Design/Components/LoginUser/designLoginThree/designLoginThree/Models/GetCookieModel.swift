//
//  GetCookieModel.swift
//  designLoginThree
//
//  Created by David on 4/1/23.
//

import Foundation

struct GetCookieModel: Codable {
    let accessToken: String
    let refreshToken: String
    let userName: String

}
