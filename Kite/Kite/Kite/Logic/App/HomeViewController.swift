//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


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
        //print("STEP 1: fetchPosts")
        Task {
            do {
                //print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                for post in postsArray {
                    //print("post caption! \(post.postID)")
                    //print(post.postCaption)
                    //print("")
                }
                
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
        //postsTableView.estimatedRowHeight = 100
        //postsTableView.rowHeight = UITableView.automaticDimension
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPost = postsArray[indexPath.row]
        let currentPostImage = currentPost.postImageData
        
        //STEP 1: Get Image Height
        let defaultImage = UIImage(named: "background_1") ?? UIImage() // fallback to blank image
        let currentImage = currentPostImage ?? defaultImage
        
        let postImageHeight = round(getImageHeight(image: currentImage))
        
        //STEP 2: Get Caption Height
        let postCaption = currentPost.postCaption ?? "no caption"
        let postCaptionHeight = round(calculateLabelHeight(text: postCaption))
        
        
        //print("heightForRowAt postImageHeight \(postImageHeight) postCaptionHeight \(postCaptionHeight)")
        print(" ")
        print("We need this for our Caption Height \(postCaptionHeight) \(currentPost.postID)")
        print(postCaption)
        
        
        //footer + postImageHeight + captionTextHeight + 8 + comments
        //return 10 + postImageHeight + captionTextHeight + 8 + 40
        
        //Post User + Post Image + Post Socials + divider
        return 40 + postImageHeight + 40 
    }
    
}



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





