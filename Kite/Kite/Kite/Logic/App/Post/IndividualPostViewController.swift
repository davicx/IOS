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

    
    //STEP 1: Set up Table View
    let commentsTableView = UITableView()
    var comments: [String] = []
    
    
    //STEP 2: Set up UI Elements
    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let likeStackView = UIStackView()
    let dividerView = UIView()

    
    //Activity Indicator
    var activityIndicator = UIActivityIndicatorView(style: .medium)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        setInitialUI()
        
        //TEMP
        comments = [
            "This is an awesome post!",
            "Nice picture",
            "Where did you take this?",
            "Wow, I love the vibes here.",
            "Great shot!",
            "Great shot!",
            "Great shot!"
        ]
        commentsTableView.reloadData()
        //TEMP

    }
    
    
    func setUpViews() {
        guard let currentPost = currentPost else { return }

        //POST
        // Image View
        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postImage)
        
        // Caption Label
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.font = UIFont.systemFont(ofSize: 16)
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCaptionLabel)

        //Like Button
        let imageName = currentPost.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        // Like Count Label
        likeCountLabel.text = "0" // Default value
        likeCountLabel.font = UIFont.systemFont(ofSize: 18)
        likeCountLabel.textAlignment = .center
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        likeStackView.axis = .horizontal
        likeStackView.distribution = .fillEqually
        likeStackView.spacing = 8
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.addArrangedSubview(likeCountLabel)
        likeStackView.addArrangedSubview(likeButton)
        view.addSubview(likeStackView)
        
        // Divider View
        dividerView.backgroundColor = .blue
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dividerView)

        
        // Constraints
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),

            likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
            likeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            likeStackView.heightAnchor.constraint(equalToConstant: 40),
            
            dividerView.topAnchor.constraint(equalTo: likeStackView.bottomAnchor, constant: 8),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        //COMMENTS: Configure Comments Table View
        commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        commentsTableView.isScrollEnabled = true
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        commentsTableView.separatorStyle = .none
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 44
        
        view.addSubview(commentsTableView)

        // TableView Constraints
        NSLayoutConstraint.activate([
            commentsTableView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 8),
            commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        //ACTIVITY Indicator
        activityIndicator.center = view.center;
        view.addSubview(activityIndicator);
        
    }

    func setInitialUI() {
        if let selectedPost = currentPost {

            if let image = selectedPost.postImageData {
                postImage.image = image
            } else {

                postImage.image = UIImage(named: Constants.Image.fallbackPostImage)
            }

            postCaptionLabel.text = selectedPost.postCaption

            let currentLikeCount = selectedPost.simpleLikesArray?.count ?? 0
            likeCountLabel.text = "\(currentLikeCount)"
            
        } else {
            print("Error: currentPost is nil")
        }
    }

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let post = currentPost else {
            print("Error: currentPost is nil")
            return
        }

        let groupID: Int = post.groupID ?? 0

        if post.isLikedByCurrentUser == true {
            handleUnlike(post: post, groupID: groupID)
        } else {
            handleLike(post: post, groupID: groupID)
        }
    }
    
    
    //FUNCTIONS: Like Functions
    //Function 1: Handle Post Like
    func handleLike(post: Post, groupID: Int) {
        Task{
            do{
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    self.likeStackView.isUserInteractionEnabled = false
                }
                
                //STEP 1: Call API
                let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
                
                if(likePostResponseModel.success == true) {
  
                    let likeModel = likePostResponseModel.data
                    
                    //STEP 2: Update Current Post Values to add like
                    post.isLikedByCurrentUser = true
                    post.postLikesArray?.append(likeModel)
                    post.simpleLikesArray?.append(likeModel.likedByUserName)

                    DispatchQueue.main.async {
                       self.toggleLikeUI()
                       self.activityIndicator.stopAnimating()
                       self.likeStackView.isUserInteractionEnabled = true
                   }
                    
                } else {
                    print(likePostResponseModel)
                    print("error dudee!")
                    self.makeUIActiveAgain()
                    
                }
                
                //Error: Not expected
            } catch{
                print("yo man error!")
                print(error)
                
                self.makeUIActiveAgain()
                
            }
        }
    }


    
    //Function 2: Handle Post UnLike
    func handleUnlike(post: Post, groupID: Int) {
        Task{
            do{
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    self.likeStackView.isUserInteractionEnabled = false
                }
                //STEP 1: Call API
                let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: post.postID, groupID: groupID)

                //Success
                if(unlikePostResponseModel.success == true) {
                    print("SUCCESS: unlikePostResponseModel")
                    
                    let likeModel = unlikePostResponseModel.data
          
                    // STEP 2: Update Current Post Values to remove like
                    post.isLikedByCurrentUser = false

                    // Remove LikeModel with matching postLikeID
                    let likeIDToRemove = likeModel.postLikeID
                    post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeIDToRemove }
                    
                    // Remove username from simpleLikesArray
                    let currentUsername = unlikePostResponseModel.currentUser
                    post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != currentUsername }
                    
                    DispatchQueue.main.async {
                       self.toggleLikeUI()
                       self.activityIndicator.stopAnimating()
                       self.likeStackView.isUserInteractionEnabled = true
                   }
        
                //Error: Handled by API
                } else {
                    print("NOT SUCCESS: unlikePostResponseModel")
                    print(unlikePostResponseModel.data)
                    
                    self.makeUIActiveAgain()
                    
                }
     
            //Error: Not expected
            } catch {
                print("yo man error!")
                print(error)
                self.makeUIActiveAgain()
                
            }
        }
    }

    // Function 3: Handle Post UI Toggle
    func toggleLikeUI() {
        guard let post = currentPost else { return }

        // Determine new like count
        var likeCount = String(post.simpleLikesArray?.count ?? 0)
        
        if post.isLikedByCurrentUser == true {
            likeCountLabel.text = likeCount
            likeButton.setImage(UIImage(named: "liked"), for: .normal)
        } else {
            likeCountLabel.text = likeCount
            likeButton.setImage(UIImage(named: "like"), for: .normal)
        }

    }
    
    //Function 4: Finish API call
    func makeUIActiveAgain() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.likeStackView.isUserInteractionEnabled = true
        }
    }

    
}

extension IndividualPostViewController: UITableViewDataSource, UITableViewDelegate {

    // Number of rows = number of comments
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    // Populate each cell with comment data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        let comment = comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }

    // Optional: Set row height (or use auto layout in cell)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}




//NEW
/*
 class IndividualPostViewController: UIViewController, UITableViewDataSource {

     let tableView = UITableView()
     var comments: [String] = [
         "This is amazing!", "Love it", "What a great post!"
     ]

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         setUpTableView()
         setInitialUI()
     }

     func setUpTableView() {
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.dataSource = self
         tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
         view.addSubview(tableView)

         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])

         // Create the header view from your existing UI
         let headerView = UIView()
         headerView.translatesAutoresizingMaskIntoConstraints = false
         // add postImage, caption, likeStackView, dividerView like before
         // but to headerView instead of self.view

         // For example:
         headerView.addSubview(postImage)
         headerView.addSubview(postCaptionLabel)
         headerView.addSubview(likeStackView)
         headerView.addSubview(dividerView)
         // layout as before with constraints

         // Important: size the header view properly!
         let headerHeight: CGFloat = 400 + 200 + 40 + 8 + 2 // adjust based on your layout
         headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight)
         tableView.tableHeaderView = headerView
     }

     // MARK: - UITableViewDataSource
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return comments.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
         cell.configure(with: comments[indexPath.row])
         return cell
     }
 }

 */
