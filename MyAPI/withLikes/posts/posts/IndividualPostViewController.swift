//
//  IndividualPostViewController.swift
//  posts
//
//  Created by David Vasquez on 8/23/24.
//

import UIKit


protocol InputDelegate {
    func userLikePost(currentPostID: Int)
    func userUnlikePost(currentPostID: Int)
}


class IndividualPostViewController: UIViewController {
    var myDelegate: InputDelegate? = nil
    let postAPI = PostsAPI()
    var selectedPost = Post(postID: 0)
    var currentUser = "davey"

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postLikeCountLabel: UILabel!
    @IBOutlet weak var postLikeButtonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView(selectedPost: selectedPost)
        
    }
    

    //SETUP: Setup the view
    func setUpView(selectedPost: Post) {
        let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
        let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
        postImage.image = selectedPost.postImageData
        postCaptionLabel.text = selectedPost.postCaption
        postLikeCountLabel.text = String(likeCount)

 
        //Like Button
        if simpleLikesArray.contains(currentUser) {
            //print("User has liked the post so text should be UNLIKE")
            let likedImage = UIImage(named: "liked")
            postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
          
        } else {
            print("User has NOT liked the post so text should be LIKE")
            let likedImage = UIImage(named: "like")
            postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
          
        }
        

    }


    @IBAction func postLikeButton(_ sender: UIButton) {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center;
        view.addSubview(activityIndicator);
        
        
        //STEP 1: Determine if Post is Already Liked
        let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
        let groupID : Int = selectedPost.groupID ?? 0
        
        //STEP 2A: Make Call to API to Like a Post
        if !simpleLikesArray.contains(currentUser) {
            //print("Like Me")
            Task{
                //activityIndicator.startAnimating()
                do{
                    let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                    
                    //Success
                    if(likePostResponseModel.success == true) {
                        //flipButton(withString: "", on: sender)
                        postLikeCountLabel.text = String(simpleLikesArray.count + 1)
                        let likedImage = UIImage(named: "liked")
                        postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                        postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                      
                        
                        if (myDelegate != nil) {
                            print("DELEGATE: Individual Post VC You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                            myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                        }
                        
                        //Error: Handled by API
                    } else {
                        print("error dudee!")
                        
                    }
                    
                    //Error: Not expected
                } catch{
                    print("yo man error!")
                    print(error)
                }
            }
        
        //STEP 2B: Make Call to API to Unlike a Post
        } else {
            //print("Already Liked")
            Task{
                do{
                    let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                    
                    //Success
                    if(unlikePostResponseModel.success == true) {
                        
                        postLikeCountLabel.text = String(simpleLikesArray.count - 1)
                        let likedImage = UIImage(named: "like")
                        postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                        postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                      
                        if (myDelegate != nil) {
                            print("DELEGATE: Individual Post VC You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                            myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                        }
                        
                    //Error: Handled by API
                    } else {
                        print("error dudee!")
                        
                    }
         
                //Error: Not expected
                } catch {
                    
                    print("yo man error!")
                    print(error)
                }
            }

        }
        
    }
    
   
}

/*
 @IBOutlet weak var startLabel: UILabel!
 var activityIndicator = UIActivityIndicatorView()

 
 override func viewDidLoad() {
     super.viewDidLoad()
     activityIndicator.center = self.view.center
     activityIndicator.hidesWhenStopped = true
     activityIndicator.style = UIActivityIndicatorView.Style.medium
     self.view.addSubview(activityIndicator)
     
     
 }


 @IBAction func startButton(_ sender: UIButton) {
     print("start")
     activityIndicator.startAnimating()
     startLabel.text = "Getting some posts man!"
     view.isUserInteractionEnabled = false
     
     Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
         self.activityIndicator.stopAnimating()
         self.view.isUserInteractionEnabled = true
         self.startLabel.text = "Got them posts dude!"
     }
 }
 

 // Optionally disable specific controls like buttons
 //actionButton.isEnabled = false


 @IBAction func stopButton(_ sender: UIButton) {
     print("stop")
     startLabel.text = "I am Stopped"
     activityIndicator.stopAnimating()

 }
 
 */


/*

 import UIKit

 protocol InputDelegate {
     func userLikePost(currentPostID: Int)
     func userUnlikePost(currentPostID: Int)
 }


 class IndividualPostViewController: UIViewController {
     var myDelegate: InputDelegate? = nil
     
     let postAPI = PostsAPI()
     var selectedPost = Post(postID: 0)
     var currentUser = "davey"

     @IBOutlet weak var singlePostImageView: UIImageView!
     @IBOutlet weak var singlePostLabel: UILabel!
     @IBOutlet weak var likeCountLabel: UILabel!
     @IBOutlet weak var likeButtonTextOutlet: UIButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setUpView(selectedPost: selectedPost)
         
     }
     
     @IBAction func likePostButton(_ sender: UIButton) {
         
         //STEP 1: Determine if Post is Already Liked
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         let groupID : Int = selectedPost.groupID ?? 0
         
         //STEP 2A: Make Call to API to Like a Post
         if !simpleLikesArray.contains(currentUser) {
             Task{
                 do{
                     let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
     
                     //Success
                     if(likePostResponseModel.success == true) {
                         flipButton(withString: "", on: sender)
                         likeCountLabel.text = String(simpleLikesArray.count + 1)
                         
                         if (myDelegate != nil) {
                             print("You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                         }
                         
                     //Error: Handled by API
                     } else {
                         print("error dudee!")
                         
                     }
                 
                 //Error: Not expected
                 } catch{
                     print("yo man error!")
                     print(error)
                 }
             }
         
         //STEP 2B: Make Call to API to Unlike a Post
         } else {
             Task{
                 do{
                     let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                     
                     //Success
                     if(unlikePostResponseModel.success == true) {
                         
                         likeCountLabel.text = String(simpleLikesArray.count - 1)
       
                         if (myDelegate != nil) {
                             print("You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                         }
                         
                     //Error: Handled by API
                     } else {
                         print("error dudee!")
                         
                     }
          
                 //Error: Not expected
                 } catch{
                     print("yo man error!")
                     print(error)
                 }
             }

         }
     }
     

     //BUTTON: Handle Button UI Change
     func flipButton(withString addFriend: String, on button: UIButton) {
         if button.currentTitle == "Like" {
             button.setTitle("UnLike", for: UIControl.State.normal)
         } else {
             button.setTitle("Like", for: UIControl.State.normal)
         }
     }
     

     //SETUP: Setup the view
     func setUpView(selectedPost: Post) {
         let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         //print("LIKES \(simpleLikesArray.count)")
         
         //SETUP: Set Like Text on the Button for Like or Unlike
         if simpleLikesArray.contains(currentUser) {
             //print("User has liked the post so text should be UNLIKE")
             likeButtonTextOutlet.setTitle("Unlike", for: .normal)
         } else {
             //print("User has NOT liked the post so text should be LIKE")
             likeButtonTextOutlet.setTitle("Like", for: .normal)
         }
         
         singlePostImageView.image = selectedPost.postImageData
         singlePostLabel.text = selectedPost.postCaption
         likeCountLabel.text = String(likeCount)
     }
     
 }





 //NOTES
 /*
 //This will be used inside the above call to like or unlike
 if (myDelegate != nil) {
     print("IN SECOND CONTROLLER: In Delegate")
     myDelegate!.userLikePost(currentPostID: selectedPost.postID)
 }
  */

 */
