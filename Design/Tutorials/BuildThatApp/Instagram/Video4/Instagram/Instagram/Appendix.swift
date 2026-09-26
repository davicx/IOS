/*
  guard let username = usernameEmailField.text, username.isEmpty,
       let password = passwordfield.text, !password.isEmpty, password.count >= 2 else {
     print("error")
     return
 }

 
 
 //
 //  ViewController.swift
 //  posts
 //
 //  Created by David Vasquez on 8/22/24.
 //

 import UIKit

 class ViewController: UIViewController, InputDelegate {
     
     let postAPI = PostsAPI()
     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()
     
     var currentUser = "davey"
     var tempLikes = ["sam", "merry"]
     
     //UI: New Post
     @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var newPostUserImage: UIImageView!
     @IBOutlet weak var newPostCaptionLabel: UITextField!
     @IBOutlet weak var newPostButtonStyle: UIButton!
     
     //DELEGATE FUNCTIONS
     //Function D1: Like a Post
     func userLikePost(currentUser: String) {
         print("YOOO Liked update the MAIN VIEW MA MAN \(currentUser)")
         tempLikes.append(currentUser)
     }
     
     
     
     //MAIN VIEW
     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.rowHeight = 320;
         
         
         setUpView()
         
         Task{
             do{
                 //Get Posts from the API
                 let postsResponseModel = try await postAPI.getPostsAPI()
                 
                 //Add Post Images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                 
                 //self.postTableView.reloadData()
                 let postCaption : String = postsArray[0].postCaption ?? ""
                 tableView.reloadData()
                 print(postCaption)
                 
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
         
         tableView.delegate = self
         tableView.dataSource = self
         
         
     }
     
     func setUpView() {
         newPostUserImage.image = UIImage(named: "david")
     }
     
     
     //PAGE RELOAD
     override func viewDidAppear(_ animated: Bool) {
         print("were back to the main posts list page, here mah dude!")
         print("POST LIKES")
         
         for user in tempLikes {
             print(user)
         }
     }

     
     
     
     //NEW POST
     @IBAction func newPostButton(_ sender: UIButton) {
         let postCaption : String = newPostCaptionLabel?.text ?? ""
         print("New Post! \(postCaption)")
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
         //return tempUsers.count
         return postsArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         //let currentPost = tempUsers[indexPath.row]
         //let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
         //cell.postCaptionLabel.text = "currentPost"
         //cell.setPost(currentPost: "hi")
      
         
         let currentPost = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
         
         cell.setPost(post: currentPost)

         return cell

     }
     
     //DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //let post = tempUsers[indexPath.row]
         //self.performSegue(withIdentifier: "showIndividualPost", sender: self)
         
         let post = postsArray[indexPath.row]
         currentPost = post
         
         self.performSegue(withIdentifier: "showIndividualPost", sender: self)
     }

 }


 //SEGUES
 //showIndividualPost this connects the two screens



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
