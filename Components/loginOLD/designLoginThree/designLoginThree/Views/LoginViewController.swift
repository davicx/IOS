//
//  LoginViewController.swift
//  designLoginThree
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/30/22.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        print("login")
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
}
