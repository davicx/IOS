//
//  Doc.swift
//  Kite
//
//  Created by David Vasquez on 3/24/25.
//

import UIKit




//APPENDIX
//CELL SETUP

//FUNCTIONS

//STYLE


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
class IndividualPostCell: UITableViewCell {
    
    // Layout Manager
    private let layoutManager = IndividualPostCellLayoutManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup layout using Layout Manager
        layoutManager.setupLayout(in: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPost(post: Post) {
        print("Caption: \(post.postCaption)")
    }
}
*/

//WORKS
/*

class IndividualPostCell: UITableViewCell {
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let postCaption: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.addSubview(postCaption)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            postCaption.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postCaption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPost(post: Post) {
        postImageView.image = post.postImageData
        postCaption.text = post.postCaption
    }
}


*/



//WORKS

/*
func handleUnLikeComment(comment: Comment, postID: Int, groupID: Int, completion: @escaping () -> Void) {
    print("LIKE COMMENT DELEGATE: handleUnLikeComment")
    Task {
        do {
            let response = try await CommentsAPI.shared.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
            
            print(response.success)
            if response.success == true {
    
                print("UNLIKE A COMMENT")
                //TO DO
                var commentUnlikeModel = response.data
                comment.commentLikedByCurrentUser = false
                //UPDATE subtract 1 from comment.commentLikeCount
                //ADD remove the commentLikeModel from comment.commentLikes array where the likedByUserName is the currentUser

              

                likeCommentDelegate?.userUnlikeComment(currentPostID: comment.postID!, currentCommentID: comment.commentID!, commentLikeModel: commentUnlikeModel)
            }
            completion()
        } catch {
            print("Error unliking comment:", error)
            completion()
        }
    }
}
 */

/*
func handleLikeComment(comment: Comment, postID: Int, groupID: Int, completion: @escaping () -> Void) {
    print("LIKE COMMENT DELEGATE: handleLikeComment")
    Task {
        do {
            let response = try await CommentsAPI.shared.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)

            
            if response.success == true {
                var commentLikeModel = response.data
                print("LIKE A COMMENT")
                
                //TO DO
                comment.commentLikedByCurrentUser = true
                //UPDATE comment.commentLikeCount by 1
                //ADD commentLikeModel to comment.commentLikes array
    
                likeCommentDelegate?.userLikeComment(currentPostID: comment.postID!, currentCommentID: comment.commentID!, commentLikeModel: commentLikeModel)
      
            }

            completion()
        } catch {
            print("Error liking comment:", error)
            completion()
        }
    }
}
 */


/*
class CommentCell: UITableViewCell {

    // Main Views
    let userView = UIView()
    let commentView = UIView()
    let dividerView = UIView()

    // User Views
    let userNameLabel = UILabel()
    private let userImageView = UIImageView()
    
    //Comment Views
    let commentTextView = UITextView()
    let commentSocialsView = UIView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserViews()
        setupCommentViews()
        setupConstraints()
        setupDividerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //COMMENT: Main Views
    private func setupMainViews() {
        userView.backgroundColor = .white
        commentView.backgroundColor = .clear

        contentView.addSubview(userView)
        contentView.addSubview(commentView)

        [userView, commentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    //COMMENT: User Image
    private func setupUserViews() {
        userImageView.image = UIImage(named: "user")
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 30 // assuming 60x60 size

        userView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 65),
            userImageView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    //COMMENT: Comment Text and Socials
    private func setupCommentViews() {
        userNameLabel.backgroundColor = .systemPink
        commentTextView.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        commentSocialsView.backgroundColor = .white

        commentTextView.isScrollEnabled = false
        commentTextView.isEditable = false
        commentTextView.font = UIFont.systemFont(ofSize: 16)

        commentView.addSubview(userNameLabel)
        commentView.addSubview(commentTextView)
        commentView.addSubview(commentSocialsView)

        [userNameLabel, commentTextView, commentSocialsView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private func setupDividerView() {
        dividerView.backgroundColor = .black
        contentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale) // 1 pixel
        ])
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // userView
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userView.widthAnchor.constraint(equalToConstant: 80),

            // commentView
            commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // userNameLabel
            userNameLabel.topAnchor.constraint(equalTo: commentView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 60),

            // commentTextView
            commentTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),

            // commentSocialsView
            commentSocialsView.topAnchor.constraint(equalTo: commentTextView.bottomAnchor),
            commentSocialsView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentSocialsView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentSocialsView.heightAnchor.constraint(equalToConstant: 40),
            commentSocialsView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
            
        ])
        
    }


    func configure(with comment: CommentModel) {
        commentTextView.text = comment.commentCaption
        userNameLabel.text = comment.commentFrom
    }
}

*/

//WORKS!!
/*
class CommentCell: UITableViewCell {
    let userProfileView = UIView()
    let commentView = UIView()
    let commentLabel = UILabel()
    let commonDividerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        userProfileView.backgroundColor = .blue
        commentView.backgroundColor = .green
        commonDividerView.backgroundColor = .lightGray

        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commonDividerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(userProfileView)
        contentView.addSubview(commentView)
        contentView.addSubview(commonDividerView)
        commentView.addSubview(commentLabel)

        NSLayoutConstraint.activate([
            userProfileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userProfileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userProfileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userProfileView.widthAnchor.constraint(equalToConstant: 100),

            commentView.leadingAnchor.constraint(equalTo: userProfileView.trailingAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -8),
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -8),

            commonDividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commonDividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commonDividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commonDividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func configure(with comment: CommentModel) {
        commentLabel.text = comment.commentCaption
        print(comment.commentFrom)
    }
    
}
*/




//WORKS
/*
//Function D1: Like a Post
func userLikePost(currentPostID: Int, likeModel: LikeModel) {
    print("DELEGATE VC YOOO Liked update the MAIN VIEW MA MAN \(currentPostID)")
    
    /*
    for post in postsArray {
        if(post.postID == currentPostID) {
            //postLikesArray
            post.simpleLikesArray?.append(currentUser)
            post.isLikedByCurrentUser = true
            post.postLikesArray?.append(likeModel)
        }
    }
     */
}

