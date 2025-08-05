//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


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
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingManager.stopPolling() // Stop polling when view goes away
    }

    
    //TABLE VIEW: Setup
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(HomePostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.homePostCell)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let postViewController = segue.destination as? IndividualPostViewController,
           let selectedPost = sender as? Post {
            postViewController.currentPost = selectedPost
            //postViewController.commentsArray = selectedPost.commentsArray ?? []
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
         //Constants.TableViewCellIdentifier.homePostCell could have a crashy error
         let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.homePostCell, for: indexPath) as! HomePostCell
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
        
        //STEP 1: Get Image Height
        let postImageHeight = sizeFunctions.calculatePostImageHeight(from: currentPost.postImageData)

        //STEP 1: Get Caption Height
        let postCaptionHeight = sizeFunctions.calculatePostCaptionHeight(from: currentPost.postCaption)
        
    
        //STEP 3: Calculate total height (matching actual cell layout)
        // Fixed heights: header (52) + image (dynamic) + caption (dynamic) + socials (48) + divider (2) = 142 + image
        let fixedHeights: CGFloat = 52 + 48 + 2
        
        // Total height = fixed heights + dynamic image height
        let totalHeight = fixedHeights + postImageHeight + postCaptionHeight
        
        return totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Estimated height like IndividualPostViewController
    }
     
    
}


/*
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     let currentPost = postDataController.posts[indexPath.row]
     let currentPostImage = currentPost.postImageData
     
     //STEP 1: Get Image Height
     //let defaultImage = UIImage(named: "background_1") ?? UIImage() // fallback to blank image
     //let currentImage = currentPostImage ?? defaultImage
     
     //let postImageHeightINSIDE = round(getImageHeight(image: currentImage))
     
     //STEP 2: Get Caption Height
     //let postCaption = currentPost.postCaption ?? "no caption"
     //let postCaptionHeightINSIDE = round(calculateLabelHeight(text: postCaption))
     
     //STEP 1: Get Image and Caption Heights
     let postImageHeight = sizeFunctions.calculatePostImageHeight(from: currentPost.postImageData)
     let postCaptionHeight = sizeFunctions.calculatePostCaptionHeight(from: currentPost.postCaption)
     
     //print("For Post")
     //print(currentPost.postCaption)
     //print("\(postImageHeightINSIDE) \(postImageHeight)")
     //print("\(postCaptionHeightINSIDE) \(postCaptionHeight)")

     //print(" ")
     
     
     //WORKS
     //return StyleConstants.postHeader + postImageHeight + StyleConstants.postSocials + postCaptionHeight + StyleConstants.postDivider
     //WORKS
     return 800
 }
 */

/*
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     let currentPost = postDataController.posts[indexPath.row]

     let postImageHeight = PostHeightHelper.calculatePostImageHeight(from: currentPost.postImageData)
     let postCaptionHeight = PostHeightHelper.calculatePostCaptionHeight(from: currentPost.postCaption)

     return StyleConstants.postHeader +
            postImageHeight +
            StyleConstants.postSocials +
            postCaptionHeight +
            StyleConstants.postDivider
 }
 */

/*
 //Temp: Debug
 Task {
     // Wait a tiny bit to let posts load before printing (if fetchPosts is still running)
     try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
     PostDataController.shared.debugPrintCommentLikes()
 }
 */
