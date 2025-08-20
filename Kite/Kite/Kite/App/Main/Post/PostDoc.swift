//
//  PostDoc.swift
//  Kite
//
//  Created by David Vasquez on 8/19/25.
//

import Foundation

/*
//GROUPS: Kite
class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    var currentPost: Post!
    var comments: [Comment] = []


    let individualPostTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("IndividualPostViewController \(currentPost.postID)")
        
        comments = currentPost.commentsArray ?? []
        
        for (index, comment) in comments.enumerated() {
            print("Comment \(index): \(comment.commentCaption)")
        }
        
        print("Total comments: \(comments.count)")
        setupIndividualPostTableView()
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
        
            postCell.updatePost(with: currentPost)
            return postCell
            
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = comments[indexPath.row - 1]
            commentCell.updateComment(with: comment)
            return commentCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //STEP 1: Get Image and Caption Heights
            let postImageHeight = sizeFunctions.calculatePostImageHeight(from: currentPost.postImageData)
            let postCaptionHeight = sizeFunctions.calculatePostCaptionHeight(from: currentPost.postCaption)
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


//WORKING
/*
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
        
        print("_______________________")
        print("IndividualPostViewController")
        print("_______________________")
    
    }

    //STYLE
    private func setupPostTableView() {
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.isScrollEnabled = true
        postTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
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


//LIKE POST: Extension
extension IndividualPostViewController: PostCellDelegate, CommentCellDelegate  {
    
    //POST CELL
    func didTapLikePostButton(in cell: IndividualPostCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row == 0 else { return }

        cell.startLoading()
        spinnerHelper.show(in: self.view)

        Task {
            let groupID = currentPost.groupID ?? 0

            if currentPost.isLikedByCurrentUser == true {
                if let likeModel = await postLikeFunctions.shared.unlikePost(post: currentPost, groupID: groupID) {
                    PostDataController.shared.unlikePost(postID: currentPost.postID ?? 0, likeModel: likeModel)
                }
            } else {
                if let likeModel = await postLikeFunctions.shared.likePost(post: currentPost, groupID: groupID) {
                    PostDataController.shared.likePost(postID: currentPost.postID ?? 0, likeModel: likeModel)
                }
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

        print("STEP 2: IndividualPostViewController - didTapLikeCommentButton triggered")

        let commentIndex = indexPath.row - 1
        guard let comment = currentPost.commentsArray?[commentIndex] else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
            return
        }

        Task {
            let postID = currentPost.postID ?? 0
            let groupID = currentPost.groupID ?? 0

            if comment.commentLikedByCurrentUser == true {
                await postLikeFunctions.shared.unlikeComment(comment: comment, postID: postID, groupID: groupID)
                print("STEP 3: IndividualPostViewController - unlikeComment called")
            } else {
                await postLikeFunctions.shared.likeComment(comment: comment, postID: postID, groupID: groupID)
                print("STEP 3: IndividualPostViewController - likeComment called")
            }

            // Refresh the post from the shared data store
            DispatchQueue.main.async {
                self.currentPost = PostDataController.shared.getPostByID(postID: postID) ?? self.currentPost

                // Get the updated comment from the refreshed post
                if let updatedComment = self.currentPost.commentsArray?[commentIndex] {
                    cell.configureComment(with: updatedComment)
                } else {
                    print("Error: Updated comment not found at index \(commentIndex)")
                }

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
            let postCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.post, for: indexPath) as! IndividualPostCell
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



*/





/*
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCellQA
     let post = postDataController.posts[indexPath.row]
     cell.updatePost(with: post)
     return cell
 }
 */
/*
 //TABLE VIEW: For Individual Posts in Home Feed
 extension HomeViewControllerQA: UITableViewDataSource, UITableViewDelegate {

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return postDataController.posts.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCellQA
          let post = postDataController.posts[indexPath.row]
          cell.updatePost(with: post)
          return cell
      }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let post = postDataController.posts[indexPath.row]
          performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
      }

     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let currentPost = postDataController.posts[indexPath.row]
         let currentPostImage = currentPost.postImageData
         
         //STEP 1: Get Image Height
         let defaultImage = UIImage(named: "background_1") ?? UIImage() // fallback to blank image
         let currentImage = currentPostImage ?? defaultImage
         
         let postImageHeight = round(getImageHeight(image: currentImage))
         
         //STEP 2: Get Caption Height
         let postCaption = currentPost.postCaption ?? "no caption"
         let postCaptionHeight = round(calculateLabelHeight(text: postCaption))
         
         //return 40 + postImageHeight + 40 + postCaptionHeight + 5
         return StyleConstants.postHeader + postImageHeight + StyleConstants.postSocials + postCaptionHeight + StyleConstants.postDivider
         
     }
     
 }

 */

