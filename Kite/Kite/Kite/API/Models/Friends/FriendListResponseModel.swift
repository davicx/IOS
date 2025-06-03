//
//  FriendListResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 5/20/25.
//

import UIKit


struct FriendListResponseModel: Codable {
    let data: [FriendModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
    
}

