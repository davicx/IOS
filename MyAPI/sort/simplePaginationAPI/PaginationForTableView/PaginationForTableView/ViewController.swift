//
//  ViewController.swift
//  PaginationForTableView
//
//  Created by David Vasquez on 6/28/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let postAPI = PostsAPI()
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [20]
    var postsArray = [PostModel(postID: 0, postCaption: "Start Here!")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(postsArray[indexPath.row].postID) \(postsArray[indexPath.row].postCaption)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postsArray.count - 1 {
            getMoreAPIData()
        }
    }
    
    func moreData() {
        for _ in 0...9 {
            data.append(data.last! + 1)
        }
        tableView.reloadData()
    }
    
    func getMoreAPIData() {
        
        Task{
            do{
                let returnedPostArray = try await postAPI.getPostsAPI()
                
                for post in returnedPostArray {
                    postsArray.append(post)
                    
                }

                self.tableView.reloadData()
                
            } catch{
                print("yo man error!")
                print(error)
            }
        }
    }


}

enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



/*
 //
 //  ViewController.swift
 //  mySimplePosts
 //
 //  Created by David on 7/7/24.
 //

 import UIKit


 class ViewController: UIViewController, InputDelegate {

     @IBOutlet weak var postTableView: UITableView!
     
     
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
         
         
         //TEMP
         for post in postsArray {
             printPostLikes(post: post)
             
         }
         //TEMP
         
         
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
