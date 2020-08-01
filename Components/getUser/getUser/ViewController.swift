//
//  ViewController.swift
//  getUser
//
//  Created by David Vasquez on 5/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    //Create the Logged in User
    var loggedInUser = User(userID: 0)
    var tempUser = User(userID: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getUserButton(_ sender: Any) {
        getCurrentUser { returnedUserObject, error in
            DispatchQueue.main.async {
                self.loggedInUser.firstName = returnedUserObject.firstName
                self.loggedInUser.lastName = returnedUserObject.lastName
                self.loggedInUser.userImage = returnedUserObject.lastName
            }
        }
    }

    @IBAction func printUserInfo(_ sender: Any) {
        print("Current User \(loggedInUser.firstName) \(loggedInUser.lastName)")
        print("Temp User \(tempUser.firstName) \(tempUser.lastName)")
        
    }
    
    @IBAction func setUser(_ sender: Any) {
        setCurrentUser()
        
    }
    
    
    
    
    //FUNCTION: Get User Info (Trigger through a Button)
    func getCurrentUser(completionHandler:@escaping (User, Error?)->Void ) {
        
        //Get JSON
        let urlString = "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/user.php"
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let returned_user_array = try decoder.decode(UserModel.self, from: data!)
                    
                    //Create a User Object to Return
                    let innerTempUserObject = User(userID: 0)
                    
                    innerTempUserObject.firstName = returned_user_array.first_name
                    innerTempUserObject.lastName = returned_user_array.last_name
                    innerTempUserObject.userImage = returned_user_array.user_image
                   
                    //Can also just set inside here
                    self.tempUser.firstName = returned_user_array.first_name
                    self.tempUser.lastName = returned_user_array.last_name
                    completionHandler(innerTempUserObject, nil)
                    
                } catch {
                    print("Error in JSON Parsing")
                    //completionHandler(nil, error)
                }
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
    //FUNCTION: Set User Info on Page Load
    func setCurrentUser() {
        let urlString = "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/user.php"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let returned_user_array = try decoder.decode(UserModel.self, from: data!)
                    
                    //print("Inside Do: \(currentUsersArray.first_name)")
                    DispatchQueue.main.async {
                        
                        //USER: Set Name and Username
                        self.userName.text = ("\(returned_user_array.first_name) \(returned_user_array.last_name)")
                        self.loggedInUser.firstName = returned_user_array.first_name
                        self.loggedInUser.lastName = returned_user_array.last_name
                        
                        //USER: Set User Image
                        let baseURL = ""
                        let urlKey = returned_user_array.user_image
                        
                        //Load Image
                        if let url = URL(string: urlKey) {
                            do {
                                let data = try Data(contentsOf: url)
                                self.userImage.image = UIImage(data: data)
                                
                            } catch let err {
                                print("error ", err)
                                
                            }
                        }
                    }
                    
                } catch {
                    print("Error in JSON Parsing")
                }
            }
        }
        dataTask.resume()
    }
}
