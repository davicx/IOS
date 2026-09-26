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
    
    @IBOutlet weak var registerErrorMessage: UILabel!
    var registerUserOutcome = RegisterUserModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpUserButton(_ sender: Any) {
        var registerUserName = userNameInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerFullName = fullNameInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerEmail = emailInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var registerPassword =  passwordInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        registerUserName = "davey"
        registerFullName = "Davey V"
        registerEmail = "davey@gmail.com"
        registerPassword = "password"
        
        //STEP 1: Make Sure Fields are all filled in
        
        //STEP 2: Register User on Server and Get Outcome
        registerUser(userName: registerUserName, fullName: registerFullName, email: registerEmail, password: registerPassword) { userServerRegisterOutcome, error in
            DispatchQueue.main.async {
                //print(userServerRegisterOutcome)
                
                //STEP 3: Register with Firebase (Success)
                if(userServerRegisterOutcome.master_success == 1) {
                    self.registerErrorMessage.text = "success"
                
                
                //Handle Failure
                } else {
                    
                    var error_message = ""
                    
                    
                    //Failure: Username Failure
                    if userServerRegisterOutcome.username_failure == 1 {
                        error_message = error_message + userServerRegisterOutcome.user_name_message
                    }
                    
                    //Failure: Full Name Failure
                    if userServerRegisterOutcome.full_name_failure == 1 {
                        error_message = error_message + userServerRegisterOutcome.full_name_message
                    }
                    
                    //Failure: Email Failure
                    if userServerRegisterOutcome.email_failure == 1 {
                        error_message = error_message + userServerRegisterOutcome.email_message
                    }
                    
                    //Failure: Password Failure 
                    if userServerRegisterOutcome.password_failure == 1 {
                        error_message = error_message + userServerRegisterOutcome.password_message
                    }
 
                    
                    self.registerErrorMessage.text = error_message
                
                
            }
        }
        
        
        
    }
    

    }
}

//registerUserOutcome = registerUser(userName: registerUserName, fullName: registerFullName, email:registerEmail, password: registerPassword)

//print("OUTCOME: \(registerUserOutcome.user_name_message)")
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
 

 }
 */
