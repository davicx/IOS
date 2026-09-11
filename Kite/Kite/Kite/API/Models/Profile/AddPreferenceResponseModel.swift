//
//  AddPreferenceResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


struct AddPreferenceResponseModel: Codable {
    let data: PreferenceModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = PreferenceModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}
