//
//  LoadingViewController.swift
//  CheckLoginStatus
//
//  Created by David on 4/11/23.
//

//https://www.youtube.com/watch?v=bwd5ixqUgu4
import Foundation
import UIKit


class LoadingViewController: UIViewController {
    
    private let isUserLoggedIn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(durationInSeconds: 1.0) {
            self.showInitialView()
        }
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showInitialView()
        }
        */
        //showInitialView()
        
    }
    
    
    private func setupView() {
        //view.backgroundColor = .orange
    }
    
    private func showInitialView() {
        if isUserLoggedIn {
            let mainTabBarController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                window.rootViewController = mainTabBarController
            }
            
        } else {
            performSegue(withIdentifier: Constants.Segue.showOnboardingScreen, sender: nil)
        }
        
    }
    
}


/*
 //let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
 //let homeViewController = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
 //view.window?.rootViewController = homeViewController
 //view.window?.makeKeyAndVisible()
 
 //let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
 //let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
 //let window = sceneDelegate.window
 //window?.rootViewController = mainTabBarController
 


 */