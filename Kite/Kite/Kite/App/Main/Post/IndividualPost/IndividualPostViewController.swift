//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


//LISTS: Wishlist
class IndividualPostViewController: UIViewController {
    
    let postAPI = PostsAPI()
    let postDataController = PostDataController.shared
    
    let currentUser = userDefaultManager.getLoggedInUser()
    var postID: Int!

    let individualPostTableView = UITableView()
    
    private var post: Post? {
        return postDataController.getPostByID(postID: postID)
    }
    
    private var comments: [Comment] {
        return post?.commentsArray ?? []
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndividualPostTableView()
        
        print("IndividualPostViewController loaded")
        print("postID =", postID ?? -1)

        if let post = post {
            print("FOUND POST:", post.postID ?? -1)
            print(post.postCaption)
            printPostLikes(post: post)
        } else {
            print("POST NOT FOUND")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "IndividualPostViewController")
    }

    func setupIndividualPostTableView() {
        individualPostTableView.dataSource = self
        individualPostTableView.delegate = self
        individualPostTableView.translatesAutoresizingMaskIntoConstraints = false
        individualPostTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        individualPostTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")

        //Enable automatic dimension for dynamic cell heights
        individualPostTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(individualPostTableView)

        NSLayoutConstraint.activate([
            individualPostTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            individualPostTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            individualPostTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            individualPostTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func newGroupPostButton() {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        if let newPostVC = storyboard.instantiateViewController(withIdentifier: "NewPostViewControllerID") as? NewPostViewController {
            newPostVC.modalPresentationStyle = .fullScreen
            present(newPostVC, animated: true)
        }
    }
}

extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            postCell.configurePostCell(postID: postID)
            return postCell
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = comments[indexPath.row - 1]
            commentCell.configure(with: comment)
            return commentCell
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    */
   
}


/*
//LISTS: Wishlist
class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    let postDataController = PostDataController.shared
    
    // Support both Post and Item (Item is just a Post with postType == "item")
    var currentPost: Post?
    var comments: [Comment] = []

    let individualPostTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Get postID from currentPost
        let postID = currentPost?.postID ?? 0
        print("________________________")
        print("IndividualPostViewController: Post ID \(postID)")
        print("LISTS: Wishlist")
        if let itemName = currentPost?.itemName {
            print("Item Name: \(itemName)")
        }
        print("________________________")
        print(" ")
        
        setupIndividualPostTableView()
        
        //This can go away
        refreshCommentsFromPostDataController()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated),
            name: .postUpdated,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh comments when view appears to get latest updates
        refreshCommentsFromPostDataController()
    }
    
    private func refreshCommentsFromPostDataController() {
        let postID = currentPost?.postID ?? 0
        
        // Try to get updated post from PostDataController
        if let post = currentPost {
            // Try to get updated version from PostDataController
            if let updatedPost = postDataController.getPostByID(postID: postID) {
                currentPost = updatedPost
                comments = updatedPost.commentsArray ?? []
            } else {
                // Fallback to current post's comments if not found in PostDataController
                comments = post.commentsArray ?? []
            }
        }
        
        // Update UI on main thread
        DispatchQueue.main.async { [weak self] in
            self?.individualPostTableView.reloadData()
        }
        
        // Debug print
        for (index, comment) in comments.enumerated() {
            print("Comment \(index): \(comment.commentCaption)")
        }
        print("Total comments: \(comments.count)")
    }

    @objc private func handlePostUpdated(_ notification: Notification) {
        guard let updatedPostID = notification.object as? Int else { return }

        let currentID = currentPost?.postID
        guard updatedPostID == currentID else { return }

        // Pull fresh data from source of truth
        currentPost = postDataController.getPostByID(postID: updatedPostID)
        comments = currentPost?.commentsArray ?? []

        individualPostTableView.reloadData()
    }

    
    func setupIndividualPostTableView() {
        individualPostTableView.dataSource = self
        individualPostTableView.delegate = self
        individualPostTableView.translatesAutoresizingMaskIntoConstraints = false
        individualPostTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        individualPostTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        
        //TEMP
        individualPostTableView.separatorStyle = .none
        //TEMP
        
        //Enable automatic dimension for dynamic cell heights
        individualPostTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(individualPostTableView)

        NSLayoutConstraint.activate([
            individualPostTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            individualPostTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            individualPostTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            individualPostTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
            // Use currentPost (which can be an item if postType == "item")
            if let post = currentPost {
                // Check if it's an item and use appropriate method
                if post.postType == "item" {
                    postCell.updateItem(with: post)
                } else {
                    postCell.updatePost(with: post)
                }
            }
            return postCell
            
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = comments[indexPath.row - 1]
            //commentCell.updateComment(with: comment)
            return commentCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //STEP 1: Get Image and Caption Heights
            let postImageData = currentPost?.postImageData
            let postCaption = currentPost?.postCaption
            
            let postImageHeight = sizeFunctions.calculatePostImageHeight(from: postImageData)
            let postCaptionHeight = sizeFunctions.calculatePostCaptionHeight(from: postCaption)
            let postCaptionUserNameHeight: CGFloat = 20
        
            //return 85 + postImageHeight + postCaptionHeight + postCaptionUserNameHeight
            return 85 + postImageHeight + postCaptionHeight
        } else {
            //Use automatic dimension for comment rows
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200 // Estimated height for post
        } else {
            return 60 // Estimated height for comments
        }
    }
}

*/


//APPENDIX

/*
// TEMP: Print users who have liked the post
func printPostLikes() {
    guard let post = post else {
        print("Post not found")
        return
    }
    
    print("========== POST LIKES ==========")
    print("Post ID: \(post.postID)")
    print("Is Liked by Current User: \(post.isLikedByCurrentUser ?? false)")
    
    if let simpleLikes = post.simpleLikesArray, !simpleLikes.isEmpty {
        print("Users who liked this post (\(simpleLikes.count)):")
        for (index, username) in simpleLikes.enumerated() {
            print("  \(index + 1). \(username)")
        }
    } else {
        print("No users have liked this post yet")
    }
    
    if let postLikes = post.postLikesArray, !postLikes.isEmpty {
        print("\nDetailed Likes (\(postLikes.count)):")
        for (index, likeModel) in postLikes.enumerated() {
            print("  \(index + 1). \(likeModel.likedByUserName ?? "Unknown")")
        }
    }
    
    print("=================================")
}
*/
