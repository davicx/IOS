//
//  FakeViewController.swift
//  Kite
//
//  Created by Syngenta on 11/8/21.
//

import UIKit
import Firebase

class FakeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("FAKE")
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("Signed In! \(user.email!)")
            } else {
                print("NOT Signed In!")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let LoginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! ViewController
                self.view.window?.rootViewController = LoginViewController
                self.view.window?.makeKeyAndVisible()

            }
       }
    }
    

}
