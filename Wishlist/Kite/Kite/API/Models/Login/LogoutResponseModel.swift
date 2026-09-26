//
//  LogoutResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/24/24.
//

import Foundation


struct LogoutResponseModel: Codable {
    let data: LogoutModel
    let success: Bool
    let message: String
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = LogoutModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}


/*
 LogoutResponseModel(data: Kite.LogoutModel(loginSuccess: false, logoutMessage: ""), success: false, message: "", statusCode: 500, errors: [], currentUser: "")
 
 {
     "data": {
         "logoutSuccess": true,
         "logoutMessage": "You logged out davey"
     },
     "success": true,
     "message": "Need to update this soon",
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }*/
