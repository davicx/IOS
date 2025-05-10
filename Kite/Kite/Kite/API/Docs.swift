//
//  Docs.swift
//  Kite
//
//  Created by David Vasquez on 2/20/25.
//

import Foundation
/*
extension IndividualPostViewController: CommentCellDelegate {
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        let commentIndex = indexPath.row - 1
        if let comment = currentPost.commentsArray?[commentIndex] {
            print("IndividualPostViewController: Current comment at index \(indexPath.row): \(comment.commentID)")
            
            if comment.commentLikedByCurrentUser == true {
                print("Should Unlike")
             
                //Call
                //handleUnLikeComment
                
            } else {
                print("Should Like")
                //Call
                //handleLikeComment
            }
            
        } else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
        }
    }
}
*/


/*
 extension IndividualPostViewController: CommentCellDelegate {
     func didTapLikeCommentButton(in cell: CommentCell) {
         guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

         let commentIndex = indexPath.row - 1
         guard var comment = currentPost.commentsArray?[commentIndex] else { return }

         // Simulate Like/Unlike toggle
         comment.commentLikedByCurrentUser = !(comment.commentLikedByCurrentUser ?? false)
         
         // Update the array so it's in sync
         currentPost.commentsArray?[commentIndex] = comment

         // Update the UI
         cell.configureComment(with: comment)
     }
 }
 */



/*
extension IndividualPostViewController: CommentCellDelegate {
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        cell.startLoading()

        let commentIndex = indexPath.row - 1
        var comment = currentPost.commentsArray?[commentIndex]

        guard let unwrappedComment = comment else { return }

        if unwrappedComment.commentLikedByCurrentUser == true {
            handleUnLikeComment(comment: unwrappedComment, postID: unwrappedComment.postID ?? 0, groupID: unwrappedComment.groupID ?? 0) {
                DispatchQueue.main.async {
                    // Update the local model and reload cell
                    self.currentPost.commentsArray?[commentIndex].commentLikedByCurrentUser = false
                    if let count = self.currentPost.commentsArray?[commentIndex].commentLikeCount, count > 0 {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = count - 1
                    }
                    cell.configureComment(with: self.currentPost.commentsArray![commentIndex])
                }
            }
        } else {
            handleLikeComment(comment: unwrappedComment, postID: unwrappedComment.postID ?? 0, groupID: unwrappedComment.groupID ?? 0) {
                DispatchQueue.main.async {
                    // Update the local model and reload cell
                    self.currentPost.commentsArray?[commentIndex].commentLikedByCurrentUser = true
                    if let count = self.currentPost.commentsArray?[commentIndex].commentLikeCount {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = count + 1
                    } else {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = 1
                    }
                    cell.configureComment(with: self.currentPost.commentsArray![commentIndex])
                }
            }
        }
    }
}
*/


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


//print("heightForRowAt postImageHeight \(postImageHeight) postCaptionHeight \(postCaptionHeight)")
//print(" ")
//print("We need this for our Caption Height \(postCaptionHeight) \(currentPost.postID)")
//print(postCaption)

//footer + postImageHeight + captionTextHeight + 8 + comments
//return 10 + postImageHeight + captionTextHeight + 8 + 40

//Post User + Post Image + Post Socials + Post Caption + divider
/*
 
 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

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

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
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
                 print("STEP 2: postsResponseModel")
                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                 
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                 print("TOTAL POSTS \(postsArray.count)")

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
     
     // TableView Setup
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }

     // Data Passing with Segue
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let postViewController = segue.destination as? SinglePostViewController,
            let selectedPost = sender as? Post {
             postViewController.currentPost = selectedPost
         }
     }
 }


 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
         let post = postsArray[indexPath.row]
         cell.updatePost(with: post)
         return cell
     }

      
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }
 }

 */

/*
//WORKS CURRENT
class HomeViewController: UIViewController {
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    let userDefaultManager = UserDefaultManager()

    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()

    @IBOutlet weak var postsTableView: UITableView!

    // Timer for polling
    var pollingTimer: Timer?
    var failureCount = 0
    var isPollingPaused = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial data fetch
        fetchPosts()

        // Start polling for updates
        startPolling()

        setupTableView()
    }

    // Function to fetch posts from API
    func fetchPosts() {
        guard !isPollingPaused else {
            print("Polling is paused, skipping fetch")
            return
        }

        print("STEP 1: fetchPosts")
        Task {
            do {
                print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
               
                // Process posts and add images from S3
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                // Reload table view with new posts
                postsTableView.reloadData()

                // Reset failure count on success
                failureCount = 0
            } catch {
                print("Error fetching posts: \(error)")
                handlePollingFailure()
            }
        }
    }
    
    
    //DATA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let postViewController = segue.destination as? PostViewController,
           let selectedPost = sender as? Post {
            postViewController.currentPost = selectedPost
        }
    }

    

    // Function to start polling
    func startPolling() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.fetchPosts()
        }
    }

    // Handle failures in polling
    func handlePollingFailure() {
        failureCount += 1
        print("Polling failure count: \(failureCount)")

        if failureCount >= 3 {
            pausePolling(for: 300) // Pause for 5 minutes
        }

        if failureCount >= 4 {
            stopPolling()
            print("Polling stopped after multiple failures.")
        }
    }

    // Pause polling for a specified time interval
    func pausePolling(for seconds: TimeInterval) {
        print("Pausing polling for \(seconds) seconds")
        isPollingPaused = true
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.isPollingPaused = false
            print("Resuming polling after pause")
        }
    }

    // Stop polling entirely
    func stopPolling() {
        pollingTimer?.invalidate()
        pollingTimer = nil
        print("Polling has been stopped permanently.")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingTimer?.invalidate()  // Stop polling when the view disappears
    }

    // TABLEVIEW
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.estimatedRowHeight = 250
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
        cell.setPost(post: post)

        return cell
    }

    // DATA SEND: Send Data to New Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
    }
}
 */






