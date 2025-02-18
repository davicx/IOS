//
//  LoginViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


class LoginViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    let loginAPI = LoginAPI()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonStyle: UIButton!
    @IBOutlet weak var loginMessageLabel: UILabel!
    
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        setupElements()
    }
    
    func setupElements() {
        
        //Error Label
        loginMessageLabel.alpha = 0
        
        //Style Buttons and Fields
        Temp.styleTextField(userNameTextField)
        Temp.styleTextField(passwordTextField)
        
        Buttons.styleTwitterButton(loginButtonStyle)
        
        //Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)

    }
    
    @IBAction func loginButton(_ sender: UIButton) {

        //STEP 1: Get Login Information
        let logInUser = userNameTextField.text ?? ""
        let logInPassword = passwordTextField.text ?? ""
   
        
        //STEP 2: Validate Login Information
        let validUsername = validateUserName(userName: logInUser)
        let validPassword = validatePassword(password: logInPassword)
        
        //STEP 3: Login User
        if(validUsername == true && validPassword == true) {
            
            //let deviceID = getDeviceId()
            let deviceID = KeychainHelper.shared.getOrCreateDeviceId()

            print("Device ID:", deviceID)

            Task{
                do{
                    //Get Posts from the API
                    activityIndicator.startAnimating()
                    view.isUserInteractionEnabled = false
                    let loginResponseModel = try await loginAPI.loginUser(username: logInUser, password: logInPassword, deviceID: deviceID)
                    
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
    
    }

    
    @IBAction func registerButton(_ sender: UIButton) {
        print("Register")
    }
    

    @IBAction func getLoginStatusButton(_ sender: UIButton) {
        let loginStatus = userDefaultManager.getLoggedInUserStatus()
        print("User is Logged in \(loginStatus)")
    }
    
    func loginUser(username: String, password: String, deviceID: String) async throws -> String {
        var outcome = ""
        do {
            
            let loginResponseModel = try await loginAPI.loginUser(username: username, password: password, deviceID: deviceID)
            if loginResponseModel.data.loginSuccess {
                let loginOutcome = userDefaultManager.logUserIn(userName: username)
                if loginOutcome {
                    print("You just logged \(username) in successfully.")
                    
                    outcome = "You just logged \(username) in successfully."
                    return outcome
                    
                } else {
                    outcome = "There was an error logging in!"
                    print("There was an error logging in!")
                    return outcome
                }
            } else {
                print("API returned an error during login!")
                outcome = "API returned an error during login!"
                return outcome
            }
        } catch {
            print("An error occurred during login: \(error.localizedDescription)")
            outcome = "An error occurred during login: \(error.localizedDescription)"
            return outcome
        }
    }

    
}

/*
 @IBOutlet weak var startLabel: UILabel!
 
 var activityIndicator = UIActivityIndicatorView()

 
 override func viewDidLoad() {
     super.viewDidLoad()
     activityIndicator.center = self.view.center
     activityIndicator.hidesWhenStopped = true
     activityIndicator.style = UIActivityIndicatorView.Style.medium
     self.view.addSubview(activityIndicator)
     
 }


 @IBAction func startButton(_ sender: UIButton) {
     print("start")
     activityIndicator.startAnimating()
     startLabel.text = "Getting some posts man!"
     view.isUserInteractionEnabled = false
     
     Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
         self.activityIndicator.stopAnimating()
         self.view.isUserInteractionEnabled = true
         self.startLabel.text = "Got them posts dude!"
     }
 }
 

 // Optionally disable specific controls like buttons
 //actionButton.isEnabled = false


 @IBAction func stopButton(_ sender: UIButton) {
     print("stop")
     startLabel.text = "I am Stopped"
     activityIndicator.stopAnimating()

 }
 
 */
