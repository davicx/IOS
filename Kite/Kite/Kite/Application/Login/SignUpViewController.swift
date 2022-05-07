//
//  SignUpViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    @IBOutlet weak var fullNameTextInput: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements() 


    }

    @IBAction func signUpButton(_ sender: Any) {
        print("Sign up!")
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(userNameTextInput)
        Utilities.styleTextField(emailTextInput)
        Utilities.styleTextField(passwordTextInput)
        Utilities.styleTextField(fullNameTextInput)
    }

    
}
