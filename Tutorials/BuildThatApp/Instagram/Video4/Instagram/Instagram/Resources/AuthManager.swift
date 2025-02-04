//
//  AuthManager.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


class AuthManager {

    static let shared = AuthManager()
    
    public func registerNewUser (username: String, email: String, password: String) {
            print("Register")
    }
    
    public func loginUser(username: String?, email: String?, password: String) {
        print("Login")
    }
        
}
