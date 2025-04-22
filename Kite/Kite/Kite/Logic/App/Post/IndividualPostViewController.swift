//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


//protocol LikePostDelegate: AnyObject {

protocol LikePostDelegate {
    func userLikePost(currentPostID: Int, likeModel: LikeModel)
    func userUnlikePost(currentPostID: Int, likeModel: LikeModel)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    //let currentUser = UserDefaultManager().getLoggedInUser()

    var likePostDelegate: LikePostDelegate? = nil
    var currentPost: Post!
    
    //STEP 1: Set up UI Elements
    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let likeStackView = UIStackView()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        setInitialUI()

    }
    
    
    func setUpViews() {
        guard let currentPost = currentPost else { return }
        //var postLikedByCurrentUser : Bool = currentPost.isLikedByCurrentUser ?? false
        //var likeCount : Int = currentPost.simpleLikesArray?.count ?? 0
        //var simpleLikesArray : Array = currentPost.simpleLikesArray ?? []

        // Image View
        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postImage)
        
        // Caption Label
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.font = UIFont.systemFont(ofSize: 16)
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCaptionLabel)

        //Like Button
        let imageName = currentPost.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        // Like Count Label
        likeCountLabel.text = "0" // Default value
        likeCountLabel.font = UIFont.systemFont(ofSize: 18)
        likeCountLabel.textAlignment = .center
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        likeStackView.axis = .horizontal
        likeStackView.distribution = .fillEqually
        likeStackView.spacing = 8
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.addArrangedSubview(likeCountLabel)
        likeStackView.addArrangedSubview(likeButton)
        view.addSubview(likeStackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),
            
            likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
            likeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            likeStackView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        activityIndicator.center = view.center;
        view.addSubview(activityIndicator);
        
    }
    
    
    func setInitialUI() {
        if let selectedPost = currentPost {
            postImage.image = selectedPost.postImageData ?? UIImage(named: "background_10")
            postCaptionLabel.text = selectedPost.postCaption
            let currentLikeCount = selectedPost.simpleLikesArray?.count ?? 0
            likeCountLabel.text = "\(currentLikeCount)"
        } else {
            print("Error: currentPost is nil")
        }
    }
    
    //NEW
    /*
     @IBAction func likeButtonTapped(_ sender: UIButton) {
         guard let post = currentPost else {
             print("Error: currentPost is nil")
             return
         }

         let groupID: Int = post.groupID ?? 0

         // TODO: Replace this with call to handleLike / handleUnlike for better readability
         if post.isLikedByCurrentUser {
             handleUnlike(post, groupID: groupID)
         } else {
             handleLike(post, groupID: groupID)
         }
     }
     */
    //NEW
    

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let post = currentPost else {
            print("Error: currentPost is nil")
            return
        }

        let groupID: Int = post.groupID ?? 0

        if post.isLikedByCurrentUser == true {
            handleUnlike(post: post, groupID: groupID)
        } else {
            handleLike(post: post, groupID: groupID)
        }
        
        /*
        //UNLIKE
        if post.isLikedByCurrentUser == true {
           
                 
            
        //LIKE
        } else {


            
        }
         */

    }
    
    func handleUnlike(post: Post, groupID: Int) {
        print("UNLIKE API \(post.isLikedByCurrentUser)")
        Task{
            do{
                
                //STEP 1: Call API
                let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                //Success
                if(unlikePostResponseModel.success == true) {
                    print("SUCCESS: unlikePostResponseModel")
                    
                    let newLike = unlikePostResponseModel.data
          
                    // STEP 2: Update Current Post Values to remove like
                    post.isLikedByCurrentUser = false

                    // Remove LikeModel with matching postLikeID
                    let likeIDToRemove = newLike.postLikeID
                    post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeIDToRemove }
                    
                    // Remove username from simpleLikesArray
                    let currentUsername = unlikePostResponseModel.currentUser
                    post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != currentUsername }
                    
                    DispatchQueue.main.async {
                        self.toggleLikeUI()
                    }
                    
                //Error: Handled by API
                } else {
                    print("NOT SUCCESS: unlikePostResponseModel")
                    print(unlikePostResponseModel.data)
        
                }
     
            //Error: Not expected
            } catch {
                print("yo man error!")
                print(error)
            }
        }
    }

    
    func handleLike(post: Post, groupID: Int) {
        print("LIKE API \(post.isLikedByCurrentUser)")
        
        Task{
            //activityIndicator.startAnimating()
            //likeButton.isEnabled = false // Prevent rapid tapping
            do{
                //STEP 1: Call API
                let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                
                if(likePostResponseModel.success == true) {
  
                    let newLike = likePostResponseModel.data
                    
                    //STEP 2: Update Current Post Values to add like
                    post.isLikedByCurrentUser = true
                    post.postLikesArray?.append(newLike)
                    post.simpleLikesArray?.append(newLike.likedByUserName)
                    
                    DispatchQueue.main.async {
                        //self.activityIndicator.stopAnimating()
                        //likeButton.isEnabled = true
                        self.toggleLikeUI()
                    }
                    

                } else {
                    print(likePostResponseModel)
                    print("error dudee!")
                    
                }
                
                //Error: Not expected
            } catch{
                print("yo man error!")
                print(error)
            }
        }
    }




    /*
    //NEW
    func handleUnlike(_ post: Post, groupID: Int) {
        Task {
            do {
                let response = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)
                
                guard response.success else {
                    print("UNLIKE NOT SUCCESS:", response.data)
                    return
                }

                let newLike = LikeModel.from(data: response.data)
                post.isLikedByCurrentUser = false
                post.postLikesArray?.removeAll { $0.postLikeID == newLike.postLikeID }
                post.simpleLikesArray?.removeAll { $0 == response.currentUser }

                DispatchQueue.main.async { self.toggleLikeUI() }

                // Optional: notify delegate
                likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: newLike)

            } catch {
                print("yo man error!")
                print(error)
            }
        }
    }

    //NEW
    //NEW
    // TODO: Extract this whole block into handleLike(post: Post, groupID: Int)
     func handleUnlike(post: Post, groupID: Int)
        Task {
            do {
                let response = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)

                guard response.success else {
                    print("LIKE NOT SUCCESS:", response.data)
                    return
                }

                let newLike = LikeModel.from(data: response.data)
                post.isLikedByCurrentUser = true
                post.postLikesArray?.append(newLike)
                post.simpleLikesArray?.append(newLike.likedByUserName)

                DispatchQueue.main.async { self.toggleLikeUI() }

                // Optional: notify delegate
                likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: newLike)

            } catch {
                print("yo man error!")
                print(error)
            }
        }
    }

    //NEW
    
    */
    func toggleLikeUI() {
        guard let post = currentPost else { return }

        // Determine new like count
        var likeCount = String(post.simpleLikesArray?.count ?? 0)
        
        if post.isLikedByCurrentUser == true {
            likeCountLabel.text = likeCount
            likeButton.setImage(UIImage(named: "liked"), for: .normal)
        } else {
            likeCountLabel.text = likeCount
            likeButton.setImage(UIImage(named: "like"), for: .normal)
        }

    }
    
}







