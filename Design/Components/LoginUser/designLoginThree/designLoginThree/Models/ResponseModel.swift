//
//  ResponseModel.swift
//  designLoginThree
//
//  Created by David on 4/3/23.
//

import Foundation

struct ResponseModel: Codable {
    let data: Bool
    let success: Bool
    let message: String
    let errors: [String]
    let currentUser: String
    
}

/*
struct RegisterUserModel: Codable {
    let emailStatus: Int
    let emailMessages: [String]
    let usernameStatus: Int
    let usernameMessages: [String]
    let fullNameStatus: Int
    let fullNameMessages: [String]
    let passwordStatus: Int
    let passwordMessages: [String]
    let validUserRegistration: Int
    let UserRegistrationMessages: [String]
    let userName: String
    let userID: Int
}

 {
     "data": {
         "loginSuccess": true,
         "validUser": true,
         "passwordCorrect": true,
         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNjgwNTY3NDExLCJleHAiOjE2ODA1NzEwMTF9.tjckyzDno_lhonbhxm1E_ZhTwMUOYyIue5jnSbazLVQ",
         "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNjgwNTY3NDExfQ.Ec1cBlhU-6vlJ9aLU-lKBrNlrT9DQMZYbtHEFkoNpJ0"
     },
     "success": true,
     "message": "daveywas succesfully logged in!",
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
