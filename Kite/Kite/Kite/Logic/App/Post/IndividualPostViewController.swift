//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//

import UIKit


protocol LikePostDelegate {
    func userLikePost(currentPostID: Int)
    func userUnlikePost(currentPostID: Int)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    //let currentUser = userDefaultManager.getLoggedInUser()
    let currentUser = UserDefaultManager().getLoggedInUser()

    var likePostDelegate: LikePostDelegate? = nil
    var currentPost: Post!
    
    //STEP 1: Set up UI Elements
    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let likeStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        
        if let selectedPost = currentPost {
            postImage.image = selectedPost.postImageData ?? UIImage(named: "background_10")
            postCaptionLabel.text = selectedPost.postCaption
            let currentLikeCount = selectedPost.simpleLikesArray?.count ?? 0
            likeCountLabel.text = "\(currentLikeCount)"
        } else {
            print("Error: currentPost is nil")
        }
    }
    
    
    func setUpViews() {
        guard let currentPost = currentPost else { return }
        let postLikedByCurrentUser : Bool = currentPost.isLikedByCurrentUser ?? false
        let likeCount : Int = currentPost.simpleLikesArray?.count ?? 0
        let simpleLikesArray : Array = currentPost.simpleLikesArray ?? []

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
    }
    
    //Like Button
    @objc func likeButtonTapped() {
        print("Like Button!")
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
        
        
        //STEP 2A: Make Call to API to Like a Post
        if !simpleLikesArray.contains(currentUser) {
            print("Like Me")
            Task{
                //activityIndicator.startAnimating()
                do{
                    let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                    
                    //Success
                    if(likePostResponseModel.success == true) {
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
                    let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)
                    
                    //Success
                    if(unlikePostResponseModel.success == true) {
                        
                        likeCountLabel.text = String(simpleLikesArray.count - 1)
                        let likedImage = UIImage(named: "like")
                        likeButton.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                        likeButton.imageView?.contentMode = .scaleAspectFit
                      
                        if (likePostDelegate != nil) {
                            print("DELEGATE: Individual Post VC You unliked the Post with post ID \(post.postID) and group ID \(groupID)")
                            likePostDelegate!.userUnlikePost(currentPostID: post.postID)
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
    
    
}