//WORKING: But polling does not ever stop
/*
class HomeViewController: UIViewController {
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    let userDefaultManager = UserDefaultManager()

    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()
    
    @IBOutlet weak var postsTableView: UITableView!
    
    // Timer for polling
    var pollingTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let groupID = 72

        // Initial data fetch
        fetchPosts()

        // Start polling for updates every 10 seconds
        startPolling()

        setupTableView()
    }

    // Function to fetch posts from API
    func fetchPosts() {
        print("STEP 1: fetchPosts")
        Task {
            do {
                print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                print(postsResponseModel)
                
                // Process posts and add images from S3
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                // Reload table view with new posts
                postsTableView.reloadData()
            } catch {
                print("Error fetching posts: \(error)")
            }
        }
    }

    // Function to start polling
    func startPolling() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.fetchPosts()  // Fetch new posts every 10 seconds
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingTimer?.invalidate()  // Stop polling when the view disappears
    }

    // TABLEVIEW
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.estimatedRowHeight = 250
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
    }
    
    // DATA SEND: Send Data to New Cell
    var currentPost: Post!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let destinationVC = segue.destination as? PostViewController,
           let postToSend = sender as? Post {
            destinationVC.currentPost = postToSend
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
        cell.setPost(post: post)

        return cell
    }

    // DATA SEND: Send Data to New Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
    }
}
*/



//WITH LOGIC PULLED OUT and MOVED TO loginFunctions
/*
 class LoginViewController: UIViewController, LoginLayoutManagerDelegate {
     let layoutManager = LoginLayoutManager()
     let loginManager = LoginManager()
     let userDefaultManager = UserDefaultManager()
     var activityIndicator = UIActivityIndicatorView()
     var errrorMessage = ""
     
     override func viewDidLoad() {
         super.viewDidLoad()
         print("LoginViewController")
         
         layoutManager.delegate = self
         layoutManager.setupViews(in: view)
         layoutManager.setupConstraints(in: view)
         layoutManager.setupTextFields()
         layoutManager.setupButtons(in: view)
         setupElements()
     }
     
     func setupElements() {
         activityIndicator.center = self.view.center
         activityIndicator.hidesWhenStopped = true
         activityIndicator.style = UIActivityIndicatorView.Style.medium
         self.view.addSubview(activityIndicator)
     }
     
     func didTapLoginButton() {
         print("Login Button Tapped")
         
         let logInUser = layoutManager.usernameTextField.text ?? ""
         let logInPassword = layoutManager.passwordTextField.text ?? ""
         
         // Validate inputs
         let validUsername = validateUserName(userName: logInUser)
         let validPassword = validatePassword(password: logInPassword)
         
         if !validUsername || !validPassword {
             print("Invalid username or password.")
             return
         }
         
         let deviceID = KeychainHelper.shared.getOrCreateDeviceId()
         print("Device ID:", deviceID)
         
         activityIndicator.startAnimating()
         view.isUserInteractionEnabled = false
         
         loginManager.login(username: logInUser, password: logInPassword, deviceID: deviceID) { success, message in
             DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating()
                 self.view.isUserInteractionEnabled = true
                 print(message)
                 
                 if success {
                     PresenterManager.shared.showMainApp()
                 }
             }
         }
     }
     
     func didTapForgotPasswordButton() {
         print("Forgot Password")
     }
 }

 */



