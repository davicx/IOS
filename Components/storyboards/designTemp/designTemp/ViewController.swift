//
//  ViewController.swift
//  designTemp
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/27/22.
//

//https://developer.apple.com/documentation/uikit/view_controllers/showing_and_hiding_view_controllers

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        /*
         let story = UIStoryboard(name: "Main", bundle:nil)
         let vc = story.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
         UIApplication.shared.windows.first?.rootViewController = vc
         UIApplication.shared.windows.first?.makeKeyAndVisible()
         
         print("go to posts")
         //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         //let postsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! PostsViewController
         //self.present(postsViewController, animated:true, completion:nil)
     
         //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         //let postsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! PostsViewController
         //self.view.window?.rootViewController = postsViewController
         //self.view.window?.makeKeyAndVisible()
         
         //let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         //let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "CreateUserVC_Navigation") as! UINavigationController
         //self.present(vc, animated: true, completion: nil)
         
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? PostsViewController
         //THiS? self.present(homeView, animated: true, completion: nil)
         self.navigationController?.pushViewController(vc!, animated: true)
         
         let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
     
         */
    }
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        let registerViewController = storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterViewController
        
        view.window?.rootViewController = registerViewController
        view.window?.makeKeyAndVisible()
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        let loginViewController = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
}

