//
//  UserViewController.swift
//  userDefaults
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/31/22.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet var getCurrentUserButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
    }
    
    @IBAction func getLoginStatusButton(_ sender: UIButton) {
        let loginStatus = getLoggedInUserStatus()
        print("User is Logged in \(loginStatus)")
    }
    
    @IBAction func getCurrentUserButton(_ sender: UIButton) {
        let loggedInUser = getLoggedInUser()
        print("The current user is \(loggedInUser)!")
    }
    
   
    @IBAction func loginButton(_ sender: UIButton) {
        let loggedInUser = userNameTextField.text ?? ""
        logUserIn(userName: loggedInUser)
        print("You just logged \(loggedInUser) in")
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        logUserOut()
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
    
    
    func logUserOut() {
        print("logOut")
        UserDefaultManager.shared.defaults.set("null", forKey: "loggedInUser")
    }
    
    func logUserIn(userName: String) {
        UserDefaultManager.shared.defaults.set(userName, forKey: "loggedInUser")
    }
    
    func getLoggedInUser() -> String {
        if let loggedInUser = UserDefaultManagerSmall.shared.defaults.value(forKey: "loggedInUser") as? String {
            print("get \(loggedInUser)")
            return loggedInUser
        } else {
            return "null"
        }
    }
    

    /*
     let loggedInUser = getLoggedInUser()
     
     //print(loggedInUser)
     
     if(loggedInUser != "null") {
         print("\(loggedInUser) is logged in!")
     } else {
         print{"no one logged in!"}
     }
     
     logOut()
     
     if(loggedInUser != "null") {
         print("\(loggedInUser) is logged in!")
     } else {
         print{"no one logged in!"}
     }
     
     //logIn(userName: "davey")
     
    @IBAction func setUserNameButton(_ sender: Any) {
        let loggedInUser = userNameTextField.text
        print("set \(loggedInUser!)")
        
        UserDefaultManagerSmall.shared.defaults.set(loggedInUser, forKey: "loggedInUser")
    }
    
 
    @IBAction func getUserNameButton(_ sender: Any) {
        let userName = getLoggedInUser()
        
        print("get \(userName)")
    }
     func setLoggedInUser(userName: String) -> String {
         UserDefaultManager.shared.defaults.set(userName, forKey: "loggedInUser")
         return userName
     }
     */
    
 
    
}

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults(suiteName: "kite")!
}

/*
UserDefaultManagerSmall.shared.defaults.set("davey", forKey: "loggedInUser")

if let loggedInUser = UserDefaultManagerSmall.shared.defaults.value(forKey: "loggedInUser") as? String {
    print(loggedInUser)
}

UserDefaultManagerSmall.shared.defaults.set(true, forKey: "isLoggedIn")
if let isLoggedIn = UserDefaultManagerSmall.shared.defaults.value(forKey: "isLoggedIn") as? Bool {
    print(isLoggedIn)
}

if let value = UserDefaultManagerSmall.shared.defaults.value(forKey: "name") as? String {
    labelField.text = value
}
*/
