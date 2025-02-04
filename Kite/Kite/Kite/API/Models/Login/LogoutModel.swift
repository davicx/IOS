//
//  LogoutModel.swift
//  Kite
//
//  Created by David Vasquez on 12/24/24.
//

import Foundation


struct LogoutModel: Codable {
    let logoutSuccess: Bool

    init() {
        self.logoutSuccess = false
    }
    
}

