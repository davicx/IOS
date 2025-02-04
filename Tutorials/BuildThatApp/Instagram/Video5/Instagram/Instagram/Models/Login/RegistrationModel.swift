//
//  RegistrationModel.swift
//  Instagram
//
//  Created by David Vasquez on 11/2/24.
//

import Foundation

struct RegistrationModel: Codable {
    let newUser: NewUser
    let registrationValidation: RegistrationValidation
    
    init() {
        self.newUser = NewUser()
        self.registrationValidation = RegistrationValidation()

    }
}

struct NewUser: Codable {
    let userName: String
    let fullName: String
    let userID: Int
    let userEmail: String
    
    init() {
        self.userName = ""
        self.fullName = ""
        self.userID = 0
        self.userEmail = ""
    }
}

struct RegistrationValidation: Codable {
    let masterSuccess: Bool
    let validationSuccess: Bool
    let emailStatus: Int
    let emailMessage: String
    let usernameStatus: Int
    let usernameMessage: String
    let passwordStatus: Int
    let passwordMessage: String
    let usernameAvailableStatus: Int
    let usernameAvailableMessage: String
    
    init() {
        self.masterSuccess = false
        self.validationSuccess = false
        self.emailStatus = 0
        self.emailMessage = ""
        self.usernameStatus = 0
        self.usernameMessage = ""
        self.passwordStatus = 0
        self.passwordMessage = ""
        self.usernameAvailableStatus = 0
        self.usernameAvailableMessage = ""
    }
}

/*
 init() {
     self.data = RegistrationModel()
     self.message = ""
     self.success = false
     self.statusCode = 500
     self.errors = []
     self.currentUser = ""
 }
 */

/*
 init() {
     self.loginSuccess = false
     self.loggedInUser = ""
     self.validUser = false
     self.passwordCorrect = false
     self.accessToken = ""
     self.refreshToken = ""
 }
 
 let data: DataClass
 let success: Bool
 let : String
 let statusCode: Int
 let errors: [String]
 let currentUser: String
 {


 }

 */

