//
//  HomeViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/13/24.
//

import UIKit

class HomeViewController: UIViewController {
    var loggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleNotAuthenticated()
        

        
    }

    private func handleNotAuthenticated() {
        if(loggedIn) {
            print("Logged in")
        } else {
            let loginVC = LoginViewController ()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }


    }

    

}



/*
 let postAPI = PostsAPI()
 var postsArrayNoImage = [Post]()
 var postsArray = [Post]()
 
 var currentUser = "davey"
 
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     //addSubviews()
     view.backgroundColor = .systemBackground
     
     print("DAVID!!")
     
     Task{
         do{
             //Get Posts from the API
             let postsResponseModel = try await postAPI.getPostsAPI()
             
             //Add Post Images from S3
             postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
             //postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
             
             //self.postTableView.reloadData()
             for post in postsArrayNoImage {
                 let postCaption : String = post.postCaption ?? ""
                 print(postCaption)
             }
             
         } catch{
             print("yo man error!")
             print(error)
         }
         
     }
     
     
     

 
 */
