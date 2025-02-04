//
//  LoadingViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 11/22/24.
//

import UIKit


class LoadingViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    private var isUserLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
        delay(durationInSeconds: 1.0) {
            self.showInitialView()
        }

    }
     
    private func showInitialView() {
        isUserLoggedIn = userDefaultManager.getLoggedInUserStatus()
        
        if isUserLoggedIn {
            PresenterManager.shared.showMainApp()
            print("LoadingViewController: You are logged in!")
        } else {
            PresenterManager.shared.showOnboarding()
            print("LoadingViewController: You are not logged in!")
        }
    }
    

    private func setupView() {
        //view.backgroundColor = .blue
        //print("Don't need")
    }

}

