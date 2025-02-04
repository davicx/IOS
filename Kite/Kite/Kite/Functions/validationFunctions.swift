//
//  validationFunctions.swift
//  Instagram
//
//  Created by David Vasquez on 11/7/24.
//

import Foundation


func validateUserName(userName: String) -> Bool {
    guard userName.count >= 5, userName.count <= 20 else {
        return false
    }
    return true
}

func validateEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
 
    return emailPredicate.evaluate(with: email)
 
}

func validateFullName(fullName: String) -> Bool {
    guard fullName.count >= 5, fullName.count <= 20 else {
        return false
    }
    return true

}


func validatePassword(password: String) -> Bool {
    guard password.count >= 5, password.count <= 20 else {
        return false
    }
    return true
}

func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}


func getRegisterMessage(validUsername: Bool, validFullName: Bool, validEmail: Bool, validPassword: Bool) -> String {
    var invalidFields: [String] = []

    if !validUsername {
        invalidFields.append("username")
    }
    if !validFullName {
        invalidFields.append("full name")
    }
    if !validEmail {
        invalidFields.append("email")
    }
    if !validPassword {
        invalidFields.append("password")
    }

    switch invalidFields.count {
    case 0:
        return "All fields are valid."
    case 1:
        return "Please enter a valid \(invalidFields[0])."
    case 2:
        return "Please enter a valid \(invalidFields[0]) and \(invalidFields[1])."
    default:
        let lastField = invalidFields.removeLast()
        return "Please enter a valid \(invalidFields.joined(separator: ", ")), and \(lastField)."
    }
}