//print("")
//print(post.isLikedByCurrentUser)
//print(post.simpleLikesArray)
//print(post.postLikesArray)
//print("")

/*
guard let post = self.post else { return }

let isLiked = post.isLikedByCurrentUser ?? false
let likeImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
likeButton.setImage(likeImage, for: .normal)
likeButton.tintColor = isLiked ? .systemRed : .gray

likeCountLabel.text = "\(post.postLikesArray?.count ?? 0)"
 */



/*
@IBAction func likeButtonTapped(_ sender: UIButton) {
    guard let post = currentPost else {
        print("Error: currentPost is nil")
        return
    }
    
    let groupID : Int = post.groupID ?? 0
    //likeButton.isEnabled = false // Prevent rapid tapping

    if post.isLikedByCurrentUser == true {
        
        // UNLIKE API CALL
        print("UNLIKE API \(post.isLikedByCurrentUser)")
    
        
        post.isLikedByCurrentUser = false
        
        
    } else {
        
        // LIKE API CALL
        print("LIKE API \(post.isLikedByCurrentUser)")
        
        post.isLikedByCurrentUser = true
    }
    
    //print(post.simpleLikesArray)
    print(" isLikedByCurrentUser \(post.isLikedByCurrentUser)")
    //print(post.postLikesArray)
}
*/


