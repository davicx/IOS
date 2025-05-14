//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


//CURRENT: May 14
import UIKit

//let likeSummary = post.comments.map { "ID:\($0.commentID.prefix(5)) Likes:\($0.commentLikes?.count ?? 0)" }.joined(separator: " | ")
//post.caption += "\n[CommentLikes] \(likeSummary)"



class HomeViewController: UIViewController, LikePostDelegate, LikeCommentDelegate {

    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    
    let userDefaultManager = UserDefaultManager()
    
    lazy var currentUser: String = {
        return userDefaultManager.getLoggedInUser()
    }()
    
    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()

    @IBOutlet weak var postsTableView: UITableView!

    // Polling Manager
    private let pollingManager = PollingManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup PollingManager callback
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchPosts()
        }

        // Initial data fetch
        fetchPosts()

        // Start polling
        pollingManager.startPolling()

        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //TEMP
        if let firstPost = postsArray.first {
            print("viewDidAppear - First Post:")
            print("ID: \(firstPost.postID)")

            if let comments = firstPost.commentsArray, !comments.isEmpty {
                for (index, comment) in comments.enumerated() {
                    let commentID = comment.commentID ?? -1
                    let likeCount = comment.commentLikeCount ?? 0
                    print("Comment \(index + 1): ID = \(commentID), Likes = \(likeCount)")
                }
            } else {
                print("No comments for this post.")
            }

        } else {
            print("viewDidAppear - No posts available.")
        }
        //TEMP


        pollingManager.startPolling() // Restart polling if view reappears
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingManager.stopPolling() // Stop polling when view goes away
    }

    // Fetch posts using the API
    func fetchPosts() {
        print("STEP 1: fetchPosts")
        Task {
            do {
                //print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                /*
                for post in postsArray {
                    print("post Liked! \(post.isLikedByCurrentUser)")
                    print(post.postCaption)
                    print("")
                }
                 */
                
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                    self.pollingManager.resetFailureCount()
                }
            } catch {
                print("Error fetching posts: \(error)")
                pollingManager.handlePollingFailure()
            }
        }
    }
    
    //DELEGATE FUNCTIONS
    // Function D1: Like a Post
    func userLikePost(currentPostID: Int, likeModel: LikeModel) {
        print("DELEGATE: Liked post \(currentPostID) \(currentUser)")

        for post in postsArray {
            if post.postID == currentPostID {
                // Ensure arrays are initialized
                if post.simpleLikesArray == nil { post.simpleLikesArray = [] }
                if post.postLikesArray == nil { post.postLikesArray = [] }

                // Remove any duplicate entries (shouldn't happen but safe)
                post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
                post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })

                // Add the new like
                post.simpleLikesArray?.append(likeModel.likedByUserName)
                post.postLikesArray?.append(likeModel)
                post.isLikedByCurrentUser = true
                break
            }
        }
    }
    
    // Function D2: Unlike a Post
    func userUnlikePost(currentPostID: Int, likeModel: LikeModel) {
        print("DELEGATE: Unliked post \(currentPostID) \(currentUser)")

        for post in postsArray {
            if post.postID == currentPostID {
                // Remove from both arrays using API response model
                post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
                post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })
                post.isLikedByCurrentUser = false
                break
            }
        }
    }
    
    // Function D3: Like a Comment
    func userLikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel) {
        print("DELEGATE: Liked comment \(currentCommentID) on post \(currentPostID)")

        for post in postsArray {
            if post.postID == currentPostID {
                if post.commentsArray == nil {
                    post.commentsArray = []
                }

                for comment in post.commentsArray ?? [] {
                    if comment.commentID == currentCommentID {
                        comment.commentLikedByCurrentUser = true
                        comment.commentLikeCount = (comment.commentLikeCount ?? 0) + 1
                        if comment.commentLikes == nil {
                            comment.commentLikes = []
                        }
                        comment.commentLikes?.append(commentLikeModel)
                        break
                    }
                }

                break
            }
        }
    }
   
    // Function D4: UnLike a Comment
    func userUnlikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel) {
        print("DELEGATE: Unliked comment \(currentCommentID) on post \(currentPostID)")

        for post in postsArray {
            if post.postID == currentPostID {
                for comment in post.commentsArray ?? [] {
                    if comment.commentID == currentCommentID {
                        comment.commentLikedByCurrentUser = false
                        comment.commentLikeCount = max(0, (comment.commentLikeCount ?? 0) - 1)
                        comment.commentLikes?.removeAll(where: { $0.commentLikeID == commentLikeModel.commentLikeID })
                        //comment.commentLikes = (comment.commentLikes ?? []).filter {$0.likedByUserName != currentUser
                        break
                        
                        /*
                         //comment.commentLikedByCurrentUser = false
                         //comment.commentLikeCount = max(0, (comment.commentLikeCount ?? 0) - 1)
                         //comment.commentLikes = (comment.commentLikes ?? []).filter {
                         //    $0.likedByUserName != currentUser
                        // }

                         */
                    }
                }

                break
            }
        }
    }

    
    /*
    //WORKS
    func userLikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel) {
        print("HOMEVIEW CONTROLLER: Unliked post \(currentPostID) \(currentUser)")
        print(commentLikeModel)
        for post in postsArray {
            print(post.postID)
        }
        
    }
     */
    

    /*
    //WORKS

    func userUnlikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel) {
        print("HOMEVIEW CONTROLLER: Unliked post \(currentPostID) \(currentUser)")
        print(commentLikeModel)
        for post in postsArray {
            print(post.postID)
        }
    }
     */
    
    /*

     */
    
    //TABLE VIEW: Setup
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let postViewController = segue.destination as? IndividualPostViewController,
           let selectedPost = sender as? Post {
            postViewController.currentPost = selectedPost
            postViewController.likePostDelegate = self
            postViewController.likeCommentDelegate = self 
            postViewController.commentsArray = selectedPost.commentsArray ?? []
        }
    }

}


//TABLE VIEW: For Individual Posts in Home Feed
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
        let post = postsArray[indexPath.row]
        
        // Put the debug code here
        
        //print(post.commentsArray?[0])
        //let likeSummary = post.commentsArray.map {
        //    "ID:\($0.commentID.prefix(5)) Likes:\($0.commentLikes?.count ?? 0)"
        //}.joined(separator: " | ")
        //post.postCaption = (post.postCaption ?? "") + "\n[CommentLikes] \(likeSummary)"

        
        cell.updatePost(with: post)
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPost = postsArray[indexPath.row]
        let currentPostImage = currentPost.postImageData
        
        //STEP 1: Get Image Height
        let defaultImage = UIImage(named: "background_1") ?? UIImage() // fallback to blank image
        let currentImage = currentPostImage ?? defaultImage
        
        let postImageHeight = round(getImageHeight(image: currentImage))
        
        //STEP 2: Get Caption Height
        let postCaption = currentPost.postCaption ?? "no caption"
        let postCaptionHeight = round(calculateLabelHeight(text: postCaption))
        
        return 40 + postImageHeight + 40 + postCaptionHeight + 5
        
    }
    
}


