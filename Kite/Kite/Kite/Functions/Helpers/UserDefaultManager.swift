//
//  UserDefaultManager.swift
//  Kite
//
//  Created by David Vasquez on 12/22/24.
//

import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults(suiteName: "kite")!
    
    //store the if let junk down here
    func getUserSimple() -> String {
        return "davey"
    }
    
    func logUserIn(userName: String) -> Bool {
        print("UserDefaultManager: Logging User In ")
        UserDefaultManager.shared.defaults.set(userName, forKey: "loggedInUser")
        return UserDefaultManager.shared.defaults.string(forKey: "loggedInUser") == userName
    }
    
    func logUserOut() -> Bool {
        print("UserDefaultManager: Logging User Out ")
        UserDefaultManager.shared.defaults.set("null", forKey: "loggedInUser")
        return UserDefaultManager.shared.defaults.string(forKey: "loggedInUser") == "null"
    }
    
    func getLoggedInUserStatus() -> Bool {
        if let loggedInUser = UserDefaultManager.shared.defaults.value(forKey: "loggedInUser") as? String {
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
        if let loggedInUser = UserDefaultManager.shared.defaults.value(forKey: "loggedInUser") as? String {
            return loggedInUser
        } else {
            return "null"
        }
    }
    
    
}

