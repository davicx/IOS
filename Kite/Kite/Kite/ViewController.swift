//
//  ViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/14/24.
//

import UIKit

class ViewController: UIViewController {

    let postsAPI = PostsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        /*
         Task{
             do{
                 //Get Posts from the API
                 let loginResponseModel = try await loginAPI.loginUser(username: username, password: password)
                 print(loginResponseModel)
                 
                 if(loginResponseModel.data.loginSuccess == true) {
                     dismiss(animated: true, completion: nil)
                 } else {
                     let message = loginResponseModel.message
                     let alert = UIAlertController(title: "Log In Error", message: message, preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                     present (alert, animated: true)
                 }
                 
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
         */

        
        print("hi!")
    }


}

