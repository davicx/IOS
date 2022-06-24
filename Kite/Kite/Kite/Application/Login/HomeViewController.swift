//
//  HomeViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutButton(_ sender: Any) {
        print("logout")
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
    
    
}


/*
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
            print("NOT Signed In!")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let LoginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! ViewController
            self.view.window?.rootViewController = LoginViewController
            self.view.window?.makeKeyAndVisible()
        }
   }
}
*/
