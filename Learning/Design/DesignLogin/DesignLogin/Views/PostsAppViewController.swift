//
//  PostsAppViewController.swift
//  DesignLogin
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/23/22.
//

import UIKit

class PostsAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutAppButton(_ sender: UIButton) {
        print("logout")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let greenViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.greenViewController) as! GreenViewController
        self.view.window?.rootViewController = greenViewController
        self.view.window?.makeKeyAndVisible()
    }
  
    

}
