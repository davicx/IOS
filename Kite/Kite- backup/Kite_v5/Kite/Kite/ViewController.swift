//
//  ViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var loginStyle: UIButton!
    @IBOutlet weak var signUpStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStatus()
        setUpElements()
    }

    func setUpElements() {
        Style.styleHollowButton(loginStyle)
        Style.styleFilledButton(signUpStyle)
    }

    
    func userStatus() -> String {
        var userName = "null"
        var email = "null"
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                email = user.email!
                userName = email
                print("Signed In! \(email)")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
                
                //self.present(PostsViewController, animated:true, completion:nil)
                /*
                let PostsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.postsViewController) as? PostsViewController
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
                */
                
            } else {
                print("NOT Signed In!")

            }
       }
        
        return userName
    }

}

