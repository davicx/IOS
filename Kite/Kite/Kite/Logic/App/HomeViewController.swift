//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit

class HomeViewController: UIViewController {
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    let userDefaultManager = UserDefaultManager()
    
    @IBOutlet weak var sayHiButtonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Temp.styleTextField(userNameTextField)
        Buttons.styleLoginFilledButton(sayHiButtonStyle)
        sayHiButtonStyle.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)

    }

    @IBAction func sayHiButton(_ sender: UIButton) {
        print("hi!")
    }
    
    @IBAction func getLoginStatusTemp(_ sender: UIButton) {
        let loginStatus = userDefaultManager.getLoggedInUserStatus()
        print("User is Logged in \(loginStatus)")
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let loggedInUser = userDefaultManager.getLoggedInUser()
        
        //STEP 1: Set User Defaults
        let loginOutcome = userDefaultManager.logUserOut()
        
        if(loginOutcome) {
            print("You just logged out")
        } else {
            print("Was an error logging out!")
        }
        
        //STEP 2: Call Logout API
        Task{
            do{
                let logoutResponseModel = try await loginAPI.logoutUser(username: loggedInUser)
                
                print(logoutResponseModel)
               
                if(logoutResponseModel.success == true) {
                    print("API Logout worked!")
           
                } else {
                    print("API Was an error logging out!")
                }
                
            } catch{
                print("yo man error!")
                print(error)
            }
        }
        
        //STEP 3: Navigate to Login Screen
        PresenterManager.shared.showOnboarding()
        
    }
    
}


//Get Posts
/*
Task{
    do{
        //Get Posts from the API
        let postResponseModel = try await postsAPI.getPostsAPI()
        print(postResponseModel.data[0].postCaption)
        
        
    } catch{
        print("yo man error!")
        print(error)
    }
}
 */

/*
 Task{
     do{
         //Get Posts from the API
         let loginResponseModel = try await loginAPI.loginUser(username: "davey", password: "password")
        
         //API
         if(loginResponseModel.data.loginSuccess == true) {
             
             //Local Storage
             let loginOutcome = userDefaultManager.logUserIn(userName: loggedInUser)
             
             if(loginOutcome) {
                 print("You just logged \(loggedInUser) in")
                 print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                 
             } else {
                 print("Was an error logging in!")
             }
             
             
         } else {
             print("API Was an error logging in!")
         }
         
     } catch{
         print("yo man error!")
         print(error)
     }
 }

 
 */
