//
//  LoginViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 5/28/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let isSuccessfulLogin = true
    
    weak var delegate: OnboardingDelegate?
    
  
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //Entry Fields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    //Information
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var forgotPassword: UIButton!
    
    //Login Buttons
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private enum PageType {
        case login
        case signUp
    }
    
    //When login changes did change will run
    private var currentPageType: PageType = .login{
        didSet {
            setupViewsFor(pageType: currentPageType)
            //print(currentPageType) prints loging or sign up
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsFor(pageType: .login)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewsFor(pageType: .login)
    }
    
    //Hide or show correct elements
    private func setupViewsFor(pageType: PageType) {
        errorLabel.text = ""
        passwordConfirmationTextField.isHidden = (pageType == .login)
        signUpButton.isHidden = (pageType == .login)
        forgotPassword.isHidden = (pageType == .signUp)
        loginButton.isHidden = (pageType == .signUp)
    }
    
    
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        print("forgot")
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("sign up")
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("login dude!")
        if isSuccessfulLogin {
            delegate?.showMainTabBarController()
        } else {
            
        }
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        //currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
        
        if sender.selectedSegmentIndex == 0 {
            print("Login")
            currentPageType = .login
        } else {
            print("Sign Up")
            currentPageType = .signUp
        }
            
    }
}