//CURRENT WORKS!!
/*
class LoginViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    let loginAPI = LoginAPI()
    
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""
    
    
    //VIEWS
    let logoView = UIView()
    let loginView = UIView()
    let dividerView = UIView()
    let registerView = UIView()
    let footerView = UIView()
    
    //LABELS
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        setupElements()
        setupViews()
        setupConstraints()
        setupLoginLabels()
    }
    
    func setupElements() {
        
        //LABELS
        //Style.styleUsernameLabel(usernameLabel)
        //Style.styleUsernameLabel(passwordLabel)
        
        //BUTTONS
        //Buttons.styleForgotPasswordButton(forgotPasswordButton)
        //Buttons.styleLoginButton(loginButton)
        
        //Error Label
        //loginMessageLabel.alpha = 0
        
        //Style Buttons and Fields
        //Temp.styleTextField(userNameTextField)
        //Temp.styleTextField(passwordTextField)
        
        //Buttons.styleLoginFilledButton(loginButtonStyle)
        
        //Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)

    }
    
    
    
    
    func setupViews() {
        logoView.backgroundColor = .systemBlue
        loginView.backgroundColor = .white
        dividerView.backgroundColor = .gray
        registerView.backgroundColor = .systemGreen
        footerView.backgroundColor = .lightGray
        
        [logoView, loginView, dividerView, registerView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               // LogoView - 20%
               logoView.topAnchor.constraint(equalTo: view.topAnchor),
               logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               logoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

               // LoginView - 20%
               loginView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
               loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.375),
               
               // DividerView - 15%
               dividerView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
               dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               dividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),
               
               // RegisterView - 15%
               registerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
               registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               registerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

               // FooterView - Remaining 30%
               footerView.topAnchor.constraint(equalTo: registerView.bottomAnchor),
               footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }

    func setupLoginLabels() {
        // Configure text fields
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true // Hide password input
        
        Style.styleLoginTextField(usernameTextField)
        Style.styleLoginTextField(passwordTextField)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginView.addSubview(usernameTextField)
        loginView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            // Username TextField - 12 from top
            usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
            usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 320),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField - 20 below username
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

    
        //STEP 1: Get Login Information
        let logInUser = usernameTextField.text ?? ""
        let logInPassword = passwordTextField.text ?? ""
   
        
        //STEP 2: Validate Login Information
        let validUsername = validateUserName(userName: logInUser)
        let validPassword = validatePassword(password: logInPassword)
        
        //STEP 3: Login User
        if(validUsername == true && validPassword == true) {
            
            //let deviceID = getDeviceId()
            let deviceID = KeychainHelper.shared.getOrCreateDeviceId()

            print("Device ID:", deviceID)

            Task{
                do{
                    //Get Posts from the API
                    activityIndicator.startAnimating()
                    view.isUserInteractionEnabled = false
                    let loginResponseModel = try await loginAPI.loginUser(username: logInUser, password: logInPassword, deviceID: deviceID)
                    
                    activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                    
                    //API
                    if(loginResponseModel.data.loginSuccess == true) {
                        
                        //Local Storage
                        let loginOutcome = userDefaultManager.logUserIn(userName: logInUser)
                        
                        if(loginOutcome) {
                            print("You just logged \(logInUser) in")
                            print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                            
                            PresenterManager.shared.showMainApp()
                            
                        } else {
                            print("Was an error logging in!")
                        }
                    } else {
                        //Make this the error message
                        //loginMessageLabel.alpha = 1
                        //loginMessageLabel.text = "Username or Password was wrong!"
                        print("Username or Password was wrong!")
                    }
                } catch{
                    print("yo man error!")
                    print(error)
                }
            }
            
        //STEP 3: The user did not enter information
        } else {
            if(validUsername == false && validPassword == true) {
                errrorMessage = "STEP 2: Please enter a Valid username"
                print("STEP 2: Please enter a Valid username")
            } else if(validPassword == false && validUsername == true) {
                errrorMessage = "STEP 2: Please enter a Valid password"
                print("STEP 2: Please enter a Valid password")
            } else if (validPassword == false && validUsername == false){
                errrorMessage = "STEP 2: Please enter a Valid username and password"
                print("STEP 2:  Please enter a Valid username and password")
            }
            
            //Make this the error message
            //loginMessageLabel.alpha = 1
            //loginMessageLabel.text = errrorMessage
        
        }
         
    
    }

    
    @IBAction func registerButton(_ sender: UIButton) {
        print("Register")
    }
    
    
    func loginUser(username: String, password: String, deviceID: String) async throws -> String {
        var outcome = ""
        do {
            
            let loginResponseModel = try await loginAPI.loginUser(username: username, password: password, deviceID: deviceID)
            if loginResponseModel.data.loginSuccess {
                let loginOutcome = userDefaultManager.logUserIn(userName: username)
                if loginOutcome {
                    print("You just logged \(username) in successfully.")
                    
                    outcome = "You just logged \(username) in successfully."
                    return outcome
                    
                } else {
                    outcome = "There was an error logging in!"
                    print("There was an error logging in!")
                    return outcome
                }
            } else {
                print("API returned an error during login!")
                outcome = "API returned an error during login!"
                return outcome
            }
        } catch {
            print("An error occurred during login: \(error.localizedDescription)")
            outcome = "An error occurred during login: \(error.localizedDescription)"
            return outcome
        }
    }

    
}
 
 
 
 */



