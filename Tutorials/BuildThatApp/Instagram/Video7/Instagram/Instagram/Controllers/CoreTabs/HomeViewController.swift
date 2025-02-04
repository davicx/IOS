//
//  HomeViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/13/24.
//

import UIKit



class HomeViewController: UIViewController {
    var loggedIn = true
    let postAPI = PostsAPI()
    let postImage: UIImage = UIImage(named: "background_1")!
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: "IGFeedPostTableViewCell")

        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded Home Controller")
        
        
        //TEMP Create new Post
        Task{
            do{
                //Photo Post
                let newPostResponseModel = try await postAPI.makePhotoPost(postImage: postImage, postFrom: "frodo", postTo: "Davey", postCaption: "Hiya!! did this work from the new cool!!", groupID: 72, listID: 0)
                
            
                //Post Text
                //let newPostResponseModel = try await postAPI.makeTextPost(postImage: postImage, postFrom: "frodo", postTo: "Davey", postCaption: "Hiya!! did this work from the new cool!!", groupID: 72, listID: 0)
                
                
                print(newPostResponseModel)
                
                
                //Add Post Images from S3
                //postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                //postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                
                //self.postTableView.reloadData()
                
            } catch{
                print("yo man error!")
                print(error)
            }
        }
        
        
        handleNotAuthenticated()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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



extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IGFeedPostTableViewCell", for: indexPath) as! IGFeedPostTableViewCell
        
        return cell
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
     
     
     

 
 
 //
 //
 //
 //
 //
 //  ViewController.swift
 //  mySimplePosts
 //
 //  Created by David on 7/7/24.
 //

 import UIKit

 //UNIQUE IDENTIFIERS
 //PostCell
 //showIndividualPost

 class ViewController: UIViewController, InputDelegate {

     @IBOutlet weak var postTableView: UITableView!
     
     let postAPI = PostsAPI()
     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()
     
     var currentUser = "davey"
     
     //DELEGATE FUNCTIONS
     //Function D1: Like a Post
     func userLikePost(currentPostID: Int) {
         print("YOOO Liked update the MAIN VIEW MA MAN \(currentPostID)")
         for post in postsArray {
             if(post.postID == currentPostID) {
                 post.simpleLikesArray?.append(currentUser)
             }
         }
     }
     
     //Function D2: UnlikePost
     func userUnlikePost(currentPostID: Int) {
         print("YOOO Un like me dude update the MAIN VIEW MA MAN \(currentPostID)")
         for post in postsArray {
             if(post.postID == currentPostID) {
                 if let index = post.simpleLikesArray!.firstIndex(of: "davey") {
                     post.simpleLikesArray?.remove(at: index)
                 }
             }
         }
     }
     
     //VIEW LOAD
     override func viewDidLoad() {
         super.viewDidLoad()
         self.postTableView.rowHeight = 220;
         

         Task{
             do{
                 //Get Posts from the API
                 let postsResponseModel = try await postAPI.getPostsAPI()
                 
                 //Add Post Images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                 
                 self.postTableView.reloadData()
                 
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
     
         
         postTableView.delegate = self
         postTableView.dataSource = self
         
    }
     
     override func viewDidAppear(_ animated: Bool) {
         print("were back to the main posts list page, here mah dude!")
         print("POST LIKES")
         
         for post in postsArray {
             printPostLikes(post: post)
         }
     }

     
     //DATA SEND: Send Data to New Cell
     var currentPost:Post!

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let secondController = segue.destination as! IndividualPostViewController
         secondController.selectedPost = currentPost
         secondController.myDelegate = self
         
     }

 }



 extension ViewController: UITableViewDataSource, UITableViewDelegate {
     
     //SETUP: Set up table and rows
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let currentPost = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
         
         cell.setPost(post: currentPost)
         
         return cell

     }
     
     //DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         currentPost = post
   
         self.performSegue(withIdentifier: "showIndividualPost", sender: self)
     }

 }

 enum networkError: Error {
     case invalidURL
     case invalidResponse
     case invalidData
 }


 */
