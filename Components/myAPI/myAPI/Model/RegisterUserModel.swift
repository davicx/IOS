//
//  RegisterUserModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 8/11/22.
//


import Foundation

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


/*
 {
     "emailStatus": 1,
     "emailMessages": [
         "Appears to be a valid email"
     ],
     "usernameStatus": 1,
     "usernameMessages": [
         "Username looks good!"
     ],
     "fullNameStatus": 1,
     "fullNameMessages": [
         "fullname looks good!"
     ],
     "passwordStatus": 1,
     "passwordMessages": [
         "Password looks good!"
     ],
     "validUserRegistration": 1,
     "UserRegistrationMessages": [
         "you succesfully registered frodo77877 with the ID 23"
     ],
     "userName": "frodo77877",
     "userID": 23
 }
 */