//FULL CODE
/*
 import UIKit

 class LoginViewController: UIViewController {
     
     private let forgotPasswordButton: UIButton = {
         let button = UIButton()
         button.setTitle("Forgot Password?", for: .normal)
         button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = .clear
         return button
     }()
     
     private let loginButton: UIButton = {
         let button = UIButton()
         button.setTitle("Login", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = UIColor(hex: "#3797EF")
         button.layer.cornerRadius = 5
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.addSubview(forgotPasswordButton)
         view.addSubview(loginButton)
         
         setupConstraints()
     }
     
     private func setupConstraints() {
         forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
         loginButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             forgotPasswordButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             
             loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
             loginButton.widthAnchor.constraint(equalToConstant: 200),
             loginButton.heightAnchor.constraint(equalToConstant: 40)
         ])
     }
 }

 // UIColor Extension for Hex Colors
 extension UIColor {
     convenience init(hex: String) {
         var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
         hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

         var rgb: UInt64 = 0
         Scanner(string: hexSanitized).scanHexInt64(&rgb)

         let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
         let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
         let b = CGFloat(rgb & 0xFF) / 255.0

         self.init(red: r, green: g, blue: b, alpha: 1.0)
     }
 }

 */

/*
 @IBOutlet weak var startLabel: UILabel!
 
 var activityIndicator = UIActivityIndicatorView()

 
 override func viewDidLoad() {
     super.viewDidLoad()
     activityIndicator.center = self.view.center
     activityIndicator.hidesWhenStopped = true
     activityIndicator.style = UIActivityIndicatorView.Style.medium
     self.view.addSubview(activityIndicator)
     
 }


 @IBAction func startButton(_ sender: UIButton) {
     print("start")
     activityIndicator.startAnimating()
     startLabel.text = "Getting some posts man!"
     view.isUserInteractionEnabled = false
     
     Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
         self.activityIndicator.stopAnimating()
         self.view.isUserInteractionEnabled = true
         self.startLabel.text = "Got them posts dude!"
     }
 }
 

 // Optionally disable specific controls like buttons
 //actionButton.isEnabled = false


 @IBAction func stopButton(_ sender: UIButton) {
     print("stop")
     startLabel.text = "I am Stopped"
     activityIndicator.stopAnimating()

 }
 
 */


//WORKS
/*
func setupTextFields() {
    usernameTextField.placeholder = "Username"
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    
    Style.styleLoginTextField(usernameTextField)
    Style.styleLoginTextField(passwordTextField)
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    loginView.addSubview(usernameTextField)
    loginView.addSubview(passwordTextField)
    
    NSLayoutConstraint.activate([
        usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
        usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
        usernameTextField.widthAnchor.constraint(equalToConstant: 320),
        usernameTextField.heightAnchor.constraint(equalToConstant: 40),
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
        passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
        passwordTextField.widthAnchor.constraint(equalToConstant: 320),
        passwordTextField.heightAnchor.constraint(equalToConstant: 40)
    ])
}
*/


