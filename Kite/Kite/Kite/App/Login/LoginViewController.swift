//
//  LoginViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


class LoginViewController: UIViewController, LoginLayoutManagerDelegate {
    let layoutManager = LoginLayoutManager()
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
        
        LoginManager.shared.loginUser(username: logInUser, password: logInPassword, deviceID: deviceID) { success, message in
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
    
    func didTapRegisterButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registrationVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController {
            navigationController?.pushViewController(registrationVC, animated: true)
        } else {
            print("Error: Could not instantiate RegistrationViewController")
        }
    }


}

