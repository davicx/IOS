//
//  PresenterManager.swift
//  TravelApp
//
//  Created by David Vasquez on 11/21/23.
//

import UIKit

//This is a little confusing? 
class PresenterManager {
    static let shared = PresenterManager()

    private init(){}
    
    enum VC {
        case mainTabBarController
        case onboarding
    }

    func show(vc: VC) {
        var viewController: UIViewController
        
        switch vc {
            case .mainTabBarController:
                viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
            case .onboarding:
                viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
        }
    
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = viewController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }


}


/*
 
 import UIKit

 class PresenterManager {
     
     //Singleton
     static let shared = PresenterManager()
     

     private init(){}
     
     enum VC {
         case mainTabBarController
         case onboarding
     }
     
     func show(vc: VC) {
         var viewController: UIViewController
         
         switch vc {
             case .mainTabBarController:
                 viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
             case .onboarding:
                 viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
         }
     
         if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
             let window = sceneDelegate.window {
             window.rootViewController = viewController
             
             UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
         }
     }
      
 }
 */
