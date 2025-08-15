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

        //STEP 2: Get Caption Height (now includes 40pt fixed user info + dynamic text height)
        let postCaptionTextHeight = sizeFunctions.calculatePostCaptionHeight(from: currentPost.postCaption)
        //let postCaptionUserInfoHeight: CGFloat = 40 // Fixed height for user info section
        //let totalCaptionHeight = postCaptionUserInfoHeight + postCaptionTextHeight
        
    
        //STEP 3: Calculate total height (matching actual cell layout)
        // Fixed heights: header (52) + image (dynamic) + caption user info (28) + caption text (dynamic) + socials (32) + divider (2)
        let fixedHeights: CGFloat = 52 + 22 + 32 + 2
        
        // Total height = fixed heights + dynamic image height + dynamic caption text height
        let totalHeight = fixedHeights + postImageHeight + postCaptionTextHeight
        
        return totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Estimated height like IndividualPostViewController
    }
     
    
}


