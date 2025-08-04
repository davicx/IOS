//
//  FullOriginalPostToPullFrom.swift
//  Kite
//
//  Created by David Vasquez on 7/21/25.
//

import Foundation

/*
 //
 //  IndividualPostViewController.swift
 //  Kite
 //
 //  Created by David Vasquez on 4/12/25.
 //

 class HomeViewController: UIViewController {

     //HOME: API and data
     let postDataController = PostDataController.shared
     
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     
     let userDefaultManager = UserDefaultManager()
     
     lazy var currentUser: String = {
         return userDefaultManager.getLoggedInUser()
     }()
     
     
     @IBOutlet weak var postsTableView: UITableView!

     // Polling Manager
     private let pollingManager = PollingManager()


     override func viewDidLoad() {
         super.viewDidLoad()
         
         print("_______________________")
         print("HomeViewController")
         print("_______________________")
         
         // Setup PollingManager callback
         pollingManager.onFetchPosts = { [weak self] in
             self?.fetchPosts()
         }
         
          postDataController.onPostsUpdated = { [weak self] in
              self?.postsTableView.reloadData()
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

         pollingManager.startPolling() // Restart polling if view reappears
         
         
         //Temp: Debug
         Task {
             // Wait a tiny bit to let posts load before printing (if fetchPosts is still running)
             try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
             PostDataController.shared.debugPrintCommentLikes()
         }
         
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         pollingManager.stopPolling() // Stop polling when view goes away
     }

     
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
             postViewController.commentsArray = selectedPost.commentsArray ?? []
         }
     }
     
     //FUNCTIONS
     func fetchPosts() {
         Task {
             await postDataController.fetchPosts(groupID: 72)
         }
     }


 }


 //TABLE VIEW: For Individual Posts in Home Feed
 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return postDataController.posts.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
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




 import UIKit


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


 //LIKE POST: Extension
 extension IndividualPostViewController: PostCellDelegate, CommentCellDelegate  {
     
     //POST CELL
     func didTapLikePostButton(in cell: PostCell) {
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






 //POST CELL

 protocol PostCellDelegate: AnyObject {
     func didTapLikePostButton(in cell: PostCell)
 }

 class PostCell: UITableViewCell {
     weak var delegate: PostCellDelegate?

     let postImage = UIImageView()
     let postCaptionLabel = UILabel()
     let likeButton = UIButton(type: .system)
     let likeCountLabel = UILabel()
     let activityIndicator = UIActivityIndicatorView(style: .medium)
     let likeStackView = UIStackView()
     let dividerView = UIView()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupPostViews()
         setupButtonTarget()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     //ACTIONS
     func setupButtonTarget() {
         likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
     }

     @objc private func likeButtonTapped() {
         delegate?.didTapLikePostButton(in: self)
     }

     //CELL SETUP
     func configurePost(with post: Post) {
         postImage.image = post.postImageData ?? UIImage(named: Constants.Image.fallbackPostImage)
         postCaptionLabel.text = post.postCaption
         likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"

         let imageName = post.isLikedByCurrentUser == true ? "liked" : "like"
         likeButton.setImage(UIImage(named: imageName), for: .normal)
     
         stopLoading()

     }
     
     //FUNCTIONS
     func startLoading() {
         likeButton.isEnabled = false
     }

     func stopLoading() {
         likeButton.isEnabled = true
     }
     
     //STYLE
     private func setupPostViews() {
         contentView.addSubview(postImage)
         contentView.addSubview(postCaptionLabel)
         contentView.addSubview(likeStackView)
         contentView.addSubview(dividerView)

         postImage.contentMode = .scaleAspectFill
         postImage.clipsToBounds = true
         postImage.translatesAutoresizingMaskIntoConstraints = false

         postCaptionLabel.numberOfLines = 0
         postCaptionLabel.font = .systemFont(ofSize: 16)
         postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

         likeButton.translatesAutoresizingMaskIntoConstraints = false
         likeCountLabel.font = .systemFont(ofSize: 18)
         likeCountLabel.textAlignment = .center

         activityIndicator.hidesWhenStopped = true
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false

         likeStackView.axis = .horizontal
         likeStackView.distribution = .fillEqually
         likeStackView.spacing = 8
         likeStackView.translatesAutoresizingMaskIntoConstraints = false
         likeStackView.addArrangedSubview(likeCountLabel)
         likeStackView.addArrangedSubview(likeButton)
         likeStackView.addArrangedSubview(activityIndicator)

         dividerView.backgroundColor = .blue
         dividerView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
             postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             postImage.heightAnchor.constraint(equalToConstant: 400),

             postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
             postCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             postCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),

             likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
             likeStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             likeStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
             likeStackView.heightAnchor.constraint(equalToConstant: 40),

             dividerView.topAnchor.constraint(equalTo: likeStackView.bottomAnchor, constant: 8),
             dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             dividerView.heightAnchor.constraint(equalToConstant: 2),
             dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ])
     }
     

 }


 //COMMENT CELL

 //Need a Did Like Comment Delegate
 protocol CommentCellDelegate: AnyObject {
      func didTapLikeCommentButton(in cell: CommentCell)
 }


 class CommentCell: UITableViewCell {
     weak var delegate: CommentCellDelegate?
     
     // MAIN: Views
     let userView = UIView()
     let commentView = UIView()
     let dividerView = UIView()
     
     //COMMENT
     let userInfoView = UIView()
     let commentCaptionView = UIView()
     let commentSocialsView = UIView()
     
     //UI LABELS
     let userNameLabel = UILabel()
     let userFirstNameLabel = UILabel()
     let timeLabel = UILabel()
     let menuButton = UIButton(type: .system)
     let likesLabel = UILabel()
     let likeCommentButton = UIButton(type: .system)
     
     let activityIndicator = UIActivityIndicatorView(style: .medium)

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupMainViews()
         setupUserInfoView()
         setupCommentCaptionView()
         setupCommentSocialsView()
         //setupCommentSocialsView()
         setupActions()

     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setupActions() {
         likeCommentButton.addTarget(self, action: #selector(didTapLikeComment), for: .touchUpInside)
     }

     @objc private func didTapLikeComment() {
         print("STEP 1: CommentCell - User tapped Like button and called didTapLikeCommentButton in controller")
         delegate?.didTapLikeCommentButton(in: self)
     }
     
     //CELL SETUP
     func configureComment(with comment: Comment) {
         //print("CommentCell: configureComment was called to set up cell")
         
         //Comment From Image
         
         //Comment User Info
         if let userName = comment.userName {
             userNameLabel.text = "@\(userName)"
         } else {
             userNameLabel.text = "@unknown"
         }

         let first = comment.firstName ?? "Unknown"
         let last = comment.lastName ?? "Unknown"
         userFirstNameLabel.text = "\(first) \(last)"

         
         //Comment Caption
         if let textView = commentCaptionView.subviews.compactMap({ $0 as? UITextView }).first {
             textView.text = comment.commentCaption
         }
         
         let likeCount = comment.commentLikes?.count ?? comment.commentLikeCount ?? 0
         likesLabel.text = "\(likeCount) likes"

         let imageName = comment.commentLikedByCurrentUser == true ? "liked" : "like"
         likeCommentButton.setImage(UIImage(named: imageName), for: .normal)

         stopLoading()
     }

     
     //FUNCTIONS
     func startLoading() {
         likeCommentButton.isEnabled = false
     }

     func stopLoading() {
         likeCommentButton.isEnabled = true
     }

  
     //STYLE
     private func setupMainViews() {
          userView.backgroundColor = .blue
          commentView.backgroundColor = .systemPink
          dividerView.backgroundColor = .black

          [userView, commentView, dividerView].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
              contentView.addSubview($0)
          }

          NSLayoutConstraint.activate([
              // userView: fixed width, full vertical
              userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              userView.topAnchor.constraint(equalTo: contentView.topAnchor),
              userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
              userView.widthAnchor.constraint(equalToConstant: 80),

              // commentView: takes remaining space
              commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
              commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
              commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

              // dividerView: full width, 1 pixel height at bottom
              dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
              dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
          ])
         
         
         //Set up User Image
         let userImageView = UIImageView()
         
         userImageView.image = UIImage(named: "user")
         userImageView.contentMode = .scaleAspectFill
         userImageView.clipsToBounds = true
         userImageView.layer.cornerRadius = 30
         
         userView.addSubview(userImageView)
         userImageView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
             userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
             userImageView.widthAnchor.constraint(equalToConstant: 65),
             userImageView.heightAnchor.constraint(equalToConstant: 65)
         ])
      }
     
     private func setupUserInfoView() {
         userInfoView.translatesAutoresizingMaskIntoConstraints = false
         userInfoView.backgroundColor = .yellow
         commentView.addSubview(userInfoView)

         let userNameView = UIView()
         userNameView.backgroundColor = .lightGray
         userNameView.translatesAutoresizingMaskIntoConstraints = false

         let userFirstNameView = UIView()
         userFirstNameView.backgroundColor = .systemRed
         userFirstNameView.translatesAutoresizingMaskIntoConstraints = false

         let commentMenuView = UIView()
         commentMenuView.translatesAutoresizingMaskIntoConstraints = false
         commentMenuView.backgroundColor = .clear
         userInfoView.addSubview(userNameView)
         userInfoView.addSubview(userFirstNameView)
         userInfoView.addSubview(commentMenuView)

         // Add labels
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         userFirstNameLabel.translatesAutoresizingMaskIntoConstraints = false
         userNameView.addSubview(userNameLabel)
         userFirstNameView.addSubview(userFirstNameLabel)

         // Stack for time label and menu button
         let timeMenuStack = UIStackView()
         timeMenuStack.axis = .horizontal
         timeMenuStack.alignment = .center
         timeMenuStack.distribution = .equalSpacing
         timeMenuStack.spacing = 8
         timeMenuStack.translatesAutoresizingMaskIntoConstraints = false
         commentMenuView.addSubview(timeMenuStack)

         // Time label
         timeLabel.translatesAutoresizingMaskIntoConstraints = false
         timeLabel.text = "14h"
         timeLabel.font = UIFont.systemFont(ofSize: 12)
         timeLabel.textColor = .gray
         timeMenuStack.addArrangedSubview(timeLabel)

         // Menu button
         menuButton.translatesAutoresizingMaskIntoConstraints = false
         let image = UIImage(named: "menu-vertical-50")?.withRenderingMode(.alwaysOriginal)
         menuButton.setImage(image, for: .normal)
         menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
         timeMenuStack.addArrangedSubview(menuButton)

         // Only size constraints for button inside stack
         NSLayoutConstraint.activate([
             menuButton.widthAnchor.constraint(equalToConstant: 24),
             menuButton.heightAnchor.constraint(equalToConstant: 24)
         ])

         // Layout constraints
         NSLayoutConstraint.activate([
             userInfoView.topAnchor.constraint(equalTo: commentView.topAnchor),
             userInfoView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
             userInfoView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
             userInfoView.heightAnchor.constraint(equalToConstant: 48),

             commentMenuView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
             commentMenuView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor),
             commentMenuView.widthAnchor.constraint(equalToConstant: 80),
             commentMenuView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),

             userNameView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
             userNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
             userNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
             userNameView.heightAnchor.constraint(equalToConstant: 24),

             userFirstNameView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
             userFirstNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
             userFirstNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
             userFirstNameView.heightAnchor.constraint(equalToConstant: 24),

             userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor, constant: 8),
             userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
             userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userNameView.trailingAnchor, constant: -4),

             userFirstNameLabel.leadingAnchor.constraint(equalTo: userFirstNameView.leadingAnchor, constant: 8),
             userFirstNameLabel.centerYAnchor.constraint(equalTo: userFirstNameView.centerYAnchor),
             userFirstNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userFirstNameView.trailingAnchor, constant: -4),

             timeMenuStack.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),
             timeMenuStack.centerYAnchor.constraint(equalTo: commentMenuView.centerYAnchor)
         ])
     }

     
     private func setupUserInfoViewWORKING() {
         userInfoView.translatesAutoresizingMaskIntoConstraints = false
         userInfoView.backgroundColor = .yellow
         commentView.addSubview(userInfoView)

         let userNameView = UIView()
         userNameView.backgroundColor = .lightGray
         userNameView.translatesAutoresizingMaskIntoConstraints = false

         let userFirstNameView = UIView()
         userFirstNameView.backgroundColor = .systemRed
         userFirstNameView.translatesAutoresizingMaskIntoConstraints = false

         let commentMenuView = UIView()
         commentMenuView.translatesAutoresizingMaskIntoConstraints = false
         commentMenuView.backgroundColor = .clear // or .systemBlue for testing
         userInfoView.addSubview(userNameView)
         userInfoView.addSubview(userFirstNameView)
         userInfoView.addSubview(commentMenuView)

         // Add labels to user views
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         userFirstNameLabel.translatesAutoresizingMaskIntoConstraints = false
         userNameView.addSubview(userNameLabel)
         userFirstNameView.addSubview(userFirstNameLabel)

         // Time label setup
         timeLabel.translatesAutoresizingMaskIntoConstraints = false
         timeLabel.text = "14h"
         timeLabel.font = UIFont.systemFont(ofSize: 12)
         timeLabel.textColor = .gray
         commentMenuView.addSubview(timeLabel)

         // Menu button setup
         menuButton.translatesAutoresizingMaskIntoConstraints = false
         let image = UIImage(named: "menu-vertical-50")?.withRenderingMode(.alwaysOriginal)
         menuButton.setImage(image, for: .normal)
         menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
         commentMenuView.addSubview(menuButton)
         

         NSLayoutConstraint.activate([
             userInfoView.topAnchor.constraint(equalTo: commentView.topAnchor),
             userInfoView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
             userInfoView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
             userInfoView.heightAnchor.constraint(equalToConstant: 48),

             commentMenuView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
             commentMenuView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor),
             commentMenuView.widthAnchor.constraint(equalToConstant: 80),
             commentMenuView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor),

             userNameView.topAnchor.constraint(equalTo: userInfoView.topAnchor),
             userNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
             userNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
             userNameView.heightAnchor.constraint(equalToConstant: 24),

             userFirstNameView.topAnchor.constraint(equalTo: userNameView.bottomAnchor),
             userFirstNameView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
             userFirstNameView.trailingAnchor.constraint(equalTo: commentMenuView.leadingAnchor),
             userFirstNameView.heightAnchor.constraint(equalToConstant: 24),

             userNameLabel.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor, constant: 8),
             userNameLabel.centerYAnchor.constraint(equalTo: userNameView.centerYAnchor),
             userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userNameView.trailingAnchor, constant: -4),

             userFirstNameLabel.leadingAnchor.constraint(equalTo: userFirstNameView.leadingAnchor, constant: 8),
             userFirstNameLabel.centerYAnchor.constraint(equalTo: userFirstNameView.centerYAnchor),
             userFirstNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: userFirstNameView.trailingAnchor, constant: -4),

             timeLabel.topAnchor.constraint(equalTo: commentMenuView.topAnchor, constant: 4),
             timeLabel.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),

             menuButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
             menuButton.trailingAnchor.constraint(equalTo: commentMenuView.trailingAnchor, constant: -8),
             menuButton.widthAnchor.constraint(equalToConstant: 24),
             menuButton.heightAnchor.constraint(equalToConstant: 24)
         ])
     }

     
     private func setupCommentCaptionView() {
         commentCaptionView.translatesAutoresizingMaskIntoConstraints = false
         commentCaptionView.backgroundColor = .white // background for caption
         commentView.addSubview(commentCaptionView)

         let commentTextView = UITextView()
         commentTextView.translatesAutoresizingMaskIntoConstraints = false
         commentTextView.isEditable = false
         commentTextView.isScrollEnabled = false
         commentTextView.font = UIFont.systemFont(ofSize: 14)
         commentTextView.text = "Placeholder for caption"
         commentCaptionView.addSubview(commentTextView)

         NSLayoutConstraint.activate([
             commentCaptionView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
             commentCaptionView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
             commentCaptionView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),

             commentTextView.topAnchor.constraint(equalTo: commentCaptionView.topAnchor, constant: 4),
             commentTextView.leadingAnchor.constraint(equalTo: commentCaptionView.leadingAnchor, constant: 8),
             commentTextView.trailingAnchor.constraint(equalTo: commentCaptionView.trailingAnchor, constant: -8),
             commentTextView.bottomAnchor.constraint(equalTo: commentCaptionView.bottomAnchor, constant: -4)
         ])
     }
     
     
     private func setupCommentSocialsView() {
         // Setup container view
         commentSocialsView.translatesAutoresizingMaskIntoConstraints = false
         commentSocialsView.backgroundColor = .green // temp color for debugging
         commentView.addSubview(commentSocialsView)

         NSLayoutConstraint.activate([
             commentSocialsView.topAnchor.constraint(equalTo: commentCaptionView.bottomAnchor),
             commentSocialsView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
             commentSocialsView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
             commentSocialsView.heightAnchor.constraint(equalToConstant: 28),
             commentSocialsView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
         ])

         // Setup like button
         likeCommentButton.tintColor = .systemRed
         likeCommentButton.setImage(UIImage(named: "like"), for: .normal)
         likeCommentButton.translatesAutoresizingMaskIntoConstraints = false
         commentSocialsView.addSubview(likeCommentButton)

         // Setup likes label
         likesLabel.font = UIFont.systemFont(ofSize: 14)
         likesLabel.textColor = .darkGray
         likesLabel.translatesAutoresizingMaskIntoConstraints = false
         commentSocialsView.addSubview(likesLabel)

         // Setup activity indicator
         activityIndicator.hidesWhenStopped = true
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         commentSocialsView.addSubview(activityIndicator)

         // Constraints for subviews inside commentSocialsView
         NSLayoutConstraint.activate([
             likeCommentButton.centerYAnchor.constraint(equalTo: commentSocialsView.centerYAnchor),
             likeCommentButton.leadingAnchor.constraint(equalTo: commentSocialsView.leadingAnchor, constant: 16),
             likeCommentButton.widthAnchor.constraint(equalToConstant: 24),
             likeCommentButton.heightAnchor.constraint(equalToConstant: 24),

             likesLabel.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor),
             likesLabel.leadingAnchor.constraint(equalTo: likeCommentButton.trailingAnchor, constant: 8),

             activityIndicator.centerXAnchor.constraint(equalTo: likeCommentButton.centerXAnchor),
             activityIndicator.centerYAnchor.constraint(equalTo: likeCommentButton.centerYAnchor)
         ])
     }

     //ACTIONS
     @objc private func menuButtonTapped() {
         print("hi")
     }


 }


 */
