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
            // User appears to be logged in locally, verify with server
            print("LoadingViewController: User appears logged in locally, verifying with server...")
            LoginManager.shared.getLoggedInUserStatus { isLoggedIn in
                DispatchQueue.main.async {
                    print("LoadingViewController: Server verification - User is \(isLoggedIn ? "logged in" : "NOT logged in")")
                    
                    if isLoggedIn {
                        PresenterManager.shared.showMainApp()
                        print("LoadingViewController: Server confirmed - You are logged in!")
                    } else {
                        // Server says user is not logged in, update local state and show onboarding
                        self.userDefaultManager.logUserOut()
                        PresenterManager.shared.showOnboarding()
                        print("LoadingViewController: Server says session expired - showing onboarding")
                    }
                }
            }
        } else {
            // User is not logged in locally, show onboarding immediately
            PresenterManager.shared.showOnboarding()
            print("LoadingViewController: You are not logged in locally - showing onboarding")
        }
    }
    

    private func setupView() {
        //view.backgroundColor = .blue
        //print("Don't need")
    }

}