/*
 HomeViewController
 //WORKING: But polling does not ever stop
 /*
 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()
     
     @IBOutlet weak var postsTableView: UITableView!
     
     // Timer for polling
     var pollingTimer: Timer?
     
     override func viewDidLoad() {
         super.viewDidLoad()
         let groupID = 72

         // Initial data fetch
         fetchPosts()

         // Start polling for updates every 10 seconds
         startPolling()

         setupTableView()
     }

     // Function to fetch posts from API
     func fetchPosts() {
         print("STEP 1: fetchPosts")
         Task {
             do {
                 print("STEP 2: postsResponseModel")
                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                 print(postsResponseModel)
                 
                 // Process posts and add images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                 // Reload table view with new posts
                 postsTableView.reloadData()
             } catch {
                 print("Error fetching posts: \(error)")
             }
         }
     }

     // Function to start polling
     func startPolling() {
         pollingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
             self?.fetchPosts()  // Fetch new posts every 10 seconds
         }
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         pollingTimer?.invalidate()  // Stop polling when the view disappears
     }

     // TABLEVIEW
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }
     
     // DATA SEND: Send Data to New Cell
     var currentPost: Post!
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let destinationVC = segue.destination as? PostViewController,
            let postToSend = sender as? Post {
             destinationVC.currentPost = postToSend
         }
     }
 }

 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
         cell.setPost(post: post)

         return cell
     }

     // DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }
 }
 */



 
 //CHAT
 /*
  import UIKit

  class MakePostViewController: UIViewController {
      
      let userDefaultManager = UserDefaultManager()
      let postAPI = PostAPI()
      
      @IBOutlet weak var postImageView: UIImageView!
      @IBOutlet weak var captionTextField: UITextField!
      @IBOutlet weak var postButton: UIButton!
      
      var selectedImage: UIImage?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          postImageView.isUserInteractionEnabled = true
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
          postImageView.addGestureRecognizer(tapGesture)
      }
      
      @objc func selectImage() {
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          picker.allowsEditing = true
          present(picker, animated: true)
      }
      
      @IBAction func makePostButtonTapped(_ sender: UIButton) {
          guard let postImage = selectedImage, let caption = captionTextField.text, !caption.isEmpty else {
              print("Image and caption are required")
              return
          }
          
          Task {
              do {
                  let currentUser = userDefaultManager.getLoggedInUser()
                  let response = try await postAPI.makePhotoPost(postImage: postImage, postFrom: currentUser, postTo: "some_destination", postCaption: caption, groupID: 1, listID: 1)
                  print("Post successful: \(response)")
                  navigationController?.popViewController(animated: true)
              } catch {
                  print("Failed to make post: \(error)")
              }
          }
      }
  }

  extension MakePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[.editedImage] as? UIImage {
              postImageView.image = selectedImage
              self.selectedImage = selectedImage
          }
          picker.dismiss(animated: true)
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true)
      }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  */
 /*
  //
  //  EditProfileViewController.swift
  //  Kite
  //
  //  Created by David Vasquez on 1/12/25.
  //

  import UIKit


  protocol EditProfileViewControllerDelegate: AnyObject {
      //func didUpdateProfile(firstName: String, lastName: String, biography: String)
      func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?)

  }


  class EditProfileViewController: UIViewController {
      let profileAPI = ProfileAPI()
      let userDefaultManager = UserDefaultManager()

      @IBOutlet weak var userImageView: UIImageView!
      @IBOutlet weak var userNameField: UITextField!
      @IBOutlet weak var userFullNameField: UITextField!
      @IBOutlet weak var userBiographyTextArea: UITextView!
      
      //Incoming Data
      var inputFirstName: String! //First Name
      var inputLastName: String! //Last Name
      var inputBiography: String!
      var inputProfileImage: UIImage?
     
      // Delegate property
      weak var delegate: EditProfileViewControllerDelegate?
      
      var selectedProfileImage: UIImage?

      override func viewDidLoad() {
          super.viewDidLoad()
          let firstName: String = inputFirstName ?? ""
          let lastName : String = inputLastName ?? ""
          let biography : String = inputBiography ?? ""
          
          if let profileImage = inputProfileImage {
              userImageView.image = profileImage
          }
          
          userNameField.text = firstName
          userFullNameField.text = lastName
          userBiographyTextArea.text = biography
          
      }

      @IBAction func editPhotoButton(_ sender: UIButton) {
          let vc = UIImagePickerController()
          vc.sourceType = .photoLibrary
          vc.delegate = self
          vc.allowsEditing = true
          present(vc, animated: true)
      }
      
      
      
      @IBAction func saveButtonTapped(_ sender: UIButton) {
          let currentUser = userDefaultManager.getLoggedInUser()
          let updatedFirstName = userNameField.text ?? ""
          let updatedLastName = userFullNameField.text ?? ""
          let updatedBiography = userBiographyTextArea.text ?? ""

           //TYPE 1: Image Not Updated
           if selectedProfileImage == nil || selectedProfileImage == inputProfileImage {
               print("TYPE 1: Image is the same")
               
               Task {
                   do {
                       let updatedProfileResponse = try await profileAPI.updateUserProfileAPI(
                           currentUser: currentUser,
                           imageName: "currentUser",
                           firstName: updatedFirstName,
                           lastName: updatedLastName,
                           biography: updatedBiography
                       )

                       // Notify the delegate with the updated data
                       delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: nil)

                       // Go back to ProfileViewController
                       navigationController?.popViewController(animated: true)
                   
                   } catch {
                       print("Failed to update profile: \(error)")
                   }
               }
               
           //TYPE 2: Image Updated
           } else {
               print("TYPE 2: Image Changed")
               guard let newProfileImage = selectedProfileImage else {
                    print("No new image selected. Skipping image update.")
                    return
                }
               
               Task {
                   do {
                       let updatedProfileResponse = try await profileAPI.updateFullUserProfileAPI(currentUser: currentUser, profileImage: newProfileImage, firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)

                       // Notify the delegate with the updated data
                       //delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)
                       delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: newProfileImage)

                       // Go back to ProfileViewController
                       navigationController?.popViewController(animated: true)
                   
                   } catch {
                       print("Failed to update profile: \(error)")
                   }
               }
           }
       

      }

    
      
      // New function to handle full profile update when image is changed
      func fullProfileUpdate() {
          print("Updating full profile with new image...")
          // Mock function to handle full profile update
          // You can replace this with the actual API call
      }

  }


  extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
              print("You picked an image! dude!")
              userImageView.image = selectedImage
              selectedProfileImage = selectedImage
          }
          print("Here some info DUDE \(info)")
          picker.dismiss(animated: true)
      }
      
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          print("ah never mind dude!")
          picker.dismiss(animated: true)
      }
  }


  */
 /*
  //
  //  ViewController.swift
  //  sendFormDataToAPI
  //
  //  Created by David Vasquez on 8/11/24.
  //

  import UIKit


  class ViewController: UIViewController {

      let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
      let imageOne: UIImage = UIImage(named: "lake")!
      let imageTwo: UIImage = UIImage(named: "lake_png")!
      
      @IBOutlet weak var imageView: UIImageView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          
      }
      
      
      @IBAction func newPhotoPostButton(_ sender: UIButton) {
          print("hi")

          imageView.image = imageOne
          
          Task{
              do{
                  //Get Posts from the API
                  let newPostResponseModel = try await uploadPhotoPost(postImage: imageOne, postFrom: "davey", postTo: "sam", postCaption: "Hiya!!", groupID: 72, listID: 0)
       
                  print(" ")
                  print("RETURNED")
                  print(newPostResponseModel)
                  print("SUCCESS")
              } catch{
                  print("yo man error!")
                  print(error)
              }
          }
     
     
      }
      
      func uploadPhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
          let postType = "photo"
          let masterSite = "kite"
          let notificationMessage = "Posted a Photo"
          let notificationType = "new_post_photo"
          let notificationLink = "http://localhost:3003/posts/group/72"
          
              
          //STEP 1: Create the URL
          let endpoint = "http://localhost:3003/post/photo/local"
          
          guard let url = URL(string: endpoint) else {
              throw networkError.invalidURL
          }
          
          //STEP 2: Create the Request
          var request = URLRequest(url: url)
          let boundary = UUID().uuidString
          request.httpMethod = "POST"
          request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
          
          //STEP 3: Create the Form Data and Photo
          let body = NSMutableData()

      
          //Post Type
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postType\"\r\n\r\n")
          body.appendString("\(postType)\r\n")
              
          //Master Site
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"masterSite\"\r\n\r\n")
          body.appendString("\(masterSite)\r\n")

          //Post From
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postFrom\"\r\n\r\n")
          body.appendString("\(postFrom)\r\n")
          
          //Post To
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postTo\"\r\n\r\n")
          body.appendString("\(postTo)\r\n")
         
          //Group ID
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"groupID\"\r\n\r\n")
          body.appendString("\(groupID)\r\n")
          
          //List ID
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"listID\"\r\n\r\n")
          body.appendString("\(listID)\r\n")
          
          //Post Caption
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
          body.appendString("\(postCaption)\r\n")
          
          //Notification Message
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationMessage\"\r\n\r\n")
          body.appendString("\(notificationMessage)\r\n")
          
          //Notification Type
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationType\"\r\n\r\n")
          body.appendString("\(notificationType)\r\n")
          
          //Notification Link
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationLink\"\r\n\r\n")
          body.appendString("\(notificationLink)\r\n")
      
          if let imageData = postImage.jpegData(compressionQuality: 1.0) {
              body.appendString("--\(boundary)\r\n")
              body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
              body.appendString("Content-Type: image/jpeg\r\n\r\n")
              body.append(imageData)
              body.appendString("\r\n")
          }
          
          body.appendString("--\(boundary)--\r\n")
          
          request.httpBody = body as Data
          
          //STEP 4: Handle the Response
          let (data, response) = try await URLSession.shared.data(for: request)
                 
          guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
              throw networkError.invalidResponse
          }
          
          do {
              let decoder = JSONDecoder ()
              let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

              print("API")
              print(newPostResponseModel)
              print("API")
              return newPostResponseModel
              
          } catch {
              let newPostResponseModel = NewPostResponseModel()
              print("Error decoding data")
              print(newPostResponseModel)
              return newPostResponseModel
              
          }
      }

  }



  // Extension to NSMutableData for convenience
  extension NSMutableData {
      func appendString(_ string: String) {
          if let data = string.data(using: .utf8) {
              append(data)
          }
      }
  }



  enum networkError: Error {
      case invalidURL
      case invalidResponse
      case invalidData
  }

  */



 /*

 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()

     
     @IBOutlet weak var postsTableView: UITableView!
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         let groupID = 72

         Task{

             do{

                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
                 //print(postsResponseModel)
                 
                 //Add Post Images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
    
                 for post in postsArray {
                     //print("POST: \(post.postCaption) \(post.fileUrl)")
                 }
                 
                 postsTableView.reloadData()

             } catch{
                 print("yo man error!")
                 print(error)
             }
         }

         setupTableView()
         
     }

     //TABLEVIEW
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }
     
     //DATA SEND: Send Data to New Cell
     var currentPost:Post!
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let destinationVC = segue.destination as? PostViewController,
            let postToSend = sender as? Post {
             destinationVC.currentPost = postToSend
         }
     }
     
 }

 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
         cell.setPost(post: post)

         return cell
     }

     
     //DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }

 }


 */

 */