//Function D2: UnlikePost
func userUnlikePost(currentPostID: Int, likeModel: LikeModel) {
    print("DELEGATE VC  YOOO Un like me dude update the MAIN VIEW MA MAN \(currentPostID)")
    /*
    for post in postsArray {
        if(post.postID == currentPostID) {
            if let index = post.simpleLikesArray!.firstIndex(of: "davey") {
                //postLikesArray
                post.simpleLikesArray?.remove(at: index)
                post.isLikedByCurrentUser = false
                //remove the postLikesArray that matches the current user
            }
        }
    }
     */
}
 */
 




// Data Passing with Segue
/*
 /*
 func userLikePost(currentPostID: Int, likeModel: LikeModel) {
     print("DELEGATE VC YOOO Liked update the MAIN VIEW MA MAN \(currentPostID)")
     // Optional: handle likeModel here if needed
 }

 func userUnlikePost(currentPostID: Int, likeModel: LikeModel) {
     print("DELEGATE VC YOOO Un like me dude update the MAIN VIEW MA MAN \(currentPostID)")
     // Optional: handle likeModel here if needed
 }
  */
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.Segue.showIndividualPost,
       let postViewController = segue.destination as? IndividualPostViewController,
       let selectedPost = sender as? Post {
        postViewController.currentPost = selectedPost
    }
}
*/

//print("heightForRowAt postImageHeight \(postImageHeight) postCaptionHeight \(postCaptionHeight)")
//print(" ")
//print("We need this for our Caption Height \(postCaptionHeight) \(currentPost.postID)")
//print(postCaption)

//footer + postImageHeight + captionTextHeight + 8 + comments
//return 10 + postImageHeight + captionTextHeight + 8 + 40

//Post User + Post Image + Post Socials + Post Caption + divider

