//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


//LIKE POST DELEGATE
protocol LikePostDelegate: AnyObject {
    func updatePostsArrayWithLikePost(currentPostID: Int, likeModel: LikeModel)
    func updatePostsArrayWithUnlikePost(currentPostID: Int, likeModel: LikeModel)
}

//COMMENT POST DELEGATE
protocol LikeCommentDelegate: AnyObject {
    func updatePostsArrayWithLikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel)
    func updatePostsArrayWithUnlikeComment(currentPostID: Int, currentCommentID: Int, commentLikeModel: CommentLikeModel)
}


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    var currentPost: Post!

    let postTableView = UITableView()
    var commentsArray: [Comment] = []
    
    private let spinnerHelper = SpinnerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostTableView()
        
        postLikeFunctions.shared.likePostDelegate = self.likePostDelegate
        postLikeFunctions.shared.likeCommentDelegate = self.likeCommentDelegate
    }
    

    //DELEGATES
    var likePostDelegate: LikePostDelegate? = nil
    var likeCommentDelegate: LikeCommentDelegate? = nil
    
    //STYLE
    private func setupPostTableView() {
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.isScrollEnabled = true
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
extension IndividualPostViewController: PostCellDelegate, CommentCellDelegate  {
    
    //POST CELL
    func didTapLikePostButton(in cell: PostCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row == 0 else { return }

        cell.startLoading()
        spinnerHelper.show(in: self.view)

        Task {
            if currentPost.isLikedByCurrentUser == true {
                await postLikeFunctions.shared.unlikePost(post: currentPost, groupID: currentPost.groupID ?? 0)
            } else {
                await postLikeFunctions.shared.likePost(post: currentPost, groupID: currentPost.groupID ?? 0)
            }

            DispatchQueue.main.async {
                cell.configurePost(with: self.currentPost)
                self.spinnerHelper.hide()
            }
        }
    }
    
    //COMMENT CELL
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        cell.startLoading()
        spinnerHelper.show(in: self.view)
        
        print("STEP 2: IndividualPostViewController- didTapLikeCommentButton was pressed and it will either like or unlike a comment")
 
        let commentIndex = indexPath.row - 1
        guard let comment = currentPost.commentsArray?[commentIndex] else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
            return
        }

        Task {
            if comment.commentLikedByCurrentUser == true {
                await postLikeFunctions.shared.unlikeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0)
                print("STEP 3: IndividualPostViewController- unlikeComment was called from our postLikeFunctions")
         
            } else {
                await postLikeFunctions.shared.likeComment(comment: comment, postID: currentPost.postID ?? 0, groupID: currentPost.groupID ?? 0)
                print("STEP 3: IndividualPostViewController- likeComment was called from our postLikeFunctions")
            }

            DispatchQueue.main.async {
                cell.configureComment(with: comment)
                self.spinnerHelper.hide()
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
        
        //INDIVIDUAL POST:
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.post, for: indexPath) as! PostCell
            postCell.configurePost(with: currentPost)
            postCell.delegate = self
            return postCell
        } else {
            
            //COMMENTS: Comments inside table view
            let commentCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.comment, for: indexPath) as! CommentCell
            
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 0 { // Apply animation only to comment cells
            cell.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.05 * Double(indexPath.row), options: [.curveEaseIn], animations: {
                cell.alpha = 1
            }, completion: nil)
        }
    }
}





