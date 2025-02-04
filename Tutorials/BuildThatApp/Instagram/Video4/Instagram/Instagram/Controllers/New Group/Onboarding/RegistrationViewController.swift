//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit

class RegistrationViewController: UIViewController {

    let loginAPI = LoginAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .white
        
        //Temp
        usernameField.text = "frodo"
        fullNameField.text = "frodo v"
        emailField.text = "frodo@gmail.com"
        passwordfield.text = "frodo2"
        
        addSubviews()
    }
    
    
    //ADD VIEWS
    private func addSubviews() {
        usernameField.delegate = self
        fullNameField.delegate = self
        emailField.delegate = self
        passwordfield.delegate = self

        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
            
        view.addSubview(usernameField)
        view.addSubview(fullNameField)
        view.addSubview(emailField)
        view.addSubview(passwordfield)
        view.addSubview(registerButton)
    }
    
    //SET LAYOUT
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100 , width: view.width - 40.0, height: 52.0)
        fullNameField.frame = CGRect(x: 20, y: usernameField.bottom + 10 , width: view.width - 40.0, height: 52.0)
        emailField.frame = CGRect(x: 20, y: fullNameField.bottom + 10 , width: view.width - 40.0, height: 52.0)
        passwordfield.frame = CGRect(x: 20, y: emailField.bottom + 10 , width: view.width - 40.0, height: 52.0)
        registerButton.frame = CGRect(x: 20, y: passwordfield.bottom + 10 , width: view.width - 40.0, height: 52.0)
 
    }
    
    
    //UI ELEMENTS
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username.."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let fullNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Full Name.."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email.."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Password.."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.isSecureTextEntry = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()

    
    //BUTTONS
    @objc private func didTapRegisterButton() {
        print("didTapLoginButton")
        
        //Hide Keyboard
        usernameField.resignFirstResponder()
        fullNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordfield.resignFirstResponder()
        

        
        //ADD THESE TO THE INPUTS
        let username : String = usernameField.text ?? ""
        let fullName : String = fullNameField.text ?? ""
        let email : String = emailField.text ?? ""
        let password : String = passwordfield.text ?? ""
        
        let validUserName = validateUserName(userName: username)
        let validFullName = validateFullName(fullName: fullName)
        let validEmail = validateEmail(email: email)
        let validPassword = validatePassword(userName: password)

        print("Valid username \(validUserName) fullName \(validFullName) email \(validEmail) password \(validPassword)")
        print("REGISTER username \(username) fullName \(fullName) email \(email) password \(password)")
        

        Task{
            do{
                //Get Posts from the API
                let registerResponseModel = try await loginAPI.registerNewUser(username: username, fullName: fullName, email: email, password: password)
                //print(registerResponseModel)
                var message = ""
         
                /*
                 DispatchQueue.main.async {
                     print("Put code here for UI Updates")
                 }
                 
                 */

                if(registerResponseModel.data.registrationValidation.masterSuccess == true) {
                    print("Succesfully registered User! \(registerResponseModel.data.newUser.userName)")
                    //dismiss(animated: true, completion: nil)
                } else {
                    
                    if(registerResponseModel.data.registrationValidation.emailStatus == 0) {
                        message = message + registerResponseModel.data.registrationValidation.emailMessage + " "                    }
                    
                    if (registerResponseModel.data.registrationValidation.usernameStatus == 0) {
                        message = message + registerResponseModel.data.registrationValidation.usernameMessage + " "
                    }
                        
                    if (registerResponseModel.data.registrationValidation.passwordStatus == 0) {
                        message = message + registerResponseModel.data.registrationValidation.passwordMessage + " "
                    }
                        
                    if (registerResponseModel.data.registrationValidation.usernameAvailableStatus == 0) {
                        message = message + registerResponseModel.data.registrationValidation.usernameAvailableMessage + " "
                    }
                        
                    print(message)
                    let alert = UIAlertController(title: "Log In Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present (alert, animated: true)
                }
            

            } catch{
                print("yo man error!")
                print(error)
            }
        }

        
    }
    
}


extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            fullNameField.becomeFirstResponder()
        } else if textField == fullNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordfield.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        return true
    }
}


//APPENDIX

/*
 @objc private func didTapLoginButton() {


 }
 
 */

/*
guard let username = usernameEmailField.text, username.isEmpty,
      let password = passwordfield.text, !password.isEmpty, password.count >= 2 else {
    print("error")
    return
}


let loginOutcome = loginAPI.loginUser(username: "davey", email: "davey@gmail.com", password: "password")

if(loginOutcome == true) {
    dismiss(animated: true, completion: nil)
} else {
    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    present (alert, animated: true)
}
 */