/*
func userDidLikePost(postID: Int, likeModel: LikeModel) {
    guard let index = postsArray.firstIndex(where: { $0.postID == postID }) else { return }

    var post = postsArray[index]

    if !post.simpleLikesArray.contains(likeModel.likedByUserName) {
        post.simpleLikesArray.append(likeModel.likedByUserName)
    }

    post.isLikedByCurrentUser = true
    post.postLikesArray.append(likeModel)

    postsArray[index] = post
    postsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
}

func userDidUnlikePost(postID: Int, unlikedByUser: String) {
    guard let index = postsArray.firstIndex(where: { $0.postID == postID }) else { return }

    var post = postsArray[index]

    post.simpleLikesArray.removeAll { $0 == unlikedByUser }
    post.postLikesArray.removeAll { $0.likedByUserName == unlikedByUser }
    post.isLikedByCurrentUser = false

    postsArray[index] = post
    postsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
}
 */






//print("")
//print(post.isLikedByCurrentUser)
//print(post.simpleLikesArray)
//print(post.postLikesArray)
//print("")

/*
guard let post = self.post else { return }

let isLiked = post.isLikedByCurrentUser ?? false
let likeImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
likeButton.setImage(likeImage, for: .normal)
likeButton.tintColor = isLiked ? .systemRed : .gray

likeCountLabel.text = "\(post.postLikesArray?.count ?? 0)"
 */



/*
@IBAction func likeButtonTapped(_ sender: UIButton) {
    guard let post = currentPost else {
        print("Error: currentPost is nil")
        return
    }
    
    let groupID : Int = post.groupID ?? 0
    //likeButton.isEnabled = false // Prevent rapid tapping

    if post.isLikedByCurrentUser == true {
        
        // UNLIKE API CALL
        print("UNLIKE API \(post.isLikedByCurrentUser)")
    
        
        post.isLikedByCurrentUser = false
        
        
    } else {
        
        // LIKE API CALL
        print("LIKE API \(post.isLikedByCurrentUser)")
        
        post.isLikedByCurrentUser = true
    }
    
    //print(post.simpleLikesArray)
    print(" isLikedByCurrentUser \(post.isLikedByCurrentUser)")
    //print(post.postLikesArray)
}
*/


/*
 
 @objc func likeButtonTappedVersionTWO() {
     let activityIndicator = UIActivityIndicatorView(style: .large)
     activityIndicator.center = view.center;
     view.addSubview(activityIndicator);
     
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     //STEP 1: Determine if Post is Already Liked
     let simpleLikesArray : Array = post.simpleLikesArray ?? []
     post.isLikedByCurrentUser = !(post.isLikedByCurrentUser ?? false)
     let groupID : Int = post.groupID ?? 0
     
     
     //STEP 2: Make Call to API to Like a Post
     if !simpleLikesArray.contains(currentUser) {
         print("Like Me")
         Task{
             //activityIndicator.startAnimating()
             do{
                 //Step 2A: Call API
                 let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                 
                 if(likePostResponseModel.success == true) {
                     print("SUCCESS: likePostResponseModel")
                     
                     //Step 2B: Update API
                     likeButton.setImage(UIImage(named: "liked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                     likeButton.imageView?.contentMode = .scaleAspectFit
                     likeCountLabel.text = String((Int(likeCountLabel.text ?? "0") ?? 0) + 1)
                     
                     //Step 2C: Update HomeViewController
                     let data = likePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)

                     //Error: Handled by API
                 } else {
                     print(likePostResponseModel)
                     print("error dudee!")
                     
                 }
                 
                 //Error: Not expected
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
     
     //STEP 3: Make Call to API to Unlike a Post
     } else {
         print("Already Liked")
         Task{
             do{
                 //Step 3A: Call API
                 let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                 //Success
                 if(unlikePostResponseModel.success == true) {
                     print("SUCCESS: unlikePostResponseModel")
                     
                     //Step 3B: Update API
                     likeButton.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysOriginal), for: .normal)
                     likeButton.imageView?.contentMode = .scaleAspectFit
                     likeCountLabel.text = String(max((Int(likeCountLabel.text ?? "0") ?? 0) - 1, 0))
                     
                     //Step 3C: Update HomeViewController
                     let data = unlikePostResponseModel.data
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: likeModel)

                 //Error: Handled by API
                 } else {
                     print("error dudee!")
                     
                 }
      
             //Error: Not expected
             } catch {
                 
                 print("yo man error!")
                 print(error)
             }
         }

     }
     
     
 }
 */

