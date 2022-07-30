//
//  ProfileViewController.swift
//  designLoginThree
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/30/22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        print("logout")
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "LoginMain") as! UINavigationController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    

}
