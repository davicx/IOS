//
//  UserDefaultClass.swift
//  UserDefaultManager
//
//  Created by David Vasquez on 12/22/24.
//


/*
import UIKit

class UserDefaultClass {
    static let shared = UserDefaultClass()
    let defaults = UserDefaults(suiteName: "kite")!
}




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
    


    
}

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults(suiteName: "kite")!
}


class UserDefaultManagerSmall {
    static let shared = UserDefaultManagerSmall()
    let defaults = UserDefaults(suiteName: "kite")!
    
    //store the if let junk down here
    func getUser() -> String {
        return ""
    }
}

*/