/*
 
 //func handleLikeResponse(_ likeModel: LikeModel) {
 //func printPostLikes(post: Post)
 func handleLikeResponse(likeModel: LikeModel, currentUser: String) {
     guard let post = currentPost else {
         
         print("Error: currentPost is nil")
         return
     }
     
     post.isLikedByCurrentUser = true

     // Ensure no duplicates
     post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
     post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })

     post.simpleLikesArray?.append(likeModel.likedByUserName)
     post.postLikesArray?.append(likeModel)

     //updateLikeButtonUI()
 }

 //func handleUnlikeResponse(_ likeModel: LikeModel) {
 func handleUnlikeResponse(likeModel: LikeModel, currentUser: String) {
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }

     post.isLikedByCurrentUser = false

     post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
     post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })

     //updateLikeButtonUI()
 }

 */
/*
 //Need Current Status to update and toggle
 @objc func likeButtonTappedORIGINAL() {
     print("Like Button!")
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     // Safely unwrap and toggle
     post.isLikedByCurrentUser = !(post.isLikedByCurrentUser ?? false)
     
     // Update button image
     let newImageName = post.isLikedByCurrentUser == true ? "liked" : "like"
     likeButton.setImage(UIImage(named: newImageName), for: .normal)
     
     // Optional: update like count label if you modify the count
     let currentLikeCount = post.simpleLikesArray?.count ?? 0
     likeCountLabel.text = "\(currentLikeCount)"
 }
 
 
 //Like Button
 @IBAction func likeButtonTappedPULLFROM(_ sender: UIButton) {
     guard let post = currentPost else {
         print("Error: currentPost is nil")
         return
     }
     
     let groupID : Int = post.groupID ?? 0
     //likeButton.isEnabled = false // Prevent rapid tapping

     if post.isLikedByCurrentUser == true {
         
         // UNLIKE API CALL
         print("UNLIKE API \(post.isLikedByCurrentUser)")
         Task{
             do{
                 //Step 3A: Call API
                 let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                 //Success
                 if(unlikePostResponseModel.success == true) {
                     print("SUCCESS: unlikePostResponseModel")
                     
                     post.isLikedByCurrentUser = false
                     
                     //print(unlikePostResponseModel.data.)
                     

                     let data = unlikePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     
                     print(" UNLIKE ")
                     print(post.simpleLikesArray)
                     print(likeModel)
                     print(" ")
                     print("____________________________________ ")
                     
                     //STEP 1: Update Current Post Values
                     
                     //STEP 2: Update UI based on new values
                     
                     // Update button image
                     //let newImageName = post.isLikedByCurrentUser == true ? "liked" : "like"
                     //likeButton.setImage(UIImage(named: newImageName), for: .normal)
                     
                     // Optional: update like count label if you modify the count
                     //let currentLikeCount = post.simpleLikesArray?.count ?? 0
                     //likeCountLabel.text = "\(currentLikeCount)"
                     
                     
                 //Error: Handled by API
                 } else {
                     print("NOT SUCCESS: unlikePostResponseModel")
                     print(unlikePostResponseModel.data)
                     
                     
                 }
      
             //Error: Not expected
             } catch {
                 print("yo man error!")
                 print(error)
             }
         }
         
         
         //post.isLikedByCurrentUser = false
         
         
     } else {
         
         // LIKE API CALL
         print("LIKE API \(post.isLikedByCurrentUser)")
         
         Task{
             //activityIndicator.startAnimating()
             do{
                 //Step 2A: Call API
                 let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                 
                 if(likePostResponseModel.success == true) {
                     
                     let data = likePostResponseModel.data
                     
                     let likeModel = LikeModel(
                         postLikeID: data.postLikeID,
                         postID: data.postID,
                         likedByUserName: data.likedByUserName,
                         likedByImage: data.likedByImage,
                         likedByFirstName: data.likedByFirstName,
                         likedByLastName: data.likedByLastName,
                         timestamp: data.timestamp,
                         friendshipStatus: data.friendshipStatus
                     )
                     
                     print(likeModel)
                     
                     post.isLikedByCurrentUser = true
                     print(" LIKE ")
                     print(post.simpleLikesArray)
                     print(" ")
                     print("____________________________________ ")

                 } else {
                     print(likePostResponseModel)
                     print("error dudee!")
                     
                 }
                 
                 //Error: Not expected
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
         
         post.isLikedByCurrentUser = true
     }
     
     //print(post.simpleLikesArray)
     print(" isLikedByCurrentUser \(post.isLikedByCurrentUser)")
     //print(post.postLikesArray)
 }

 */




