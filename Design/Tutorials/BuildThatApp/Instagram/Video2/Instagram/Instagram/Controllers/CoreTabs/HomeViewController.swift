//
//  HomeViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/13/24.
//

import UIKit

class HomeViewController: UIViewController {
    var loggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleNotAuthenticated()
        

        
    }

    private func handleNotAuthenticated() {
        if(loggedIn) {
            print("Logged in")
        } else {
            let loginVC = LoginViewController ()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }


    }

    

}



