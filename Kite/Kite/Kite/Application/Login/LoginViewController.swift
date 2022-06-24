//
//  LoginViewController.swift
//  Kite
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/15/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        userStatus()
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        //Validate Fields
        //Sign In
        let userName = userNameTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let firebaseEmail = userName + "@kite.com"
        let firebaseEmail = userName + "@gmail.com"

        // Signing in the user
        Auth.auth().signIn(withEmail: firebaseEmail, password: password) { (result, error) in
            if error != nil {
                print("couldn't sign in")
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.transitionToHome()
                //ACTUAL Go to Storyboard
                //let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                //let HomeViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
                //self.view.window?.rootViewController = HomeViewController
                //self.view.window?.makeKeyAndVisible()
    
            }
        }
        
        
        
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(userNameTextInput)
        Utilities.styleTextField(passwordTextInput)
    }
    
    
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func userStatus(){
        //var userName = "null"
        //var email = "null"
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("SIGNED In!")
                //email = user.email!
                //userName = email
                //print("Signed In! \(email)")
                //let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                //let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
                //self.view.window?.rootViewController = PostsViewController
                //self.view.window?.makeKeyAndVisible()
            } else {
                print("NOT Signed In!")
            }
       }
    }


}



//
//  LoginViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

/*
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
                self.loginErrorLabel.text = error!.localizedDescription
                self.loginErrorLabel.alpha = 1
            }
            else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
                let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
                self.view.window?.rootViewController = PostsViewController
                self.view.window?.makeKeyAndVisible()
    
            }
        }
        
    }
    
    @IBAction func postsButtonTemp(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Posts", bundle:nil)
        let PostsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.postsViewController) as! PostsViewController
        self.view.window?.rootViewController = PostsViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    
    func setUpElements() {
        loginErrorLabel.alpha = 0
        Style.styleTextField(userNameTextField)
        Style.styleTextField(passwordTextField)
        Style.styleFilledButton(loginButtonStyle)
    }

    func userStatus(){
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
            } else {
                print("NOT Signed In!")
            }
       }
    }


}
*/
