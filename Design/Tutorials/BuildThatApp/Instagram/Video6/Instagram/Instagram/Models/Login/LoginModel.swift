//
//  LoginModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/26/24.
//

import Foundation


struct LoginModel: Codable {
    let loginSuccess: Bool
    let loggedInUser: String
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
    
    init() {
        self.loginSuccess = false
        self.loggedInUser = ""
        self.validUser = false
        self.passwordCorrect = false
        self.accessToken = ""
        self.refreshToken = ""
    }
}


/*
 {
     "data": {
         "loginSuccess": true,
         "loggedInUser": "davey",
         "validUser": true,
         "passwordCorrect": true,
         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNzMwMDY2MTY0LCJleHAiOjE3MzAwNjk3NjR9.nAViazTXdiu2T0kM0O9qbkOhKz3r1dazgnApuEbdjwI",
         "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNzMwMDY2MTY0fQ.3mM5qyvDw2huqqCDtAw7AoXbrWFOs7e9beGNbyubvu4"
     },
     "success": true,
     "message": "daveywas succesfully logged in!",
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
