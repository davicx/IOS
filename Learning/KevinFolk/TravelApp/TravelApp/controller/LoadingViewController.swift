//
//  LoadingViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 11/1/23.
//

//Stop: Video 8 done start Video 9
//https://developer.apple.com/documentation/uikit/view_controllers/showing_and_hiding_view_controllers
import UIKit

class LoadingViewController: UIViewController {
    private let isUserLoggedIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Normal
        //showInitialView()
        
        //Delay
        delay(durationInSeconds: 1.0) {
            self.showInitialView()
        }
        
        //Delay
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showInitialView()
        }
        */
        
    }
    

    private func setupViews() {
        //view.backgroundColor = .orange
        view.backgroundColor = .white
    }
    
    
    private func showInitialView() {
        if isUserLoggedIn {
            PresenterManager.shared.show(vc: .mainTabBarController)
        } else {
            performSegue(withIdentifier: Constants.Segue.showOnboardingScreen, sender: nil)
        }
        
    }
    
}

//Lesson 5
/*
 import UIKit

 class LoadingViewController: UIViewController {
     private let isUserLoggedIn = true

     override func viewDidLoad() {
         super.viewDidLoad()
         setupViews()
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         //Normal
         //showInitialView()
         
         //Delay
         delay(durationInSeconds: 1.0) {
             self.showInitialView()
         }
         
         //Delay
         /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
             self.showInitialView()
         }
         */
         
     }
     

     private func setupViews() {
         //view.backgroundColor = .orange
         view.backgroundColor = .white
     }
     
     
     private func showInitialView() {
         if isUserLoggedIn {
             PresenterManager.shared.show(vc: .mainTabBarController)
         } else {
             performSegue(withIdentifier: Constants.Segue.showOnboardingScreen, sender: nil)
         }
         
     }
     
 }
 */

/*
 if isUserLoggedIn {
     //PresenterManager.shared.show(vc: "MainTabBarController")
     let mainTabBarController = UIStoryboard(name:Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
     
     if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
         let window = sceneDelegate.window {
         window.rootViewController = mainTabBarController
     }
     
     //Original
     /*
     let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
     let window = sceneDelegate.window
     window?.rootViewController = mainTabBarController
     */
 } else {
     //performSegue(withIdentifier: Constants.Segue.showOnboardingScreen, sender: nil)
     performSegue(withIdentifier: Constants.Segue.showOnboardingScreen, sender: nil)
 }
 */
