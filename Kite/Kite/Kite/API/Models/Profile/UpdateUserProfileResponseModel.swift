//
//  UpdateUserProfileResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UpdateUserProfileResponseModel: Codable {
    let data: UpdateUserProfileModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = UpdateUserProfileModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}

/*
 {
     "message": "We updated the user profile for davey",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey",
     "data": {
         "currentUser": "davey",
         "imageName": "password",
         "firstName": "david vas",
         "lastName": "v",
         "biography": "biography"
     }
 }
 */
