//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


//INDIVIDUAL POST
/*
Post Cell (Just one)
-> PostContent (Can be post or item)
-> PostCaption
-> PostSocials
 
Comment Cell (many)
 
Make Comment (placeholder bar; text field + send next)
->
 
 */

//LISTS: Wishlist
class IndividualPostViewController: UIViewController {

    //LOGIC
    let postAPI = PostsAPI()
    let postDataController = PostDataController.shared
    
    let currentUser = userDefaultManager.getLoggedInUser()
    var postID: Int!
    
    //When true, current user created this list (hide purchase UI). Set by caller when pushing. Default true.
    var currentUserOwnsGroup: Bool = true
    
    private var post: Post? {
        return postDataController.getPostByID(postID: postID)
    }
    
    private var comments: [Comment] {
        return post?.commentsArray ?? []
    }

    //UI COMPONENTS
    let individualPostTableView = UITableView()
    private let makeComment = MakeComment()

    //MANAGE VIEWS
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hidesBottomBarWhenPushed = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewComment()
        setupIndividualPostTableView()
        
        //print("IndividualPostViewController loaded")
        //print("postID =", postID ?? -1)

        /*
        if let post = post {
            print("FOUND POST:", post.postID ?? -1)
            //print(post.postCaption)
            //print(post.itemDescription)
            //print(post.itemPrice)
            
            if let viewers = post.purchasedViewers {
                print("purchased_viewers:", viewers.isEmpty ? "[]" : viewers)
            } else {
                print("purchased_viewers: (nil - item block never ran for this post)")
            }
             
            //printPostLikes(post: post)
        } else {
            print("POST NOT FOUND")
        }
         */
        
        // Observe comment updates
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleCommentUpdated),
            name: .commentUpdated,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postDataController.currentUserOwnsGroupForDisplay = currentUserOwnsGroup
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "IndividualPostViewController \(postID)")
        //print("Post ID: \(postID ?? -1)")
        //printDebugAllCommentsForPost()
        #if !targetEnvironment(simulator)
        makeComment.focusCommentInput()
        #endif
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //LAYOUT and UI
    private func setupNewComment() {
        view.addSubview(makeComment)

        makeComment.onSendTapped = { [weak self] caption in
            self?.submitComment(caption: caption)
        }

        NSLayoutConstraint.activate([
            makeComment.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            makeComment.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            makeComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func submitComment(caption: String) {
        guard let post = post else {
            print("POST NEW COMMENT: skipped — no post in PostDataController for postID \(postID ?? -1)")
            return
        }
        Task { [weak self] in
            guard let self else { return }
            let ok = await PostLogic.shared.makeComment(post: post, commentCaption: caption)
            await MainActor.run {
                if ok {
                    self.makeComment.clearCommentText()
                }
            }
        }
    }

    func setupIndividualPostTableView() {
        individualPostTableView.dataSource = self
        individualPostTableView.delegate = self
        individualPostTableView.translatesAutoresizingMaskIntoConstraints = false
        individualPostTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        individualPostTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")

        individualPostTableView.rowHeight = UITableView.automaticDimension

        //Divider: default UITableView row separators between PostCell and CommentCell rows (not full width; no separatorStyle override here)
        
        view.addSubview(individualPostTableView)

        NSLayoutConstraint.activate([
            individualPostTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            individualPostTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            individualPostTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            individualPostTableView.bottomAnchor.constraint(equalTo: makeComment.topAnchor)
        ])
        
        view.bringSubviewToFront(makeComment)
    }
    
    //ACTIONS
    @objc private func handleCommentUpdated(_ notification: Notification) {
        guard let updatedPostID = notification.object as? Int else { return }
        
        // Only reload if this notification is for our post
        guard updatedPostID == postID else { return }
        
        // Reload table to show updated comment data
        DispatchQueue.main.async { [weak self] in
            self?.individualPostTableView.reloadData()
            self?.printDebugAllCommentsForPost()
        }
    }

    
    //FUNCTIONS
    @objc private func newGroupPostButton() {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        if let newPostVC = storyboard.instantiateViewController(withIdentifier: "NewPostViewControllerID") as? NewPostViewController {
            newPostVC.modalPresentationStyle = .fullScreen
            present(newPostVC, animated: true)
        }
    }
    
    
    //TEMP: print full `Comment` payload for each row (debug comment / imageName).
    private func printDebugAllCommentsForPost() {
        let list = comments
        
        print("---------- IndividualPostViewController: comments for post \(postID ?? -1) (\(list.count) total) ----------")
        for (index, c) in list.enumerated() {
            print("[comment \(index + 1) / \(list.count)]")
            print("  commentID: \(String(describing: c.commentID))")
            print("  postID: \(String(describing: c.postID))")
            print("  groupID: \(String(describing: c.groupID))")
            print("  listID: \(String(describing: c.listID))")
            print("  commentCaption: \(String(describing: c.commentCaption))")
            print("  commentFrom: \(String(describing: c.commentFrom))")
            print("  commentType: \(String(describing: c.commentType))")
            print("  userName: \(String(describing: c.userName))")
            print("  imageName: \(String(describing: c.imageName))")
            print("  firstName: \(String(describing: c.firstName))")
            print("  lastName: \(String(describing: c.lastName))")
            print("  commentDate: \(String(describing: c.commentDate))")
            print("  commentTime: \(String(describing: c.commentTime))")
            print("  timeMessage: \(String(describing: c.timeMessage))")
            print("  created: \(String(describing: c.created))")
            print("  friendshipStatus: \(String(describing: c.friendshipStatus))")
            print("  commentLikeCount: \(String(describing: c.commentLikeCount))")
            print("  commentLikedByCurrentUser: \(String(describing: c.commentLikedByCurrentUser))")
            print("  commentLikes: \(String(describing: c.commentLikes))")
            print("  ---")
        }
        print("---------- end comments ----------")
    }
}

extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            postCell.configure(postID: postID)
            return postCell
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = comments[indexPath.row - 1]
            commentCell.configureCommentCell(with: comment)
            return commentCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Row 0 must not use a fixed height smaller than ItemContent (min ~328: 8 + 280 + 40) + PostCaption + PostSocials or the cell compresses ItemContent and hides the footer (itemCaptionView).
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 700
        }
        return 180
    }
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
