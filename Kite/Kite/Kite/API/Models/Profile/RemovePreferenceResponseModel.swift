//
//  RemovePreferenceResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


struct RemovePreferenceModel: Codable {
    let userPreferenceID: Int
    let active: Int

    init(userPreferenceID: Int = 0, active: Int = 0) {
        self.userPreferenceID = userPreferenceID
        self.active = active
    }
}

struct RemovePreferenceResponseModel: Codable {
    let data: RemovePreferenceModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = RemovePreferenceModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}
