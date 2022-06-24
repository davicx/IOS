//
//  PostsViewController.swift
//  DesignLogin
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/23/22.
//

import UIKit

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hiya!")
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //let greenViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.greenViewController) as! GreenViewController
        //self.view.window?.rootViewController = greenViewController
        //self.view.window?.makeKeyAndVisible()
        
        //let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc: GreenViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.greenViewController) as! GreenViewController
        //self.present(vc, animated: true, completion: nil)
        
        //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("YourViewController") as! YourViewController
        //let navigationController = UINavigationController(rootViewController: vc)
        //self.presentViewController(navigationController, animated: true, completion: nil)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.Storyboard.greenViewController) as? GreenViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //THiS? self.present(homeView, animated: true, completion: nil)
    
    }
    
}
