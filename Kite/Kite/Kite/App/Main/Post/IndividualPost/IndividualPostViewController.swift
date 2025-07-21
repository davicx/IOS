//
//  IndividualPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 4/12/25.
//


import UIKit


class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    var currentPost: Post!

    let individualPostTableView = UITableView()
    var commentsArray: [Comment] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupIndividualPostTableView()
    }
    
    func setupIndividualPostTableView() {
        individualPostTableView.dataSource = self
        individualPostTableView.delegate = self
        individualPostTableView.translatesAutoresizingMaskIntoConstraints = false
        individualPostTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        individualPostTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        return 1 // 1 Post + 2 Comments
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            postCell.configure(with: currentPost?.postImageData)
            return postCell
        } else {
            let commentCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            commentCell.textLabel?.text = "Comment"
            commentCell.textLabel?.textAlignment = .center
            return commentCell
        }
    }
}

//SIMPLE 1
/*
class IndividualPostViewController: UIViewController {
    let postAPI = PostsAPI()
    let currentUser = userDefaultManager.getLoggedInUser()
    var currentPost: Post!
    

    let postTableView = UITableView()
    var commentsArray: [Comment] = []
    
    
    let individualPostTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupIndividualPostTableView()
    }
    
    func setupIndividualPostTableView() {
        individualPostTableView.dataSource = self
        individualPostTableView.delegate = self
        individualPostTableView.translatesAutoresizingMaskIntoConstraints = false
        individualPostTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        return 3 // 1 Post + 2 Comments
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let label = UILabel()
        label.text = indexPath.row == 0 ? "Post" : "Comment"
        label.textAlignment = .center

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() } // clean reused content
        cell.contentView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])

        return cell
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
