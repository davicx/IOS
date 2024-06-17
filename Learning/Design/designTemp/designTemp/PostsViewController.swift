//
//  PostsViewController.swift
//  designTemp
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/27/22.
//

import UIKit

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(identifier: "VC") as? ViewController
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
