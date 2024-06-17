//
//  ProfileViewController.swift
//  DesignStoryboards
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/22/22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func HomeButton(_ sender: UIButton) {
        print("hi")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        self.view.window?.rootViewController = HomeViewController
        self.view.window?.makeKeyAndVisible()
        
        /*
        let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
        let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
        self.view.window?.rootViewController = PostsViewController
        self.view.window?.makeKeyAndVisible()
        */
        
    }


}
