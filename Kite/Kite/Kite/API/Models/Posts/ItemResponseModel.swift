//
//  ItemResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/19/24.
//

import Foundation

struct ItemResponseModel: Codable {
    let data: [ItemModel]
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = ""
        self.success = false
        self.statusCode = 0
        self.errors = []
        self.currentUser = ""
    }
}