//NEW CODE TO USE
/*
 protocol LikePostDelegate: AnyObject {
     func userDidLikePost(postID: Int, likeModel: LikeModel)
     func userDidUnlikePost(postID: Int, unlikedByUser: String)
 }

 
 class IndividualPostViewController: UIViewController {

     @IBOutlet weak var likeButton: UIButton!
     @IBOutlet weak var likeCountLabel: UILabel!
     
     var post: Post?

     override func viewDidLoad() {
         super.viewDidLoad()
         updateLikeButtonUI()
     }





 }

 */

//NOTES


 //print("likePostResponseModel")
 //print(likePostResponseModel.data)
 //print("likePostResponseModel")
 
/*
 print("unlikePostResponseModel")
 print(unlikePostResponseModel.message)
 print(unlikePostResponseModel.data)
 print("unlikePostResponseModel")
 {
     "postLikeID": 220,
     "postID": 722,
     "likedByUserName": "frodo",
     "likedByImage": "frodo.jpg",
     "likedByFirstName": "frodo",
     "likedByLastName": "v",
     "timestamp": "2025-04-08T23:36:10.000Z",
     "friendshipStatus": "friends"
 },
 
 LikeModel(postLikeID: 236, postID: 722, likedByUserName: "davey", likedByImage: "frodo.jpg", likedByFirstName: "David", likedByLastName: "Vasquez", timestamp: "2025-04-15T23:32:16.000Z", friendshipStatus: "you")
 */

/*
//flipButton(withString: "", on: sender)
likeCountLabel.text = String(simpleLikesArray.count + 1)
let likedImage = UIImage(named: "liked")
//let imageName = currentPost.isLikedByCurrentUser == true ? "liked" : "like"
//likeButton.setImage(UIImage(named: imageName), for: .normal)

likeButton.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
likeButton.imageView?.contentMode = .scaleAspectFit


if (likePostDelegate != nil) {
    print("DELEGATE: Individual Post VC You liked the Post with post ID \(post.postID) and group ID \(groupID)")
    likePostDelegate!.userLikePost(currentPostID: post.postID)
}
 */

/*
likeCountLabel.text = String(simpleLikesArray.count - 1)
let likedImage = UIImage(named: "like")
likeButton.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
likeButton.imageView?.contentMode = .scaleAspectFit

if (likePostDelegate != nil) {
    print("DELEGATE: Individual Post VC You unliked the Post with post ID \(post.postID) and group ID \(groupID)")
    likePostDelegate!.userUnlikePost(currentPostID: post.postID)
}
 */


