//
//  UserProfileResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UserProfileResponseModel: Codable {
    let data: UserProfileModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = UserProfileModel()
        self.message = "Log user out"
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
    
}

/*
 {
     "data": {
         "userName": "davey",
         "userID": 39,
         "userImage": "frodo.jpg",
         "biography": "They are (or were) a little people, about half our height, and smaller than the bearded dwarves",
         "firstName": "davey v",
         "lastName": "davey v"
     },
     "message": "We got the user profile for davey",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