/*
 protocol InputDelegate {
     func userLikePost(currentPostID: Int)
     func userUnlikePost(currentPostID: Int)
 }


 class IndividualPostViewController: UIViewController {
     var myDelegate: InputDelegate? = nil
     let postAPI = PostsAPI()
     var selectedPost = Post(postID: 0)
     var currentUser = "davey"

     @IBOutlet weak var postImage: UIImageView!
     @IBOutlet weak var postCaptionLabel: UILabel!
     @IBOutlet weak var postLikeCountLabel: UILabel!
     @IBOutlet weak var postLikeButtonStyle: UIButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()

         setUpView(selectedPost: selectedPost)
         
         
     }
     

     //SETUP: Setup the view
     func setUpView(selectedPost: Post) {
         let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         postImage.image = selectedPost.postImageData
         postCaptionLabel.text = selectedPost.postCaption
         postLikeCountLabel.text = String(likeCount)

  
         //Like Button
         if simpleLikesArray.contains(currentUser) {
             //print("User has liked the post so text should be UNLIKE")
             let likedImage = UIImage(named: "liked")
             postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
             postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
           
         } else {
             print("User has NOT liked the post so text should be LIKE")
             let likedImage = UIImage(named: "like")
             postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
             postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
           
         }
         

     }


     @IBAction func postLikeButton(_ sender: UIButton) {
         let activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.center = view.center;
         view.addSubview(activityIndicator);
         
         
         //STEP 1: Determine if Post is Already Liked
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         let groupID : Int = selectedPost.groupID ?? 0
         
         //STEP 2A: Make Call to API to Like a Post
         if !simpleLikesArray.contains(currentUser) {
             //print("Like Me")
             Task{
                 //activityIndicator.startAnimating()
                 do{
                     let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                     
                     //Success
                     if(likePostResponseModel.success == true) {
                         //flipButton(withString: "", on: sender)
                         postLikeCountLabel.text = String(simpleLikesArray.count + 1)
                         let likedImage = UIImage(named: "liked")
                         postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                         postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                       
                         
                         if (myDelegate != nil) {
                             print("DELEGATE: Individual Post VC You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                         }
                         
                         //Error: Handled by API
                     } else {
                         print("error dudee!")
                         
                     }
                     
                     //Error: Not expected
                 } catch{
                     print("yo man error!")
                     print(error)
                 }
             }
         
         //STEP 2B: Make Call to API to Unlike a Post
         } else {
             //print("Already Liked")
             Task{
                 do{
                     let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                     
                     //Success
                     if(unlikePostResponseModel.success == true) {
                         
                         postLikeCountLabel.text = String(simpleLikesArray.count - 1)
                         let likedImage = UIImage(named: "like")
                         postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                         postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                       
                         if (myDelegate != nil) {
                             print("DELEGATE: Individual Post VC You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                         }
                         
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
     
    
 }

 /*
  @IBOutlet weak var startLabel: UILabel!
  var activityIndicator = UIActivityIndicatorView()

  
  override func viewDidLoad() {
      super.viewDidLoad()
      activityIndicator.center = self.view.center
      activityIndicator.hidesWhenStopped = true
      activityIndicator.style = UIActivityIndicatorView.Style.medium
      self.view.addSubview(activityIndicator)
      
      
  }


  @IBAction func startButton(_ sender: UIButton) {
      print("start")
      activityIndicator.startAnimating()
      startLabel.text = "Getting some posts man!"
      view.isUserInteractionEnabled = false
      
      Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
          self.activityIndicator.stopAnimating()
          self.view.isUserInteractionEnabled = true
          self.startLabel.text = "Got them posts dude!"
      }
  }
  

  // Optionally disable specific controls like buttons
  //actionButton.isEnabled = false


  @IBAction func stopButton(_ sender: UIButton) {
      print("stop")
      startLabel.text = "I am Stopped"
      activityIndicator.stopAnimating()

  }
  
  */


 /*

  import UIKit

  protocol InputDelegate {
      func userLikePost(currentPostID: Int)
      func userUnlikePost(currentPostID: Int)
  }


  class IndividualPostViewController: UIViewController {
      var myDelegate: InputDelegate? = nil
      
      let postAPI = PostsAPI()
      var selectedPost = Post(postID: 0)
      var currentUser = "davey"

      @IBOutlet weak var singlePostImageView: UIImageView!
      @IBOutlet weak var singlePostLabel: UILabel!
      @IBOutlet weak var likeCountLabel: UILabel!
      @IBOutlet weak var likeButtonTextOutlet: UIButton!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setUpView(selectedPost: selectedPost)
          
      }
      
      @IBAction func likePostButton(_ sender: UIButton) {
          
          //STEP 1: Determine if Post is Already Liked
          let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
          let groupID : Int = selectedPost.groupID ?? 0
          
          //STEP 2A: Make Call to API to Like a Post
          if !simpleLikesArray.contains(currentUser) {
              Task{
                  do{
                      let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
      
                      //Success
                      if(likePostResponseModel.success == true) {
                          flipButton(withString: "", on: sender)
                          likeCountLabel.text = String(simpleLikesArray.count + 1)
                          
                          if (myDelegate != nil) {
                              print("You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                              myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                          }
                          
                      //Error: Handled by API
                      } else {
                          print("error dudee!")
                          
                      }
                  
                  //Error: Not expected
                  } catch{
                      print("yo man error!")
                      print(error)
                  }
              }
          
          //STEP 2B: Make Call to API to Unlike a Post
          } else {
              Task{
                  do{
                      let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                      
                      //Success
                      if(unlikePostResponseModel.success == true) {
                          
                          likeCountLabel.text = String(simpleLikesArray.count - 1)
        
                          if (myDelegate != nil) {
                              print("You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                              myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                          }
                          
                      //Error: Handled by API
                      } else {
                          print("error dudee!")
                          
                      }
           
                  //Error: Not expected
                  } catch{
                      print("yo man error!")
                      print(error)
                  }
              }

          }
      }
      

      //BUTTON: Handle Button UI Change
      func flipButton(withString addFriend: String, on button: UIButton) {
          if button.currentTitle == "Like" {
              button.setTitle("UnLike", for: UIControl.State.normal)
          } else {
              button.setTitle("Like", for: UIControl.State.normal)
          }
      }
      

      //SETUP: Setup the view
      func setUpView(selectedPost: Post) {
          let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
          let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
          //print("LIKES \(simpleLikesArray.count)")
          
          //SETUP: Set Like Text on the Button for Like or Unlike
          if simpleLikesArray.contains(currentUser) {
              //print("User has liked the post so text should be UNLIKE")
              likeButtonTextOutlet.setTitle("Unlike", for: .normal)
          } else {
              //print("User has NOT liked the post so text should be LIKE")
              likeButtonTextOutlet.setTitle("Like", for: .normal)
          }
          
          singlePostImageView.image = selectedPost.postImageData
          singlePostLabel.text = selectedPost.postCaption
          likeCountLabel.text = String(likeCount)
      }
      
  }





//Get Posts
/*
Task{
    do{
        //Get Posts from the API
        let postResponseModel = try await postsAPI.getPostsAPI()
        print(postResponseModel.data[0].postCaption)
        
        
    } catch{
        print("yo man error!")
        print(error)
    }
}
 */

