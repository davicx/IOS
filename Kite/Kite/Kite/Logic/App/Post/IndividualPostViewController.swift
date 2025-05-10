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

//COMMENT POST DELEGATW
protocol LikeCommentDelegate: AnyObject {
    func userLikeComment(currentPostID: Int, commentLikeModel: CommentLikeModel)
    func userUnlikeComment(currentPostID: Int, commentLikeModel: CommentLikeModel)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()

    //LIKE POST DELEGATE
    var likePostDelegate: LikePostDelegate? = nil
    var likeCommentDelegate: LikeCommentDelegate? = nil
    
    var currentPost: Post!

    let postTableView = UITableView()
    
    var commentsArray: [CommentModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostTableView()
    }


    //LIKE POST DELEGATE: Functions
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
    
    //LIKE POST DELEGATE: Functions
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
    
    //LIKE COMMENT DELEGATE: Functions
    func handleLikeComment(comment: CommentModel, postID: Int, groupID: Int, completion: @escaping () -> Void) {
        print("LIKE COMMENT DELEGATE: handleLikeComment")
        Task {
            do {
                let response = try await CommentsAPI.shared.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
                
                print(response.data)
                
                if response.success == true {
                    let updatedComment = response.data
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print(updatedComment)
                    
                    //Remove from Comment
                    
                    /*
                     let likeModel = likePostResponseModel.data
                     post.isLikedByCurrentUser = true
                     post.postLikesArray?.append(likeModel)
                     post.simpleLikesArray?.append(likeModel.likedByUserName)
                     likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)
                     */
                }

                completion()
            } catch {
                print("Error liking comment:", error)
                completion()
            }
        }
    }

    func handleUnLikeComment(comment: CommentModel, postID: Int, groupID: Int, completion: @escaping () -> Void) {
        print("LIKE COMMENT DELEGATE: handleUnLikeComment")
        Task {
            do {
                let response = try await CommentsAPI.shared.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
                
                print(response.data)

                if response.success == true {
                    let updatedComment = response.data
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print("Updated Comment:")
                    print(updatedComment)
                }
                completion()
            } catch {
                print("Error unliking comment:", error)
                completion()
            }
        }
    }


    
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

            if currentPost.isLikedByCurrentUser == true {
                handleUnlike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configurePost(with: self.currentPost)
                    }
                }
            } else {
                handleLike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configurePost(with: self.currentPost)
                    }
                }
            }
        }
    }
}

//LIKE COMMENT DELEGATE: Extension
extension IndividualPostViewController: CommentCellDelegate {
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        let commentIndex = indexPath.row - 1
        guard let comment = currentPost.commentsArray?[commentIndex] else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
            return
        }

        print("IndividualPostViewController: Current comment at index \(indexPath.row): \(comment.commentID ?? -1)")

        if comment.commentLikedByCurrentUser == true {
            print("Should Unlike")
            handleUnLikeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0) {
                print("Finished Unlike API Call for commentID \(comment.commentID ?? -1)")
                
            }

        } else {
            print("Should Like")
            handleLikeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0) {
                print("Finished Like API Call for commentID \(comment.commentID ?? -1)")
            }
        }
    }
}


//TABLE VIEW
extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //CURRENT POST:
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
                let emptyComment = CommentModel(commentID: nil, postID: nil, groupID: nil, listID: nil, commentCaption: "No comment", commentFrom: nil, commentType: nil, userName: nil, imageName: nil, firstName: nil, lastName: nil, commentDate: nil, commentTime: nil, timeMessage: nil, commentLikes: nil, created: nil, friendshipStatus: nil, commentLikeCount: nil, commentLikedByCurrentUser: false)
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





