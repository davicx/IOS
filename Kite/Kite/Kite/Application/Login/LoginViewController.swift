//
//  LoginViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(userNameTextInput)
        Utilities.styleTextField(passwordTextInput)
    }


}
