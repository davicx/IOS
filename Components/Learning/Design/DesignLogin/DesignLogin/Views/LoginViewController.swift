//
//  PinkViewController.swift
//  DesignLogin
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/23/22.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("login")
        
    }
    
    @IBAction func postsButton(_ sender: UIButton) {
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
    
    
    }
    
    @IBAction func postsAppButton(_ sender: UIButton) {
        print("go to app posts")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let postsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsAppViewController) as! PostsAppViewController
        self.view.window?.rootViewController = postsViewController
        self.view.window?.makeKeyAndVisible()
    
    }
   

}
