//
//  ViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//
//STOP: 1 hour 17 minutes- Setting up Login

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    
    func setUpElements() {
        //errorLabel.alpha = 0
        Utilities.styleHollowButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }

    

}

