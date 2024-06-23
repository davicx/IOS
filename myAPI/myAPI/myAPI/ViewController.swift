//
//  ViewController.swift
//  myAPI
//
//  Created by David on 6/22/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    let postAPI = PostAPI()


    override func viewDidLoad() {
        super.viewDidLoad()
        //getPostsAPIButton()
        //getImage()
  
        
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        print("Login")
        loginUser()
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        print("getButton")
        //getAPIButton()
        getPostsAPI()
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        print("postButton")
        postAPIButton()

    }
    
    
    //FUNCTIONS
    func getPostsAPI() {
        postAPI.getGroupPosts {(postResponseModel, error) -> (Void) in
            if let error = error {
                self.postCaption.text = "there was an error!"
            }
            
            if let posts = postResponseModel {
                //Loop over posts and get image and post data here!!
                self.getImage()
                self.postCaption.text = posts.data[0].postCaption
                
            }
            //getImage()
        }
        
    }
    
    func getImage() {
        postAPI.getImage { (data, error)  in
          if let error = error {
            print(error)
            return
          }
          
          self.imageView.image = UIImage(data: data!)
        }
    }
    
    
    /*
     @IBAction func randomButton(_ sender: UIButton) {
         //simpleThree()
         
         networker.getQuote {(kanye, error) -> (Void) in
             if let error = error {
                 self.label.text = "there was an error!"
             }
             
             self.label.text = kanye?.quote
         }
         
         networker.getImage { (data, error)  in
           if let error = error {
             print(error)
             return
           }
           
           self.imageView.image = UIImage(data: data!)
         }
     }
     */
     
    
    
   //Function: Get API Button
   func getAPIButton() {
       guard let url = URL(string: "http://localhost:3003/posts/group/70") else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       //guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
       //request.httpBody = httpBody
       
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
           if let data = data {
               do {
                   
                   let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                   let posts = postResponse.data
                   //print("\(friendResponse.request_to) \(friendResponse.request_from)")
                   //print(PostResponseModel.data.loggedInUser)
                   print(postResponse.message)
                   //print("\(friendResponse.request_from)")
                   for post in posts {
                       print(post.postCaption)
                   }
                   print(posts[0].postCaption)
                   //completionHandler(postModelArray, nil)
                   
               } catch {
                   print(error)
               }
           }
           
           }.resume()
   }
   
   
   func postAPIButton() {
       
   }
    
    
    //Login User
    func loginUser() {
        print("Yo! POST!")
        let parameters = ["userName": "davey", "password": "password"]

        
        guard let url = URL(string: "http://localhost:3003/user/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    //print("\(friendResponse.request_to) \(friendResponse.request_from)")
                    print(loginResponse.data.loggedInUser)
                    print(loginResponse.message)
                    //print("\(friendResponse.request_from)")
                    
                    //completionHandler(postModelArray, nil)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}

