//
//  LoginViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    //UI
    private let usernameEmailField: UITextField = {
        return UITextField()
    }()
    
    private let passwordfield: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
        
    private let createAccountButton: UIButton = {
        return UIButton()
    }()
    
    
    private let headerView: UIView = {
        return UIView()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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

  
    private func didTapLoginButton() {}
    private func didTapTermsButton() {}
    private func didTapPrivacyButton() {}
    private func didTapCreateAccountButton() {}

}