/*
 
 @IBAction func getLoginStatusTemp(_ sender: UIButton) {
     let loginStatus = userDefaultManager.getLoggedInUserStatus()
     print("User is Logged in \(loginStatus)")
 }
 
 
 @IBAction func logoutButton(_ sender: UIButton) {
     let loggedInUser = userDefaultManager.getLoggedInUser()
     AuthManager.shared.logoutCurrentUser()
  
 }
 */
/*
 Task{
     do{
         //Get Posts from the API
         let loginResponseModel = try await loginAPI.loginUser(username: "davey", password: "password")
        
         //API
         if(loginResponseModel.data.loginSuccess == true) {
             
             //Local Storage
             let loginOutcome = userDefaultManager.logUserIn(userName: loggedInUser)
             
             if(loginOutcome) {
                 print("You just logged \(loggedInUser) in")
                 print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                 
             } else {
                 print("Was an error logging in!")
             }
             
             
         } else {
             print("API Was an error logging in!")
         }
         
     } catch{
         print("yo man error!")
         print(error)
     }
 }



//STEP 1: Set User Defaults
let loginOutcome = userDefaultManager.logUserOut()

if(loginOutcome) {
    print("You just logged out")
} else {
    print("Was an error logging out!")
}

//STEP 2: Call Logout API
Task{
    do{
        let logoutResponseModel = try await loginAPI.logoutUser(username: loggedInUser)
        
        print(logoutResponseModel)
       
        if(logoutResponseModel.success == true) {
            print("API Logout worked!")
   
        } else {
            print("API Was an error logging out!")
        }
        
    } catch{
        print("yo man error!")
        print(error)
    }
}

//STEP 3: Navigate to Login Screen
PresenterManager.shared.showOnboarding()
*/

  

//GROUPS
//New Group
/*
Task{
    do{
        let newGroupResponseModel = try await groupsAPI.newGroup(currentUser: "davey", groupName: "music", groupType: "kite", groupPrivate: 1, groupUsers: ["davey", "sam",  "merry", "Frodo", "frodo", " pippin"], notificationMessage: "Invited you to a new Group", notificationType: "group_invite", notificationLink: "http://localhost:3003/group/77")
        
        if(newGroupResponseModel.statusCode == 401) {
            AuthManager.shared.logoutCurrentUser()
        }
        
        print(newGroupResponseModel)
        
     
    } catch{
        print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
        print(error)
        //AuthManager.shared.logoutCurrentUser()
    }
}
 */*/*/

//Get Group
/*
Task{
    do{
        let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
        
        if(groupsResponseModel.statusCode == 401) {
            AuthManager.shared.logoutCurrentUser()
        }
        
        print(groupsResponseModel)
        
   
    } catch{
        print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
        print(error)
        //AuthManager.shared.logoutCurrentUser()
    }
}
*/
