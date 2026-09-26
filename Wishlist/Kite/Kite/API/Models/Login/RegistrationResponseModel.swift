//
//  RegistrationResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 11/2/24.
//

import Foundation


struct RegistrationResponseModel: Codable {
    let data: RegistrationModel
    let success: Bool
    let message: String
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = RegistrationModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}

