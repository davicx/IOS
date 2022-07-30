//
//  ViewController.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/21/22.
//

import UIKit


struct Posts: Codable {
    let posts: [PostModel]
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        //makePost(postCaption: "hiya there!")
        //getPosts()
        getPostsGET()
    }

    
    //Function 2: Make Simple Post (POST)
    func makePost(postCaption: String){
        let token = "myToken!!"
        
        let parameters = [
            "postFrom": "davey",
            "postTo": "sam",
            "postCaption": postCaption
        ]
        
        guard let url = URL(string: "http://localhost:3003/post/text") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                    print(postResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
         
    }
    
    

    //Function 1: Get Simple Posts (GET)
    func getPosts() {
        let urlString = "http://localhost:3003/posts/simple"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            /*
            let username = "username"
            let password = "password"
            let loginString = "\(username):\(password)"

            guard let loginData = loginString.data(using: String.Encoding.utf8) else {
                return
            }
            let base64LoginString = loginData.base64EncodedString()

            request.httpMethod = "GET"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            */
            
            //Parse JSON
            if error == nil && data != nil {
                //let decoder = JSONDecoder()

                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(Posts.self, from: data!)
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                    //print(postArray[0].userName)
                    //print(postArray[1])
                    //let posts = try JSONDecoder().decode(posts.self, from: data!)
                    //let postArray = posts[post]
                    //print(posts)
             
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }
        dataTask.resume()
    }
    
    
    func getPostsGET() {
        let token = "myToken!!"
        let urlString = "http://localhost:3003/posts/simple"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
       
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(Posts.self, from: data)
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }.resume()
    }


}








/*
//
//  ViewController.swift
//  learningJSON
//
//  Created by David Vasquez on 5/16/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//
//https://jsonplaceholder.typicode.com/posts

import Foundation

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Parse JSON
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    //let postList = try decoder.decode(PostModel.self, from: data!)
                    let postList = try JSONDecoder().decode([PostModel].self, from: data!)
                    print(postList[0])
                    print(postList[1])

                } catch {
                    print("Error Parsing JSON")
                    
                }
                

            }
            
        }
        dataTask.resume()
    }
}

*/


//
//  ViewController.swift
//  getUser
//
//  Created by David Vasquez on 5/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
/*
import UIKit

import Foundation

class User {
    var userID:Int?
    var firstName = ""
    var lastName = ""
    var city = ""
    var userImage = ""
    
    init(userID: Int) {
        self.userID = userID
    }
    
}

import Foundation





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
                        let baseURL = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/user_image/"
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
*/