/*
 
 @objc func likeButtonTappedVersionTWO() {
     let activityIndicator = UIActivityIndicatorView(style: .large)
     activityIndicator.center = view.center;
     view.addSubview(activityIndicator);
     
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     //STEP 1: Determine if Post is Already Liked
     let simpleLikesArray : Array = post.simpleLikesArray ?? []
     post.isLikedByCurrentUser = !(post.isLikedByCurrentUser ?? false)
     let groupID : Int = post.groupID ?? 0
     
     
     //STEP 2: Make Call to API to Like a Post
     if !simpleLikesArray.contains(currentUser) {
         print("Like Me")
         Task{
             //activityIndicator.startAnimating()
             do{
                 //Step 2A: Call API
                 let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                 
                 if(likePostResponseModel.success == true) {
                     print("SUCCESS: likePostResponseModel")
                     
                     //Step 2B: Update API
                     likeButton.setImage(UIImage(named: "liked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                     likeButton.imageView?.contentMode = .scaleAspectFit
                     likeCountLabel.text = String((Int(likeCountLabel.text ?? "0") ?? 0) + 1)
                     
                     //Step 2C: Update HomeViewController
                     let data = likePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)

                     //Error: Handled by API
                 } else {
                     print(likePostResponseModel)
                     print("error dudee!")
                     
                 }
                 
                 //Error: Not expected
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
     
     //STEP 3: Make Call to API to Unlike a Post
     } else {
         print("Already Liked")
         Task{
             do{
                 //Step 3A: Call API
                 let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                 //Success
                 if(unlikePostResponseModel.success == true) {
                     print("SUCCESS: unlikePostResponseModel")
                     
                     //Step 3B: Update API
                     likeButton.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysOriginal), for: .normal)
                     likeButton.imageView?.contentMode = .scaleAspectFit
                     likeCountLabel.text = String(max((Int(likeCountLabel.text ?? "0") ?? 0) - 1, 0))
                     
                     //Step 3C: Update HomeViewController
                     let data = unlikePostResponseModel.data
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: likeModel)

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
 */

/*
 
 //func handleLikeResponse(_ likeModel: LikeModel) {
 //func printPostLikes(post: Post)
 func handleLikeResponse(likeModel: LikeModel, currentUser: String) {
     guard let post = currentPost else {
         
         print("Error: currentPost is nil")
         return
     }
     
     post.isLikedByCurrentUser = true

     // Ensure no duplicates
     post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
     post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })

     post.simpleLikesArray?.append(likeModel.likedByUserName)
     post.postLikesArray?.append(likeModel)

     //updateLikeButtonUI()
 }

 //func handleUnlikeResponse(_ likeModel: LikeModel) {
 func handleUnlikeResponse(likeModel: LikeModel, currentUser: String) {
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }

     post.isLikedByCurrentUser = false

     post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
     post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })

     //updateLikeButtonUI()
 }

 */
