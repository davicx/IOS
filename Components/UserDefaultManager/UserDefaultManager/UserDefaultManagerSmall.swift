//
//  UserDefaultManagerSmall.swift
//  UserDefaultManager
//
//  Created by David Vasquez on 12/22/24.
//

import UIKit

class UserDefaultManagerSmall {
    static let shared = UserDefaultManagerSmall()
    let defaults = UserDefaults(suiteName: "kite")!
    
    //store the if let junk down here
    func getUserSimple() -> String {
        return "davey"
    }
    
    func logUserIn(userName: String) -> Bool {
        UserDefaultManagerSmall.shared.defaults.set(userName, forKey: "loggedInUser")
        return UserDefaultManagerSmall.shared.defaults.string(forKey: "loggedInUser") == userName
    }
    
    func logUserOut() -> Bool {
        UserDefaultManagerSmall.shared.defaults.set("null", forKey: "loggedInUser")
        return UserDefaultManagerSmall.shared.defaults.string(forKey: "loggedInUser") == "null"
    }
    
    func getLoggedInUserStatus() -> Bool {
        if let loggedInUser = UserDefaultManagerSmall.shared.defaults.value(forKey: "loggedInUser") as? String {
            if(loggedInUser == "null") {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    func getLoggedInUser() -> String {
        if let loggedInUser = UserDefaultManagerSmall.shared.defaults.value(forKey: "loggedInUser") as? String {
            return loggedInUser
        } else {
            return "null"
        }
    }
    
    
}

/*
 @IBAction func loginButton(_ sender: UIButton) {
     let loggedInUser = userNameField.text ?? "null"
     let loginOutcome = userDefaultManager.logUserIn(userName: loggedInUser)
     
     if(loginOutcome) {
         print("You just logged \(loggedInUser) in")
     } else {
         print("Was an error logging in!")
     }
     
 }
 
 
 @IBAction func logoutButton(_ sender: UIButton) {
     let loginOutcome = userDefaultManager.logUserOut()
     
     if(loginOutcome) {
         print("You just logged out")
     } else {
         print("Was an error logging out!")
     }
 }
 
 
 @IBAction func loginStatusButton(_ sender: UIButton) {
     let loginStatus = userDefaultManager.getLoggedInUserStatus()
     print("User is Logged in \(loginStatus)")

 }
 
 @IBAction func currentUserButton(_ sender: UIButton) {
     let loggedInUser = userDefaultManager.getLoggedInUser()
     print("The current user is \(loggedInUser)!")

 }
 
 */