/*
class ViewControllerEXAMPLE: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var postsArray: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        postsArray = fetchData() // Load your images
        tableView.reloadData()
    }

    //FUNCTIONS: API A mock API for our data
    func fetchData() -> [Post] {
        let post1 = Post(postImage: UIImage(named: "background_1")!, postCaption: "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.")
        let post2 = Post(postImage: UIImage(named: "tall")!, postCaption: "Good Morning! said Bilbo, and he meant it. The sun was shining, and the grass was very green. But Gandalf looked at him from under long bushy eyebrows that stuck out further than the brim of his shady hat.")
        let post3 = Post(postImage: UIImage(named: "background_3")!, postCaption: "Farewell they cried, Wherever you fare till your eyries receive you at the journey's end! That is the polite thing to say among eagles.")
        let post4 = Post(postImage: UIImage(named: "long")!, postCaption: "Surely you don’t disbelieve the prophecies, because you had a hand in bringing them about yourself? You don’t really suppose, do you, that all your adventures and escapes were managed by mere luck, just for your sole benefit? You are a very fine person, Mr. Baggins, and I am very fond of you; but you are only quite a little fellow in a wide world after all")
        let post5 = Post(postImage: UIImage(named: "background_2")!, postCaption: "Yes lets do it!!!")

        return [post1, post2, post3, post4, post5]
    }
    

}


//TABLE VIEW: Code to add table view information
extension ViewControllerEXAMPLE: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count // Use the count of images
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! IndividualPostCell
        let currentImage = postsArray[indexPath.row].postImage
        let postCaption = postsArray[indexPath.row].postCaption
        
        cell.updatePost(with: currentImage, postCaption: postCaption)
        
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostImage = postsArray[indexPath.row].postImage
        let postCaption = postsArray[indexPath.row].postCaption
        
        //STEP 1: Get Image Height
        let postImageHeight = round(getImageHeight(image: currentPostImage))
        
        //STEP 2: Get Caption Height
        let captionTextHeight = round(calculateLabelHeight(text: postCaption))
        
        
        print("POST \(indexPath.row)")
        print("postImageHeight \(postImageHeight)")
        print("captionTextHeight \(captionTextHeight)")
        print("Row Height \(postImageHeight  + captionTextHeight + 2)")
        print(" ")
      
        //footer + postImageHeight + captionTextHeight + 8 + comments
        return 10 + postImageHeight + captionTextHeight + 8 + 40
    }
}



import UIKit


class IndividualPostCellEXAMPLE: UITableViewCell {
    
    let headerView = createHeaderView()
    let bodyView = createBodyView()
    let footerView = createFooterView()
    let divider = createDividerView()
    let myImageView = createImageHeaderView()
    let myCaptionLabel = createLabelView()

    var postImageHeightConstraint: NSLayoutConstraint?
    var postCaptionHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(headerView)
        addSubview(bodyView)
        addSubview(footerView)
        addSubview(divider)
        headerView.addSubview(myImageView)
        bodyView.addSubview(myCaptionLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        postImageHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postImageHeightConstraint?.isActive = true

        postCaptionHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        postCaptionHeightConstraint?.isActive = true
        
 
        NSLayoutConstraint.activate([
            
            //Image
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            myImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            myImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0),
            myImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -0),
            myImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -0),

            //Text
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            myCaptionLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 0),
            myCaptionLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 4),
            myCaptionLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -4),
            myCaptionLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -0),
            
            //Comments
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 0),
            footerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -0),
            
            //Divider
            divider.topAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 0),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 10),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

    func updatePost(with currentImage: UIImage, postCaption: String) {
        let imageHeight = getImageHeight(image: currentImage)
        let captionHeight = round(calculateLabelHeight(text: postCaption))
        
        postImageHeightConstraint?.constant = imageHeight
        postCaptionHeightConstraint?.constant = captionHeight
        myImageView.image = currentImage
        myCaptionLabel.text = postCaption

        layoutIfNeeded() // Ensure layout is updated immediately
    }
}


func createImageHeaderView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}

func createHeaderView() -> UIView {
    let view = UIView()
    view.backgroundColor = .red
    
    return view

}

func createBodyView() -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
}

func createFooterView() -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    
    return view
}


func createDividerView() -> UIView {
    let view = UIView()
    view.backgroundColor = .black
    
    return view
}

func createLabelView() -> UILabel {
    let label = UILabel()
    label.text = "hi"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0 // Allow for multiple lines
    label.textAlignment = .center
    label.backgroundColor = .green

    
    return label
}

*/
