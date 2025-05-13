//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


//LIKE POST DELEGATE
protocol LikePostDelegate: AnyObject {
    func userLikePost(currentPostID: Int, likeModel: LikeModel)
    func userUnlikePost(currentPostID: Int, likeModel: LikeModel)
}

//COMMENT POST DELEGATE
protocol LikeCommentDelegate: AnyObject {
    func userLikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel)
    func userUnlikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    var currentPost: Post!

    let postTableView = UITableView()
    var commentsArray: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostTableView()
    }
    
    //NEW
    let screenSpinner = UIActivityIndicatorView(style: .large)

    func showScreenSpinner() {
        screenSpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(screenSpinner)
        NSLayoutConstraint.activate([
            screenSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        screenSpinner.startAnimating()
    }

    func hideScreenSpinner() {
        screenSpinner.stopAnimating()
        screenSpinner.removeFromSuperview()
    }

    //NEW

    //DELEGATES
    var likePostDelegate: LikePostDelegate? = nil
    var likeCommentDelegate: LikeCommentDelegate? = nil
    
    //Function 1: Like Post
    func handleLike(post: Post, groupID: Int, completion: @escaping () -> Void) {
        Task {
            do {
                let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                if likePostResponseModel.success == true {
                    let likeModel = likePostResponseModel.data
                    post.isLikedByCurrentUser = true
                    post.postLikesArray?.append(likeModel)
                    post.simpleLikesArray?.append(likeModel.likedByUserName)
                    likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)
                }
                
                completion()
            } catch {
                print("Error liking post:", error)
                completion()
            }
        }
    }
    
    //Function 2: Unlike Post
    func handleUnlike(post: Post, groupID: Int, completion: @escaping () -> Void) {
        Task {
            do {
                let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)
                if unlikePostResponseModel.success == true {
                    let likeModel = unlikePostResponseModel.data
                    post.isLikedByCurrentUser = false
                    post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeModel.postLikeID }
                    post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != unlikePostResponseModel.currentUser }
                    likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: likeModel)

                }
                completion()
            } catch {
                print("Error unliking post:", error)
                completion()
            }
        }
    }
    

    //Function 3: Like Comment
    func handleLikeComment(comment: Comment, postID: Int, groupID: Int, completion: @escaping () -> Void) {
        print("LIKE COMMENT DELEGATE: handleLikeComment")
        Task {
            do {
                let response = try await CommentsAPI.shared.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
                
                if response.success == true {
                    let commentLikeModel = response.data
                    print("LIKE A COMMENT")

                    //MAY NOT NEED NOW
                    //comment.commentLikedByCurrentUser = true
                    //comment.commentLikeCount = (comment.commentLikeCount ?? 0) + 1
                    //comment.commentLikes = (comment.commentLikes ?? []) + [commentLikeModel]
                    
                    likeCommentDelegate?.userLikeComment(currentPostID: comment.postID!, currentCommentID: comment.commentID!, commentLikeModel: commentLikeModel)
     
                }

                completion()
            } catch {
                print("Error liking comment:", error)
                completion()
            }
        }
    }

     
    //Function 4: Unlike Comment
    func handleUnLikeComment(comment: Comment, postID: Int, groupID: Int, completion: @escaping () -> Void) {
        print("LIKE COMMENT DELEGATE: handleUnLikeComment")
        Task {
            do {
                let response = try await CommentsAPI.shared.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
                
                if response.success == true {
                    let commentUnlikeModel = response.data
                    print("UNLIKE A COMMENT")

                    //MAY NOT NEED NOW
                    //comment.commentLikedByCurrentUser = false
                    //comment.commentLikeCount = max(0, (comment.commentLikeCount ?? 0) - 1)
                    //comment.commentLikes = (comment.commentLikes ?? []).filter {
                    //    $0.likedByUserName != currentUser
                   // }

                    likeCommentDelegate?.userUnlikeComment(currentPostID: comment.postID!, currentCommentID: comment.commentID!, commentLikeModel: commentUnlikeModel)
                }

                completion()
            } catch {
                print("Error unliking comment:", error)
                completion()
            }
        }
    }


    //STYLE
    private func setupPostTableView() {
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.isScrollEnabled = true
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        postTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        postTableView.separatorStyle = .none
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 44

        view.addSubview(postTableView)

        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}



//LIKE POST DELEGATE: Extension
extension IndividualPostViewController: PostCellDelegate {
    func didTapLikePostButton(in cell: PostCell) {
        guard let indexPath = postTableView.indexPath(for: cell) else { return }
        if indexPath.row == 0 {
            
            cell.startLoading()
            showScreenSpinner()

            if currentPost.isLikedByCurrentUser == true {
                handleUnlike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configurePost(with: self.currentPost)
                        self.hideScreenSpinner()
                    }
                }
            } else {
                handleLike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configurePost(with: self.currentPost)
                        self.hideScreenSpinner()
                    }
                }
            }
        }
    }
}

//LIKE COMMENT DELEGATE: Extension

extension IndividualPostViewController: CommentCellDelegate {
    
    //didTapLikeCommentButton is located in the Comment Cell
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        cell.startLoading()
        showScreenSpinner()
        
        let commentIndex = indexPath.row - 1
        guard var comment = currentPost.commentsArray?[commentIndex] else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
            return
        }

        //COMMENT: Unlike Comment
        if comment.commentLikedByCurrentUser == true {
   
            //handleUnLikeComment is located in IndividualPostViewController
            handleUnLikeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0) {
                print("API IndividualPostViewController Finished Unlike API Call for commentID \(comment.commentID ?? -1)")
                DispatchQueue.main.async {
                    cell.configureComment(with: comment)
                    self.hideScreenSpinner()
                }
            }

        } else {
            //handleLikeComment is located in IndividualPostViewController
            handleLikeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0) {
                print("API IndividualPostViewController Finished Like API Call for commentID \(comment.commentID ?? -1)")
                DispatchQueue.main.async {
                    cell.configureComment(with: comment)
                    self.hideScreenSpinner()
                }
            }
        }
    }
    
    /*
     DispatchQueue.main.async {
         self.updatePostCaptionWithCommentLikes()
         self.postTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
         self.hideScreenSpinner()
     }

     */
}



//TABLE VIEW
extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //INDIVIDUAL POST:
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            postCell.configurePost(with: currentPost)
            postCell.delegate = self
            return postCell
        } else {
            
            //COMMENTS: Comments inside table view
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            
            if let comments = currentPost.commentsArray, indexPath.row - 1 < comments.count {
                let comment = comments[indexPath.row - 1]
                
                commentCell.configureComment(with: comment)  // <-- pass the whole comment
                commentCell.delegate = self 
            } else {
                let emptyComment = Comment(commentID: nil, postID: nil, groupID: nil, listID: nil, commentCaption: "No comment", commentFrom: nil, commentType: nil, userName: nil, imageName: nil, firstName: nil, lastName: nil, commentDate: nil, commentTime: nil, timeMessage: nil, commentLikes: nil, created: nil, friendshipStatus: nil, commentLikeCount: nil, commentLikedByCurrentUser: false)
                commentCell.configureComment(with: emptyComment)
            }
   
            commentCell.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.05 * Double(indexPath.row), options: [.curveEaseIn], animations: {
                commentCell.alpha = 1
            }, completion: nil)
            
            return commentCell
        }
    }

}





