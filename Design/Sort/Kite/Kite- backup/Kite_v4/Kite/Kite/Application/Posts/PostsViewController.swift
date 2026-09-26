//
//  PostsViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit
import Firebase

class PostsViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.helloLabel.text = "hiya!"
        userStatus()
    }

    
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("LOGOUT")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let LoginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! ViewController
            self.view.window?.rootViewController = LoginViewController
            self.view.window?.makeKeyAndVisible()

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            
        }
    }

    
    func userStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("Signed In! \(user.email!)")
            } else {
                print("ON POSTS")
                print("NOT Signed In!")

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let LoginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! ViewController
                self.view.window?.rootViewController = LoginViewController
                self.view.window?.makeKeyAndVisible()
            }
       }
    }
}

