//
//  SignUpViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var signUpButtonStyle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStatus()
        setUpElements()

    }
    
    @IBAction func signUpButton(_ sender: Any) {

        //TO DO: Validate Fields (DONT ALLOW @) 
        let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let actualEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let firebaseEmail = userName + "@kite.com"
        
        // Create the user
        Auth.auth().createUser(withEmail: firebaseEmail, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                self.showError("Error creating user")
            } else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["email":actualEmail, "firstName":name, "lastName":name, "password":password,"userName":userName,  "uid": result!.user.uid ]) { (error) in
                    
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
    
    
    func setUpElements() {
        errorLabel.alpha = 0;
        Style.styleTextField(userNameTextField)
        Style.styleTextField(emailTextField)
        Style.styleTextField(nameTextField)
        Style.styleTextField(passwordTextField)
        Style.styleTextField(passwordConfirmTextField)
        Style.styleFilledButton(signUpButtonStyle)

    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
        let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
        self.view.window?.rootViewController = PostsViewController
        self.view.window?.makeKeyAndVisible()
    }
 
    
    //Move to another File
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordConfirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validation.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 6 characters"
        }
        
        return nil
    }

    
    func userStatus() -> String {
        var userName = "null"
        var email = "null"
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                email = user.email!
                userName = email
                print("Signed In! \(email)")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                print("NOT Signed In!")
            }
       }
        return userName
    }


}

