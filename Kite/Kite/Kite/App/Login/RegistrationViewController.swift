//
//  RegistrationViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit

class RegistrationViewController: UIViewController {

    let loginAPI = LoginAPI()
    
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""

    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var fullNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var registerButtonStyle: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RegistrationViewController")
        
        setupElements()

    }
    
    func setupElements() {
        
        //Error Label
        messageLabel.alpha = 0
        
        //Style Buttons and Fields
        //Temp.styleTextField(userNameTextField)
        //Temp.styleTextField(passwordTextField)
        
        //Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)

    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        //STEP 1: Get Register Information
        let userName = userNameLabel.text ?? ""
        let fullName = fullNameLabel.text ?? ""
        let email = emailLabel.text ?? ""
        let password = passwordLabel.text ?? ""
   
        //STEP 2: Validate Local Register Information
        let validUsername = validateUserName(userName: userName)
        let validateFullName = validateFullName(fullName: fullName)
        let validEmail = validateEmail(email: email)
        let validPassword = validatePassword(password: password)

        if(validUsername == true && validPassword == true) {
            print("Good info!! ")

             //STEP 3: Register User
             Task{

                 do{
                     //API
                     activityIndicator.startAnimating()
                     view.isUserInteractionEnabled = false
                 
                     let registerResponseModel = try await loginAPI.registerNewUser(username: userName, fullName: fullName, email: email, password: password)
                     
                     activityIndicator.stopAnimating()
                     self.view.isUserInteractionEnabled = true
                  
                     //STEP 4: Handle Register User Information Response good username, etc)
                     if(registerResponseModel.success == true) {
                         
                         let alert = UIAlertController(title: "Register Message", message: "You sucesfully Registered", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                             switch action.style{
                                 case .default:
                                 print("default")
                                 
                                 case .cancel:
                                 print("cancel")
                                 
                                 case .destructive:
                                 print("destructive")
                                 
                             }
                         }))
                         self.present(alert, animated: true, completion: nil)

       
                     //STEP 4: Handle Register User Information Response with a need like a different username, etc
                     } else {
                         messageLabel.alpha = 1
                         messageLabel.text = registerResponseModel.message //NEED TO FIX
                         print("Username or Password was wrong!")
                     }
                     
                     
                 } catch{
                     print("yo man error!")
                     print(error)
                 }
             }
             
            
        } else {
            errrorMessage = getRegisterMessage(validUsername: validUsername, validFullName: validateFullName, validEmail: validEmail, validPassword: validPassword)
            print(errrorMessage)
        }
        
    
    
    }
    
    
/*
    //STEP 1: Get Login Information
    let logInUser = userNameTextField.text ?? ""
    let logInPassword = passwordTextField.text ?? ""

    
    //STEP 2: Validate Login Information
    let validUsername = validateUserName(userName: logInUser)
    let validPassword = validatePassword(password: logInPassword)
    
    //STEP 3: Login User
    if(validUsername == true && validPassword == true) {

        Task{
            do{
                //Get Posts from the API
                activityIndicator.startAnimating()
                view.isUserInteractionEnabled = false
                let loginResponseModel = try await loginAPI.loginUser(username: logInUser, password: logInPassword)
                
                activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
                
                //API
                if(loginResponseModel.data.loginSuccess == true) {
                    
                    //Local Storage
                    let loginOutcome = userDefaultManager.logUserIn(userName: logInUser)
                    
                    if(loginOutcome) {
                        print("You just logged \(logInUser) in")
                        print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                        
                        PresenterManager.shared.showMainApp()
                        
                    } else {
                        print("Was an error logging in!")
                    }
                } else {
                    loginMessageLabel.alpha = 1
                    loginMessageLabel.text = "Username or Password was wrong!"
                    print("Username or Password was wrong!")
                }
            } catch{
                print("yo man error!")
                print(error)
            }
        }
        
    //STEP 3: The user did not enter information
    } else {
        if(validUsername == false && validPassword == true) {
            errrorMessage = "STEP 2: Please enter a Valid username"
            print("STEP 2: Please enter a Valid username")
        } else if(validPassword == false && validUsername == true) {
            errrorMessage = "STEP 2: Please enter a Valid password"
            print("STEP 2: Please enter a Valid password")
        } else if (validPassword == false && validUsername == false){
            errrorMessage = "STEP 2: Please enter a Valid username and password"
            print("STEP 2:  Please enter a Valid username and password")
        }
        
        loginMessageLabel.alpha = 1
        loginMessageLabel.text = errrorMessage
    
        
    }

   */
    
}
