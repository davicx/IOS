//
//  ViewController.swift
//  UserDefaultManager
//
//  Created by David Vasquez on 12/22/24.
//

import UIKit

class ViewController: UIViewController {

    let userDefaultManager = UserDefaultManagerSmall()
    
    
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var userNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = userDefaultManager.getUserSimple()
        print(userName)
        
    }

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
}
