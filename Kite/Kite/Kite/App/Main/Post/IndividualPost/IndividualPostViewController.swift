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
    let currentUser = userDefaultManager.getLoggedInUser()
    let postDataController = PostDataController.shared
    
    // Support both Post and Item (Item has all Post properties plus item-specific data)
    var currentPost: Post?
    var currentItem: Item?
    var comments: [Comment] = []

    let individualPostTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Get postID from either currentItem or currentPost
        let postID = currentItem?.postID ?? currentPost?.postID ?? 0
        print("________________________")
        print("IndividualPostViewController: Post ID \(postID)")
        print("LISTS: Wishlist")
        if let itemName = currentItem?.itemName {
            print("Item Name: \(itemName)")
        }
        print("________________________")
        print(" ")
        
        setupIndividualPostTableView()
        refreshCommentsFromPostDataController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh comments when view appears to get latest updates
        refreshCommentsFromPostDataController()
    }
    
    private func refreshCommentsFromPostDataController() {
        let postID = currentItem?.postID ?? currentPost?.postID ?? 0
        
        // Try to get updated post/item from PostDataController
        if let item = currentItem {
            // If we have an item, try to get updated version from PostDataController
            if let updatedItem = postDataController.getItemByID(postID: postID) {
                currentItem = updatedItem
                comments = updatedItem.commentsArray ?? []
            } else {
                // Fallback to current item's comments if not found in PostDataController
                comments = item.commentsArray ?? []
            }
        } else if let post = currentPost {
            // If we have a post, try to get updated version from PostDataController
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
        
            // Use currentItem if available (contains all post data), otherwise use currentPost
            if let item = currentItem {
                postCell.updateItem(with: item)
            } else if let post = currentPost {
                postCell.updatePost(with: post)
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
            let postImageData = currentItem?.postImageData ?? currentPost?.postImageData
            let postCaption = currentItem?.postCaption ?? currentPost?.postCaption
            
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


