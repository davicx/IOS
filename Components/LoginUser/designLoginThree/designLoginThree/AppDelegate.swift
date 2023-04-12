//
//  AppDelegate.swift
//  designLoginThree
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/28/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("launching")
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "AppMain") as! UITabBarController
        // let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
        //self.window?.rootViewController = homePage
        self.window?.rootViewController = homeViewController
        self.window?.makeKeyAndVisible()
        
        //let homePage = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! HomeViewController
        //self.window?.rootViewController = homePage
        
        //let viewController = HomeViewController()
        //let navigation = UINavigationController(rootViewController: viewController)
        //window!.rootViewController = navigation
        //window!.makeKeyAndVisible()
        
        /*
         let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        */
        
        /*
         /// 1. Capture the scene
         guard let windowScene = (scene as? UIWindowScene) else { return }
         
         /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
         let window = UIWindow(windowScene: windowScene)
         
         /// 3. Create a view hierarchy programmatically
         let viewController = ArticleListViewController()
         let navigation = UINavigationController(rootViewController: viewController)
         
         /// 4. Set the root view controller of the window with your view controller
         window.rootViewController = navigation
         
         /// 5. Set the window and call makeKeyAndVisible()
         self.window = window
         window.makeKeyAndVisible()
         */

        return true
    }
    
    
        
     /*
      //https://stackoverflow.com/questions/33714671/value-of-type-appdelegate-has-no-member-window
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //WORKS
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "AppMain") as! UITabBarController
        //
        self.window?.rootViewController = homeViewController
        self.window?.makeKeyAndVisible()
        //view.window?.rootViewController = homeViewController
        //view.window?.makeKeyAndVisible()
        */
        //let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
       
       
        //window?.rootViewController = homeViewController
        //window?.makeKeyAndVisible()
        
        //NEW
        /*
         self.window = UIWindow(frame: UIScreen.main.bounds)
                 
                 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                 navigationController.viewControllers = [rootViewController]
                 self.window?.rootViewController = navigationController
                 self.window?.makeKeyAndVisible()
         
         auth.delegate = self
          
          self.window = UIWindow(frame: UIScreen.main.bounds)
          
          let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
          navigationController.viewControllers = [rootViewController]
          self.window?.rootViewController = navigationController
          self.window?.makeKeyAndVisible()
         */
        
        
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //view.window?.rootViewController = homeViewController
        
        //view.window?.rootViewController = homeViewController
        //view.window?.makeKeyAndVisible()
       
        
        
        
    
    //
    //let homePage = mainStoryboard.instantiateViewController(withIdentifier: "AppMain") as! UITabBarController
    //UIApplication.shared.delegate?.window?!.rootViewController = homePage
    

        //let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let homePage = mainStoryboard.instantiateViewController(withIdentifier: "AppMain") as! UITabBarController
        //UIApplication.shared.delegate?.window?!.rootViewController = homePage

         //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
         //appDelegate.window!.rootViewController = appController

         //let initialViewController = storyboard.instantiateViewController(withIdentifier: "dashboardVC")

         //self.window?.rootViewController = initialViewController
         //self.window?.makeKeyAndVisible()
        
        //let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
        //view.window?.rootViewController = homeViewController
        //view.window?.makeKeyAndVisible()

    
    /*
     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

              let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("Circles") as UIViewController
              self.window = UIWindow(frame: UIScreen.main.bounds)
              self.window?.rootViewController = initialViewControlleripad
              self.window?.makeKeyAndVisible()

              return true
         }
     
     */


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

