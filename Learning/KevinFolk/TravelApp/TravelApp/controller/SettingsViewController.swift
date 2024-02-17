//
//  SettingsViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 11/15/23.
//

import Foundation

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController Loaded")
        setupViews()
    }
    
    
    private func setupViews() {
        view.backgroundColor = .gray
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        print("Logout")
        PresenterManager.shared.show(vc: .onboarding)
        
    }

}

//Lesson 4
/*
 
 import Foundation

 import UIKit

 class SettingsViewController: UIViewController {
     override func viewDidLoad() {
         super.viewDidLoad()
         print("SettingsViewController Loaded")
         setupViews()
     }
     
     
     private func setupViews() {
         view.backgroundColor = .gray
     }
     
     @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
         print("Logout")
         //OnboardingViewController
         let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
         
         if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
             let window = sceneDelegate.window {
             window.rootViewController = onboardingViewController
             
             UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
         }
         
     }

 }

 */

/*
 
 import Foundation

 import UIKit

 @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
     print("Logout")
 }
 class SettingsViewController: UIViewController {
     override func viewDidLoad() {
         super.viewDidLoad()
         print("SettingsVC loaded")
         setupViews()
     }
     
     
     private func setupViews() {
         view.backgroundColor = .white
     }
     
     @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
         print("Logout")
         PresenterManager.shared.show(vc: .onboarding)
         
         //Need to clean
         
         /*
         let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
         
         if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
             let window = sceneDelegate.window {
             window.rootViewController = onboardingViewController
             
             UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
         }
         
          */
         //Manual Transition
         /*         let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
          
          if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
              let window = sceneDelegate.window {
              window.rootViewController = onboardingViewController
              
              UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
          }
          */
         
     }
     
 }

 */
