//
//  SignUpViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    @IBOutlet weak var fullNameTextInput: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements() 
    }

    @IBAction func signUpButton(_ sender: Any) {
        print("Sign up!")

        //Validate the fields
        //let error = validateFields()
        let error = 0
        
        //Create new Login
        if error == 0 {
            
            //STEP 1: Create cleaned versions of the data
            let userName = userNameTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let fullName = fullNameTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            print("create a user with \(userName) \(email) \(password) \(fullName)")
            
            //STEP 2: Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err == nil {
                    print("User Created now adding to database")
                    let db = Firestore.firestore()
                    
                    //STEP 3: Add user to Firebase Users
                    db.collection("users").addDocument(data: ["userName":userName, "email":email, "password":password, "fullName":fullName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                        print(result)
                    }
                    
                    //Transition to home screen
                    self.transitionToHome()
                    
                //Error: Couldn't create login
                } else {
                    //self.showError("Error creating user")
                    print(err)
                }

            }
             
        //Error: Couldn't validate the fields
        } else {
            //showError(error!)
            print("couldn't validate")
     
        }        
    }
    

    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(userNameTextInput)
        Utilities.styleTextField(emailTextInput)
        Utilities.styleTextField(passwordTextInput)
        Utilities.styleTextField(fullNameTextInput)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if userNameTextInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fullNameTextInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        //let cleanedPassword = passwordTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Validate password
        /*
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        */
        
        return nil
    }

    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}


/*
 
 //
 //  SignUpViewController.swift
 //  CustomLoginDemo
 //
 //  Created by Christopher Ching on 2019-07-22.
 //  Copyright © 2019 Christopher Ching. All rights reserved.
 //

 import UIKit
 import FirebaseAuth
 import Firebase

 class SignUpViewController: UIViewController {

     @IBOutlet weak var firstNameTextField: UITextField!
     
     @IBOutlet weak var lastNameTextField: UITextField!
     
     @IBOutlet weak var emailTextField: UITextField!
     
     @IBOutlet weak var passwordTextField: UITextField!
     
     @IBOutlet weak var signUpButton: UIButton!
     
     @IBOutlet weak var errorLabel: UILabel!
     
     
     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
         setUpElements()
     }
     
     func setUpElements() {
     
         // Hide the error label
         errorLabel.alpha = 0
     
         // Style the elements
         Utilities.styleTextField(firstNameTextField)
         Utilities.styleTextField(lastNameTextField)
         Utilities.styleTextField(emailTextField)
         Utilities.styleTextField(passwordTextField)
         Utilities.styleFilledButton(signUpButton)
     }
     
     // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
     func validateFields() -> String? {
         
         // Check that all fields are filled in
         if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
             
             return "Please fill in all fields."
         }
         
         // Check if the password is secure
         let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
         if Utilities.isPasswordValid(cleanedPassword) == false {
             // Password isn't secure enough
             return "Please make sure your password is at least 8 characters, contains a special character and a number."
         }
         
         return nil
     }
     

     @IBAction func signUpTapped(_ sender: Any) {
         
         // Validate the fields
         let error = validateFields()
         
         if error != nil {
             
             // There's something wrong with the fields, show error message
             showError(error!)
         }
         else {
             
             // Create cleaned versions of the data
             let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             
             // Create the user
             Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                 
                 // Check for errors
                 if err != nil {
                     
                     // There was an error creating the user
                     self.showError("Error creating user")
                 }
                 else {
                     
                     // User was created successfully, now store the first name and last name
                     let db = Firestore.firestore()
                     
                     db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                         
                         if error != nil {
                             // Show error message
                             self.showError("Error saving user data")
                         }
                     }
                     
                     // Transition to the home screen
                     self.transitionToHome()
                 }
                 
             }
             
             
             
         }
     }
     
     func showError(_ message:String) {
         
         errorLabel.text = message
         errorLabel.alpha = 1
     }
     
     func transitionToHome() {
         
         let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
         
     }
     
 }

 */

/*

 // Check for errors
 if err != nil {
     
     // There was an error creating the user
     self.showError("Error creating user")
 }
 else {
     
     // User was created successfully, now store the first name and last name
     let db = Firestore.firestore()
     
     db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
         
         if error != nil {
             // Show error message
             self.showError("Error saving user data")
         }
     }
     
     // Transition to the home screen
     self.transitionToHome()
 }
 
 */
