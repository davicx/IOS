//
//  LoginResponseModel.swift
//  designLoginThree
//
//  Created by David on 4/3/23.
//

import Foundation

struct Data: Codable {
    let loginSuccess: Bool
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
}

struct LoginResponseModel: Codable {
    let data: Data
    let success: Bool
    let message: String
    let errors: [String]
    let statusCode: Int
    let currentUser: String
    
}

/*
{
     "data": {
         "loginSuccess": true,
         "validUser": true,
         "passwordCorrect": true,
         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNjgwNzM5Njc5LCJleHAiOjE2ODA3NDMyNzl9.qOy9qVnR8tsgFtvp9g81yQCvsOHHVoTBeM_i7-u9_tA",
         "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNjgwNzM5Njc5fQ.zsLp4zVkzFP-bHBjJIYhab7n1DuvnY_7DJBYuzdWkC0"
     },
     "success": true,
     "message": "daveywas succesfully logged in!",
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 
 
 success: true,
 message: userName + "was succesfully logged in!",
 errors: [],
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


import Foundation



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
