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
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("Signed In! \(user.email!)")
                //let PostsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.postsViewController) as? PostsViewController
                
                //self.view.window?.rootViewController = PostsViewController
                //self.view.window?.makeKeyAndVisible()
            } else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let LoginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! ViewController
                self.view.window?.rootViewController = LoginViewController
                self.view.window?.makeKeyAndVisible()
                
                /*
                print("NOT Signed In!")
                let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
                
                self.view.window?.rootViewController = LoginViewController
                self.view.window?.makeKeyAndVisible()
                */
            }
       }

    }

    
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("LOGOUT")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            
        }

    
    func userStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("Signed In! \(user.email!)")
                let PostsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.postsViewController) as? PostsViewController
                
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                print("NOT Signed In!")
                let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
                
                self.view.window?.rootViewController = LoginViewController
                self.view.window?.makeKeyAndVisible()
            }
       }

    }

    }
}


/*
Auth.auth().addStateDidChangeListener { auth, user in
    if let user = user {
        let email = user.email
        print("Signed In! \(email)")
    } else {
        print("NOT Signed In!")
    }
}
 */

/*
 FIRAuth.auth()?.addStateDidChangeListener { auth, user in
   if let user = user {
     // User is signed in. Show home screen
   } else {
     // No User is signed in. Show user the login screen
   }
 }
 let handle = Auth.auth().addStateDidChangeListener { auth, user in
 if let user = user {
   // User is signed in. Show home screen
 } else {
   // No User is signed in. Show user the login screen
 }
}
*/
