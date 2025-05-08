//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


protocol LikePostDelegate: AnyObject {
    func userLikePost(currentPostID: Int, likeModel: LikeModel)
    func userUnlikePost(currentPostID: Int, likeModel: LikeModel)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()

    var likePostDelegate: LikePostDelegate? = nil
    var currentPost: Post!

    let postTableView = UITableView()
    
    var commentsArray: [CommentModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostTableView()
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

    func handleLike(post: Post, groupID: Int, completion: @escaping () -> Void) {
        Task {
            do {
                let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                if likePostResponseModel.success == true {
                    let likeModel = likePostResponseModel.data
                    post.isLikedByCurrentUser = true
                    post.postLikesArray?.append(likeModel)
                    post.simpleLikesArray?.append(likeModel.likedByUserName)
                    
                    //NEW NEED?
                    likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)
                    //NEW NEED?
                }
                
                completion()
            } catch {
                print("Error liking post:", error)
                completion()
            }
        }
    }

    func handleUnlike(post: Post, groupID: Int, completion: @escaping () -> Void) {
        Task {
            do {
                let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)
                if unlikePostResponseModel.success == true {
                    let likeModel = unlikePostResponseModel.data
                    post.isLikedByCurrentUser = false
                    post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeModel.postLikeID }
                    post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != unlikePostResponseModel.currentUser }
                
                    //NEW NEED?
                    likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: likeModel)
                    //NEW NEED?
                }
                completion()
            } catch {
                print("Error unliking post:", error)
                completion()
            }
        }
    }
}

extension IndividualPostViewController: PostCellDelegate {
    func didTapLikeButton(in cell: PostCell) {
        guard let indexPath = postTableView.indexPath(for: cell) else { return }
        if indexPath.row == 0 {
            cell.startLoading()

            if currentPost.isLikedByCurrentUser == true {
                handleUnlike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configure(with: self.currentPost)
                    }
                }
            } else {
                handleLike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                    DispatchQueue.main.async {
                        cell.configure(with: self.currentPost)
                    }
                }
            }
        }
    }
}

//Need an extension for comment liked 
/*

 extension IndividualPostViewController: PostCellDelegate {
     func didTapLikeButton(in cell: PostCell) {
         guard let indexPath = postTableView.indexPath(for: cell) else { return }
         if indexPath.row == 0 {
             cell.startLoading()

             if currentPost.isLikedByCurrentUser == true {
                 handleUnlike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                     DispatchQueue.main.async {
                         cell.configure(with: self.currentPost)
                     }
                 }
             } else {
                 handleLike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                     DispatchQueue.main.async {
                         cell.configure(with: self.currentPost)
                     }
                 }
             }
         }
     }
 }*/

/*
 Need this data
 {
     "currentUser": "frodo",
     "postID": 722,
     "commentID": 229,
     "groupID": 72
 }

 */

extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.configure(with: currentPost)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            
            if let comments = currentPost.commentsArray, indexPath.row - 1 < comments.count {
                let comment = comments[indexPath.row - 1]
                
                cell.configure(with: comment)  // <-- pass the whole comment
            } else {
                let emptyComment = CommentModel(commentID: nil, postID: nil, groupID: nil, listID: nil, commentCaption: "No comment", commentFrom: nil, commentType: nil, userName: nil, imageName: nil, firstName: nil, lastName: nil, commentDate: nil, commentTime: nil, timeMessage: nil, commentLikes: nil, created: nil, friendshipStatus: nil, commentLikeCount: nil, commentLikedByCurrentUser: false)
                cell.configure(with: emptyComment)
            }
            
   
            cell.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.05 * Double(indexPath.row), options: [.curveEaseIn], animations: {
                cell.alpha = 1
            }, completion: nil)
            
            return cell
        }
    }



}



//WORKS: Above is animation
/*
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configure(with: currentPost)
        cell.delegate = self
        return cell
    } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = commentsArray[indexPath.row - 1] // 👈 Subtract 1 because first row is post
        cell.configure(with: comment.commentCaption ?? "")
        return cell
    }
}
 */
