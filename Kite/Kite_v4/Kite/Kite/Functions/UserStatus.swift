//
//  UserStatus.swift
//  Kite
//
//  Created by Syngenta on 11/8/21.
//

import Foundation
import Firebase
import FirebaseAuth

func userStatus() -> String {
    var userName = "null"
    var email = "null"
    Auth.auth().addStateDidChangeListener { auth, user in
        if let user = user {
            email = user.email!
            userName = email
            print("Signed In! \(email)")

        } else {
            print("NOT Signed In!")
        }
   }
    
    return userName
}

