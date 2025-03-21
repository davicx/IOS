//
//  LoginViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


//COMPARE TO WORKING STUFF
class LoginViewController: UIViewController, LoginLayoutManagerDelegate {
    let userDefaultManager = UserDefaultManager()
    let loginAPI = LoginAPI()
    let layoutManager = LoginLayoutManager()
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        
        layoutManager.delegate = self
        
        layoutManager.setupViews(in: view)
        layoutManager.setupConstraints(in: view)
        layoutManager.setupTextFields()
        layoutManager.setupButtons(in: view)
        setupElements()
        
      
    }
    
    func setupElements() {
        // Error Label
        //loginMessageLabel.alpha = 0
        
        // Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)
    }
    
    // Called when the user taps the Forgot Password button
    func didTapForgotPasswordButton() {
        print("Forgot Password")
    }
    
    // Called when the user taps the Login button
    func didTapLoginButton() {
        print("Login Button Tapped")
        
        // STEP 1: Get Login Information
        let logInUser = layoutManager.usernameTextField.text ?? ""
        let logInPassword = layoutManager.passwordTextField.text ?? ""
        
        // STEP 2: Validate Login Information
        let validUsername = validateUserName(userName: logInUser)
        let validPassword = validatePassword(password: logInPassword)
        
        // STEP 3: Login User
        if(validUsername == true && validPassword == true) {
            let deviceID = KeychainHelper.shared.getOrCreateDeviceId()

            print("Device ID:", deviceID)

            Task {
                do {
                    activityIndicator.startAnimating()
                    view.isUserInteractionEnabled = false
                    let loginResponseModel = try await loginAPI.loginUser(username: logInUser, password: logInPassword, deviceID: deviceID)
                    
                    activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                    if(loginResponseModel.data.loginSuccess == true) {
                        let loginOutcome = userDefaultManager.logUserIn(userName: logInUser)
                        
                        if(loginOutcome) {
                            print("You just logged \(logInUser) in")
                            PresenterManager.shared.showMainApp()
                        } else {
                            print("Was an error logging in!")
                        }
                    } else {
                        print("Username or Password was wrong!")
                    }
                } catch {
                    print("yo man error!")
                    print(error)
                }
            }
        } else {
            if(validUsername == false && validPassword == true) {
                errrorMessage = "STEP 2: Please enter a Valid username"
                print("STEP 2: Please enter a Valid username")
            } else if(validPassword == false && validUsername == true) {
                errrorMessage = "STEP 2: Please enter a Valid password"
                print("STEP 2: Please enter a Valid password")
            } else {
                errrorMessage = "STEP 2: Please enter a Valid username and password"
                print("STEP 2:  Please enter a Valid username and password")
            }
        }
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


//WITH LOGIC PULLED OUT and MOVED TO loginFunctions
/*
 class LoginViewController: UIViewController, LoginLayoutManagerDelegate {
     let layoutManager = LoginLayoutManager()
     let loginManager = LoginManager()
     let userDefaultManager = UserDefaultManager()
     var activityIndicator = UIActivityIndicatorView()
     var errrorMessage = ""
     
     override func viewDidLoad() {
         super.viewDidLoad()
         print("LoginViewController")
         
         layoutManager.delegate = self
         layoutManager.setupViews(in: view)
         layoutManager.setupConstraints(in: view)
         layoutManager.setupTextFields()
         layoutManager.setupButtons(in: view)
         setupElements()
     }
     
     func setupElements() {
         activityIndicator.center = self.view.center
         activityIndicator.hidesWhenStopped = true
         activityIndicator.style = UIActivityIndicatorView.Style.medium
         self.view.addSubview(activityIndicator)
     }
     
     func didTapLoginButton() {
         print("Login Button Tapped")
         
         let logInUser = layoutManager.usernameTextField.text ?? ""
         let logInPassword = layoutManager.passwordTextField.text ?? ""
         
         // Validate inputs
         let validUsername = validateUserName(userName: logInUser)
         let validPassword = validatePassword(password: logInPassword)
         
         if !validUsername || !validPassword {
             print("Invalid username or password.")
             return
         }
         
         let deviceID = KeychainHelper.shared.getOrCreateDeviceId()
         print("Device ID:", deviceID)
         
         activityIndicator.startAnimating()
         view.isUserInteractionEnabled = false
         
         loginManager.login(username: logInUser, password: logInPassword, deviceID: deviceID) { success, message in
             DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating()
                 self.view.isUserInteractionEnabled = true
                 print(message)
                 
                 if success {
                     PresenterManager.shared.showMainApp()
                 }
             }
         }
     }
     
     func didTapForgotPasswordButton() {
         print("Forgot Password")
     }
 }

 */



//CURRENT WORKS!!
/*
class LoginViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    let loginAPI = LoginAPI()
    
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""
    
    
    //VIEWS
    let logoView = UIView()
    let loginView = UIView()
    let dividerView = UIView()
    let registerView = UIView()
    let footerView = UIView()
    
    //LABELS
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        setupElements()
        setupViews()
        setupConstraints()
        setupLoginLabels()
    }
    
    func setupElements() {
        
        //LABELS
        //Style.styleUsernameLabel(usernameLabel)
        //Style.styleUsernameLabel(passwordLabel)
        
        //BUTTONS
        //Buttons.styleForgotPasswordButton(forgotPasswordButton)
        //Buttons.styleLoginButton(loginButton)
        
        //Error Label
        //loginMessageLabel.alpha = 0
        
        //Style Buttons and Fields
        //Temp.styleTextField(userNameTextField)
        //Temp.styleTextField(passwordTextField)
        
        //Buttons.styleLoginFilledButton(loginButtonStyle)
        
        //Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)

    }
    
    
    
    
    func setupViews() {
        logoView.backgroundColor = .systemBlue
        loginView.backgroundColor = .white
        dividerView.backgroundColor = .gray
        registerView.backgroundColor = .systemGreen
        footerView.backgroundColor = .lightGray
        
        [logoView, loginView, dividerView, registerView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               // LogoView - 20%
               logoView.topAnchor.constraint(equalTo: view.topAnchor),
               logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               logoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

               // LoginView - 20%
               loginView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
               loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.375),
               
               // DividerView - 15%
               dividerView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
               dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               dividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),
               
               // RegisterView - 15%
               registerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
               registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               registerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

               // FooterView - Remaining 30%
               footerView.topAnchor.constraint(equalTo: registerView.bottomAnchor),
               footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }

    func setupLoginLabels() {
        // Configure text fields
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true // Hide password input
        
        Style.styleLoginTextField(usernameTextField)
        Style.styleLoginTextField(passwordTextField)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginView.addSubview(usernameTextField)
        loginView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            // Username TextField - 12 from top
            usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
            usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 320),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField - 20 below username
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

    
        //STEP 1: Get Login Information
        let logInUser = usernameTextField.text ?? ""
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
                        //Make this the error message
                        //loginMessageLabel.alpha = 1
                        //loginMessageLabel.text = "Username or Password was wrong!"
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
            
            //Make this the error message
            //loginMessageLabel.alpha = 1
            //loginMessageLabel.text = errrorMessage
        
        }
         
    
    }

    
    @IBAction func registerButton(_ sender: UIButton) {
        print("Register")
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
 
 
 
 */



//FULL CODE
/*
 import UIKit

 class LoginViewController: UIViewController {
     
     private let forgotPasswordButton: UIButton = {
         let button = UIButton()
         button.setTitle("Forgot Password?", for: .normal)
         button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = .clear
         return button
     }()
     
     private let loginButton: UIButton = {
         let button = UIButton()
         button.setTitle("Login", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = UIColor(hex: "#3797EF")
         button.layer.cornerRadius = 5
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.addSubview(forgotPasswordButton)
         view.addSubview(loginButton)
         
         setupConstraints()
     }
     
     private func setupConstraints() {
         forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
         loginButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             forgotPasswordButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             
             loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
             loginButton.widthAnchor.constraint(equalToConstant: 200),
             loginButton.heightAnchor.constraint(equalToConstant: 40)
         ])
     }
 }

 // UIColor Extension for Hex Colors
 extension UIColor {
     convenience init(hex: String) {
         var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
         hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

         var rgb: UInt64 = 0
         Scanner(string: hexSanitized).scanHexInt64(&rgb)

         let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
         let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
         let b = CGFloat(rgb & 0xFF) / 255.0

         self.init(red: r, green: g, blue: b, alpha: 1.0)
     }
 }

 */

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
