//
//  ViewController.swift
//  userDefaults
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/30/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var labelField: UILabel!
    
    //let userDefaults = UserDefaults()
    //let userDefaults = UserDefaults(suiteName: "kite")

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        
        //TYPE 1: Simple
        
        /*
        userDefaults.set("davey", forKey: "loggedInUser")
        if let loggedInUser = userDefaults.value(forKey: "loggedInUser") as? String {
            print(loggedInUser)
        }
         */
         
        
        //TYPE 2: With Class
        //Logged in User
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
        //TYPE 3: Arrays and Dictionarys
        /*
        let defaults = UserDefaults.standard
        let array = ["David", "frodo"]
        defaults.set(array, forKey: "myArray")
        
        let savedArray = defaults.object(forKey: "myArray") as? [String] ?? [String]()
        print(savedArray)
        
        let dict = ["userName": "david", "userTwo": "frodo"]
        defaults.set(dict, forKey: "myDict")
        //let savedDict = defaults.object(forKey: "myDict") as? [String] ?? [String]()
        //print(savedDict)
         */
    
    }
    
    /*
    //Run on Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserDefaultManagerSmall.shared.defaults.set(inputTextField.text, forKey: "name")
        inputTextField.resignFirstResponder()
        return true
    }
     */


}



class UserDefaultManagerSmall {
    static let shared = UserDefaultManagerSmall()
    let defaults = UserDefaults(suiteName: "kite")!
    
    //store the if let junk down here
    func getUser() -> String {
        return ""
    }
}


