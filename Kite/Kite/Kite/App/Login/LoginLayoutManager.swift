//
//  LoginLayoutManager.swift
//  Kite
//
//  Created by David Vasquez on 3/20/25.
//

import UIKit


protocol LoginLayoutManagerDelegate: AnyObject {
    func didTapLoginButton()
    func didTapForgotPasswordButton()
    func didTapRegisterButton() // New method
}

class LoginLayoutManager {
    weak var delegate: LoginLayoutManagerDelegate?

    let logoView = UIView()
    let loginView = UIView()
    let dividerView = UIView()
    let registerView = UIView()
    let footerView = UIView()
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    

    func setupViews(in view: UIView) {
        // Background Colors for visualization
        logoView.backgroundColor = .systemBlue
        loginView.backgroundColor = .white
        dividerView.backgroundColor = .clear
        registerView.backgroundColor = .clear
        footerView.backgroundColor = .lightGray
        
        // Add all views to the parent view
        [logoView, loginView, dividerView, registerView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupDividerView()
        setupRegisterView()
    }


    
    func setupConstraints(in view: UIView) {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.topAnchor),
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            loginView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.375),

            dividerView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),

            registerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

            footerView.topAnchor.constraint(equalTo: registerView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTextFields() {
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        // Add default text
        usernameTextField.text = "davey"
        passwordTextField.text = "password"
        
        Style.styleLoginTextField(usernameTextField)
        Style.styleLoginTextField(passwordTextField)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        loginView.addSubview(usernameTextField)
        loginView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
            usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 320),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupButtons(in view: UIView) {
        // Create Forgot Password Button
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        loginView.addSubview(forgotPasswordButton)
        
        // Create Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "#3797EF")
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginView.addSubview(loginButton)

        // Constraints for Forgot Password Button
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 12),
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 320),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //DIVIDER
    func setupDividerView() {
        let dividerWithLabel = DividerWithLabel()
        dividerWithLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.addSubview(dividerWithLabel)

        // Center the DividerWithLabel inside the dividerView
        NSLayoutConstraint.activate([
            dividerWithLabel.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor),
            dividerWithLabel.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor),
            dividerWithLabel.leadingAnchor.constraint(equalTo: dividerView.leadingAnchor, constant: 20),
            dividerWithLabel.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: -20),
            dividerWithLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
    //REGISTER
    func setupRegisterView() {
        let registerLabel = UILabel()
        registerLabel.text = "Don’t have an account?"
        registerLabel.textColor = .black
        registerLabel.font = UIFont.systemFont(ofSize: 14)

        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        registerView.addSubview(registerLabel)
        registerView.addSubview(signUpButton)

        NSLayoutConstraint.activate([
            registerLabel.centerXAnchor.constraint(equalTo: registerView.centerXAnchor, constant: -30),
            registerLabel.centerYAnchor.constraint(equalTo: registerView.centerYAnchor),
            
            signUpButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: registerLabel.centerYAnchor)
        ])
    }


    //BUTTON LOGIC
    @objc func forgotPasswordTapped() {
        delegate?.didTapForgotPasswordButton()
    }

    @objc func loginTapped() {
        delegate?.didTapLoginButton()
    }
    
    @objc func registerTapped() {
        delegate?.didTapRegisterButton()
    }
    
}

