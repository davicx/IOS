//
//  PresenterManager.swift
//  Kite
//
//  Created by David Vasquez on 12/22/24.
//

import UIKit



class PresenterManager {
        
    //Singleton
    static let shared = PresenterManager()
    private init(){}
    
    enum VC {
        case mainTabBarController
        case onboarding
    }
    
    func showMainApp() {
        var viewController: UIViewController
        
        viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = viewController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    
    func showOnboarding() {
        var viewController: UIViewController
    
        viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
        
        //This replaces this if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = viewController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
    }
    
    
     
}


/*
 //
 //  PresenterManager.swift
 //  TravelApp
 //
 //  Created by David Vasquez on 11/27/24.
 //

 import UIKit



 class PresenterManager {
         
     //Singleton
     static let shared = PresenterManager()
     private init(){}
     
     enum VC {
         case mainTabBarController
         case onboarding
     }
     
     func showMainApp() {
         var viewController: UIViewController
         
         viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
         
         if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
             let window = sceneDelegate.window {
             window.rootViewController = viewController
             
             UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
         }
     }
     
     
     func showOnboarding() {
         var viewController: UIViewController
     
         viewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
         
         //This replaces this if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
         if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
             let window = sceneDelegate.window {
             window.rootViewController = viewController
             
             UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
         }
         
     }
     
     
     /*
      let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
      
      if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
          let window = sceneDelegate.window {
          window.rootViewController = onboardingViewController
          
          UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
      }
      */
     
     
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

 */
