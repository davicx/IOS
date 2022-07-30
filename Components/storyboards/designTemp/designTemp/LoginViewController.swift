//
//  LoginViewController.swift
//  designTemp
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/27/22.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let postsViewController = storyboard?.instantiateViewController(identifier: "PostsVC") as? PostsViewController
        
        view.window?.rootViewController = postsViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(identifier: "VC") as? ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
