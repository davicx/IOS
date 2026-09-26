//
//  AccessTokenModel.swift
//  Kite
//
//  Created by David Vasquez on 2/3/25.
//

import Foundation


struct AccessTokenModel: Codable {
    let refreshTokenSent: Bool
    let refreshTokenValid: Bool
    let refreshTokenDatabseMatch: Bool
    let newAccessToken: String
    
    init() {
        self.refreshTokenSent = false
        self.refreshTokenValid = false
        self.refreshTokenDatabseMatch = false
        self.newAccessToken = ""
    }
}


