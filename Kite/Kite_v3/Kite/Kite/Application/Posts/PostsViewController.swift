//
//  PostsViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit
import Firebase

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("hi")
        
        Auth.auth().addStateDidChangeListener { auth, user in
        if let user = user {
            let email = user.email
            print("Signed In! \(email)")
        } else {
            print("NOT Signed In!")
        }
       }
    }
    

    
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
    
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }


}
