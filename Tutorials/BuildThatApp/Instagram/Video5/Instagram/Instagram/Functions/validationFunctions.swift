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


func validatePassword(userName: String) -> Bool {
    guard userName.count >= 5, userName.count <= 20 else {
        return false
    }
    return true
}