/*
 //Need Current Status to update and toggle
 @objc func likeButtonTappedORIGINAL() {
     print("Like Button!")
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     // Safely unwrap and toggle
     post.isLikedByCurrentUser = !(post.isLikedByCurrentUser ?? false)
     
     // Update button image
     let newImageName = post.isLikedByCurrentUser == true ? "liked" : "like"
     likeButton.setImage(UIImage(named: newImageName), for: .normal)
     
     // Optional: update like count label if you modify the count
     let currentLikeCount = post.simpleLikesArray?.count ?? 0
     likeCountLabel.text = "\(currentLikeCount)"
 }
 
 
 //Like Button
 @IBAction func likeButtonTappedPULLFROM(_ sender: UIButton) {
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     let groupID : Int = post.groupID ?? 0
     //likeButton.isEnabled = false // Prevent rapid tapping

     if post.isLikedByCurrentUser == true {
         
         // UNLIKE API CALL
         print("UNLIKE API \(post.isLikedByCurrentUser)")
         Task{
             do{
                 //Step 3A: Call API
                 let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                 //Success
                 if(unlikePostResponseModel.success == true) {
                     print("SUCCESS: unlikePostResponseModel")
                     
                     post.isLikedByCurrentUser = false
                     
                     //print(unlikePostResponseModel.data.)
                     

                     let data = unlikePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     
                     print(" UNLIKE ")
                     print(post.simpleLikesArray)
                     print(likeModel)
                     print(" ")
                     print("____________________________________ ")
                     
                     //STEP 1: Update Current Post Values
                     
                     //STEP 2: Update UI based on new values
                     
                     // Update button image
                     //let newImageName = post.isLikedByCurrentUser == true ? "liked" : "like"
                     //likeButton.setImage(UIImage(named: newImageName), for: .normal)
                     
                     // Optional: update like count label if you modify the count
                     //let currentLikeCount = post.simpleLikesArray?.count ?? 0
                     //likeCountLabel.text = "\(currentLikeCount)"
                     
                     
                 //Error: Handled by API
                 } else {
                     print("NOT SUCCESS: unlikePostResponseModel")
                     print(unlikePostResponseModel.data)
                     
                     
                 }
      
             //Error: Not expected
             } catch {
                 print("yo man error!")
                 print(error)
             }
         }
         
         
         //post.isLikedByCurrentUser = false
         
         
     } else {
         
         // LIKE API CALL
         print("LIKE API \(post.isLikedByCurrentUser)")
         
         Task{
             //activityIndicator.startAnimating()
             do{
                 //Step 2A: Call API
                 let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                 
                 if(likePostResponseModel.success == true) {
                     
                     let data = likePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     
                     print(likeModel)
                     
                     post.isLikedByCurrentUser = true
                     print(" LIKE ")
                     print(post.simpleLikesArray)
                     print(" ")
                     print("____________________________________ ")

                 } else {
                     print(likePostResponseModel)
                     print("error dudee!")
                     
                 }
                 
                 //Error: Not expected
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
         
         post.isLikedByCurrentUser = true
     }
     
     //print(post.simpleLikesArray)
     print(" isLikedByCurrentUser \(post.isLikedByCurrentUser)")
     //print(post.postLikesArray)
 }

 */




//NEW CODE TO USE
/*
 protocol LikePostDelegate: AnyObject {
     func userDidLikePost(postID: Int, likeModel: LikeModel)
     func userDidUnlikePost(postID: Int, unlikedByUser: String)
 }

 
 class IndividualPostViewController: UIViewController {

     @IBOutlet weak var likeButton: UIButton!
     @IBOutlet weak var likeCountLabel: UILabel!
     
     var post: Post?

     override func viewDidLoad() {
         super.viewDidLoad()
         updateLikeButtonUI()
     }





 }

 */

//NOTES


 //print("likePostResponseModel")
 //print(likePostResponseModel.data)
 //print("likePostResponseModel")
 
/*
 print("unlikePostResponseModel")
 print(unlikePostResponseModel.message)
 print(unlikePostResponseModel.data)
 print("unlikePostResponseModel")
 {
     "postLikeID": 220,
     "postID": 722,
     "likedByUserName": "frodo",
     "likedByImage": "frodo.jpg",
     "likedByFirstName": "frodo",
     "likedByLastName": "v",
     "timestamp": "2025-04-08T23:36:10.000Z",
     "friendshipStatus": "friends"
 },
 
 LikeModel(postLikeID: 236, postID: 722, likedByUserName: "davey", likedByImage: "frodo.jpg", likedByFirstName: "David", likedByLastName: "Vasquez", timestamp: "2025-04-15T23:32:16.000Z", friendshipStatus: "you")
 */

/*
//flipButton(withString: "", on: sender)
likeCountLabel.text = String(simpleLikesArray.count + 1)
let likedImage = UIImage(named: "liked")
//let imageName = currentPost.isLikedByCurrentUser == true ? "liked" : "like"
//likeButton.setImage(UIImage(named: imageName), for: .normal)

likeButton.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
likeButton.imageView?.contentMode = .scaleAspectFit


if (likePostDelegate != nil) {
    print("DELEGATE: Individual Post VC You liked the Post with post ID \(post.postID) and group ID \(groupID)")
    likePostDelegate!.userLikePost(currentPostID: post.postID)
}
 */

/*
likeCountLabel.text = String(simpleLikesArray.count - 1)
let likedImage = UIImage(named: "like")
likeButton.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
likeButton.imageView?.contentMode = .scaleAspectFit

if (likePostDelegate != nil) {
    print("DELEGATE: Individual Post VC You unliked the Post with post ID \(post.postID) and group ID \(groupID)")
    likePostDelegate!.userUnlikePost(currentPostID: post.postID)
}
 */
