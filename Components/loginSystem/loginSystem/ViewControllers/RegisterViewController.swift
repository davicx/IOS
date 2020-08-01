//
//  RegisterViewController.swift
//  loginSystem
//
//  Created by David Vasquez on 7/21/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameInputField: UITextField!
    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpUserButton(_ sender: Any) {
        var registerUserName = userNameInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerFullName = fullNameInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerEmail = emailInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerPassword =  passwordInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        registerUserName = "vasquezd433"
        registerFullName = "Davey V"
        registerEmail = "vasquezd433@onid.orst.edu"
        registerPassword =  "password"
        
        registerUser(userName: registerUserName, fullName: registerFullName, email: registerEmail, password: registerPassword)
        
        /*
        if registerUserName == "" || registerEmail == "" || registerPassword == "" {
            if registerUserName == "" {
                print(" User Name ")
            }
            if registerEmail == "" {
                print(" Email ")
            }
            if registerPassword == "" {
                 print(" Password ")
            }
            
        } else {
            registerUserName = "vasquezd"
            registerFullName = "Davey V"
            registerEmail = "vasquezd@onid.orst.edu"
            registerPassword =  "password"
            
            registerUser(userName: registerUserName, fullName: registerFullName, email: registerEmail, password: registerPassword)
            
        }
        */

        
    }
    
}
