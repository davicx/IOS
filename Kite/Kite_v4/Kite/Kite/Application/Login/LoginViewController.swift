//
//  LoginViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonStyle: UIButton!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        userStatus()
   
    }
    
    @IBAction func loginButton(_ sender: Any) {
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let firebaseEmail = userName + "@kite.com"
        
        // Signing in the user
        Auth.auth().signIn(withEmail: firebaseEmail, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.loginErrorLabel.text = error!.localizedDescription
                self.loginErrorLabel.alpha = 1
            }
            else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
                /*
                let PostsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.postsViewController) as? PostsViewController
                
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
                 */
    
            }
        }
        
    }
    
    func setUpElements() {
        loginErrorLabel.alpha = 0
        Style.styleTextField(userNameTextField)
        Style.styleTextField(passwordTextField)
        Style.styleFilledButton(loginButtonStyle)
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
