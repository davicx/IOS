//
//  LoginViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit
import SafariServices

//START Video 6 at 21
/*
 1) Upload and Edit Profile
 */

class LoginViewController: UIViewController {
    
    let loginAPI = LoginAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        view.backgroundColor = .systemBackground
        
        usernameEmailField.delegate = self
        passwordfield.delegate = self
        
        //Temp
        usernameEmailField.text = "frodo"
        passwordfield.text = "password"
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        print("DAVID!!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //This will not go all the way to the top of the phone
        //headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3.0)
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height / 3.0)
        configureHeaderView()
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordfield)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }
    
    //CONFIGURE VIEWS
    private func configureHeaderView() {
        guard let backgroundView = headerView.subviews.first as? UIImageView else {
            return
        }
        
        let imageView = UIImageView(image: UIImage(named: "instagram-logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0, y: view.safeAreaInsets.top, width: headerView.width / 2.0, height: headerView.height - view.safeAreaInsets.top)
        
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40 , width: view.width - 50.0, height: 52.0)
        passwordfield.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10 , width: view.width - 50.0, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordfield.bottom + 10 , width: view.width - 50.0, height: 52.0)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10 , width: view.width - 50.0, height: 52.0)
        termsButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom - 100, width: view.width-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom - 50, width: view.width-20, height: 50)
        
        backgroundView.frame = headerView.bounds
    }
    
    
    //BUTTONS
    @objc private func didTapLoginButton() {
        print("didTapLoginButton")
        passwordfield.resignFirstResponder()
        usernameEmailField.resignFirstResponder()

        let username : String = usernameEmailField.text ?? ""
        let password : String = passwordfield.text ?? ""
    
        print("Logging in username \(username) with the password \(password)")
        
        Task{
            do{
                //Get Posts from the API
                let loginResponseModel = try await loginAPI.loginUser(username: username, password: password)
                print(loginResponseModel)
                
                if(loginResponseModel.data.loginSuccess == true) {
                    dismiss(animated: true, completion: nil)
                } else {
                    let message = loginResponseModel.message
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
    
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://www.southwest.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present (vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://www.southwest.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present (vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }


    //UI ELEMENTS
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email.."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton ()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle( "Terms of Service", for: .normal)
       return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton ()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle( "Privacy Policy", for: .normal)
       return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton ()
        button.setTitleColor(.label, for: .normal)
        button.setTitle( "New User? Create an Account", for: .normal)
       return button
    }()

   private let headerView: UIView = {
       let header = UIView()
       
       //So things dont overflow
       header.clipsToBounds = true
       
       let backgroundImageView = UIImageView(image: UIImage(named: "instagram_logo_gradient"))
       backgroundImageView.contentMode = .scaleAspectFill // Make sure the image scales properly
       header.addSubview(backgroundImageView) // Add the image view as a subview
       
       return header
   }()

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordfield.becomeFirstResponder()
        }
        else if textField == passwordfield {
            didTapLoginButton ()
        }
        return true
    }
}

